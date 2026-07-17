@icon("res://addons/at-icons/node2d/racing_circuit.svg")
extends Node2D
class_name PistaBase

const CIRCLE = preload("uid://b3gglwjddwpfl")
const CIRCLE_RED = preload("uid://k7yaqg7tt7b4")
const WRENCH = preload("uid://cik3jkita2l11")
const FLAG_CHECKERED = preload("uid://droi8jqbfw4m")

@onready var sprites_segmentos: Node2D = $SpritesSegmentos
@onready var sprites_puntos: Node2D = $SpritesPuntos


@export var nombre_pista: String = ""
@export var vueltas: int = 3
@export var longitud_total: int = 0
@export var boxes: int
@export var boxes_salida: int
@export var segmentos: Array[SegmentoPista] = []
@export var path: Path2D
@export var path_boxes: Path2D
@export var debug_segmentos: bool = false
@export var debug_puntos: bool = false


func _ready() -> void:
	var longitud_path = path.curve.get_baked_length()
	var longitud_sim = longitud_total_metros()

	var ratio = fmod(boxes, longitud_sim) / longitud_sim
	var posicion_local = path.curve.sample_baked(ratio * longitud_path)

	print("Entrada: " , path.to_global(posicion_local))
	
	ratio = fmod(boxes_salida, longitud_sim) / longitud_sim
	posicion_local = path.curve.sample_baked(ratio * longitud_path)
	
	print("Salida: " , path.to_global(posicion_local))
	
func _process(delta) -> void:
	if debug_segmentos:
		var metro = 0
		var longitud_path = path.curve.get_baked_length()
		var longitud_sim = longitud_total_metros()
		for child in sprites_segmentos.get_children():
			child.queue_free()
		for m in longitud_sim:
			var ratio = fmod(metro, longitud_sim) / longitud_sim
			var posicion_local = path.curve.sample_baked(ratio * longitud_path)
			var sprite = Sprite2D.new()
			var segmento = get_segmento_en(metro)
			if segmento != null:
				if segmento.tipo == segmento.TIPO.RECTA:
					sprite.texture = CIRCLE
					sprites_segmentos.add_child(sprite)
				if segmento.tipo == segmento.TIPO.CURVA:
					sprite.texture = CIRCLE_RED
					sprites_segmentos.add_child(sprite)
			else:
				sprite.texture = null
			if metro == 0:
				var totalfunc = func():
					var total = 0.0
					for s in segmentos: 
						total += s.longitud
					return total
				var total = totalfunc.call()
				print(total)
			sprite.position = path.to_global(posicion_local)
			metro += 1


	if debug_puntos:
		var metro = 0
		var longitud_path = path.curve.get_baked_length()
		var longitud_sim = longitud_total_metros()
		for child in sprites_puntos.get_children():
			child.queue_free()
		for m in longitud_sim:
			var ratio = fmod(metro, longitud_sim) / longitud_sim
			var posicion_local = path.curve.sample_baked(ratio * longitud_path)
			var sprite = Sprite2D.new()
			if metro == boxes:
				sprite.texture = WRENCH
				sprites_puntos.add_child(sprite)
				sprite.position = path.to_global(posicion_local)
			if metro == boxes_salida:
				sprite.texture = WRENCH
				sprites_puntos.add_child(sprite)
				sprite.position = path.to_global(posicion_local)
				sprite.flip_v = true
			if metro == 0:
				sprite.texture = FLAG_CHECKERED
				sprites_puntos.add_child(sprite)
				sprite.position = path.to_global(posicion_local)
			
			metro += 1


func longitud_total_metros() -> float:
	if longitud_total == 0:
		var total = 0.0
		for s in segmentos: 
			total += s.longitud
		return total
	else:
		return longitud_total
		

func get_segmento_en(ubicacion_metros: float) -> SegmentoPista:
	var acumulado = 0.0
	for s in segmentos:
		acumulado += s.longitud
		if ubicacion_metros <= acumulado:
			return s
	return null  # fallback al último

func progreso_a_posicion(metros: float) -> Vector2:
	var longitud_path = path.curve.get_baked_length()
	var longitud_sim = longitud_total_metros()

	var ratio = fmod(metros, longitud_sim) / longitud_sim
	var posicion_local = path.curve.sample_baked(ratio * longitud_path)

	return path.to_global(posicion_local)
