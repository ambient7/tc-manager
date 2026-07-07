extends Node2D

const CAR = preload("uid://bfk75obdq66j6")
const MCQUEEN = preload("res://assets/311-3115851_rayo-mcqueen-wallpaper-disney-cars-lightning-mcqueen_13percent.png")

const ITEM_POSICION = preload("uid://cot5eqgor4siu")


@onready var simulador = $Simulador
@onready var label_vueltas: Label = $CanvasLayer/PanelSup/LabelVueltas
@onready var container_posiciones: VBoxContainer = $CanvasLayer/Posiciones/ContainerPosiciones


var pista: PistaBase

var sprites: Dictionary = {}  # piloto → Sprite2D


func _ready() -> void:
	pass

func preparaciones():
	simulador.progreso_actualizado.connect(_on_progreso_actualizado)
	
	add_child(pista)
	# Crear un sprite por cada piloto
	for estado in simulador.estados:
		var sprite = Sprite2D.new()
		sprite.texture = CAR
		add_child(sprite)
		sprites[estado.piloto] = sprite

func carrera_ejemplo():
	simulador.carrera_ejemplo(pista)

func _on_progreso_actualizado(estados):
	_actualizar_sprites(estados)
	_lista_posiciones(estados)

func _actualizar_sprites(ordenados) -> void:
	
	
	var lider = ordenados[0]
	
	label_vueltas.text = "Vuelta %d/%d" % [min(lider.vuelta_actual, pista.vueltas), pista.vueltas]
	
	for estado in simulador.estados:
		var pos = simulador.pista.progreso_a_posicion(estado.progreso_metros)
		sprites[estado.piloto].position = pos

func _lista_posiciones(posiciones):
	
	
	for c in container_posiciones.get_children():
		c.queue_free()
	
	for p in posiciones:
		var item_posicion = ITEM_POSICION.instantiate()
		var estado: int
		if p.termino == true:
			estado = 1
		else:
			estado = 0
		container_posiciones.add_child(item_posicion)
		item_posicion.actualizar_datos(p.lugar,p.piloto.apellido,estado,p.lugar)
	

func _on_but_vel_0_pressed() -> void:
	simulador.velocidad_sim = 0


func _on_but_vel_1_pressed() -> void:
	simulador.velocidad_sim = 1


func _on_but_vel_2_pressed() -> void:
	simulador.velocidad_sim = 4
