@icon("res://addons/at-icons/node2d/racing_circuit.svg")
extends Node2D
class_name PistaBase

const CIRCLE = preload("uid://b3gglwjddwpfl")
const CIRCLE_RED = preload("uid://k7yaqg7tt7b4")


@export var nombre_pista: String = ""
@export var vueltas: int = 3
@export var segmentos: Array[SegmentoPista] = []
@export var path: Path2D
@export var debug: bool = false

func _process(delta) -> void:
	if debug:
		var metro = 0
		var longitud_path = path.curve.get_baked_length()
		var longitud_sim = longitud_total_metros()
		for m in longitud_sim:
			var ratio = fmod(metro, longitud_sim) / longitud_sim
			var posicion_local = path.curve.sample_baked(ratio * longitud_path)
			var sprite = Sprite2D.new()
			var segmento = get_segmento_en(metro)
			if segmento.tipo == segmento.TIPO.RECTA:
				sprite.texture = CIRCLE
			elif segmento.tipo == segmento.TIPO.CURVA:
				sprite.texture = CIRCLE_RED
			add_child(sprite)
			sprite.position = path.to_global(posicion_local)
			metro += 1

func longitud_total_metros() -> float:
	var total = 0.0
	for s in segmentos: 
		total += s.longitud
	return total

func get_segmento_en(ubicacion_metros: float) -> SegmentoPista:
	var acumulado = 0.0
	for s in segmentos:
		acumulado += s.longitud
		if ubicacion_metros <= acumulado:
			return s
	return segmentos[-1]  # fallback al último

func progreso_a_posicion(metros: float) -> Vector2:
	var longitud_path = path.curve.get_baked_length()
	var longitud_sim = longitud_total_metros()

	var ratio = fmod(metros, longitud_sim) / longitud_sim
	var posicion_local = path.curve.sample_baked(ratio * longitud_path)

	return path.to_global(posicion_local)
