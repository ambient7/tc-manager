extends Node2D

const CAR = preload("uid://bfk75obdq66j6")
const MCQUEEN = preload("res://assets/311-3115851_rayo-mcqueen-wallpaper-disney-cars-lightning-mcqueen_13percent.png")


@onready var simulador = $Simulador
@onready var label_vueltas: Label = $CanvasLayer/PanelSup/LabelVueltas

var pista: PistaBase

var sprites: Dictionary = {}  # piloto → Sprite2D


func _ready() -> void:
	pass

func preparaciones():
	simulador.progreso_actualizado.connect(_actualizar_sprites)
	add_child(pista)
	# Crear un sprite por cada piloto
	for estado in simulador.estados:
		var sprite = Sprite2D.new()
		sprite.texture = CAR
		add_child(sprite)
		sprites[estado.piloto] = sprite

func carrera_ejemplo():
	simulador.carrera_ejemplo(pista)

func _actualizar_sprites() -> void:
	
	var ordenados = simulador.actualizar_lugares() # ya ordena por 'lugar', devolvé el array ordenado
	var lider = ordenados[0]

	label_vueltas.text = "Vuelta %d/%d" % [min(lider.vuelta_actual, pista.vueltas), pista.vueltas]
	
	for estado in simulador.estados:
		var pos = simulador.pista.progreso_a_posicion(estado.progreso_metros)
		sprites[estado.piloto].position = pos


func _on_but_vel_0_pressed() -> void:
	simulador.velocidad_sim = 0


func _on_but_vel_1_pressed() -> void:
	simulador.velocidad_sim = 1


func _on_but_vel_2_pressed() -> void:
	simulador.velocidad_sim = 4
