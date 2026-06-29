extends Node2D

const CAR = preload("uid://bfk75obdq66j6")
const MCQUEEN = preload("res://assets/311-3115851_rayo-mcqueen-wallpaper-disney-cars-lightning-mcqueen_13percent.png")


@onready var simulador: SimuladorCarrera = $Simulador
var sprites: Dictionary = {}  # piloto → Sprite2D

func _ready() -> void:
	simulador.progreso_actualizado.connect(_actualizar_sprites)
	
	# Crear un sprite por cada piloto
	for estado in simulador.estados:
		var sprite = Sprite2D.new()
		sprite.texture = CAR
		add_child(sprite)
		sprites[estado.piloto] = sprite

func _actualizar_sprites() -> void:
	for estado in simulador.estados:
		var pos = simulador.pista.progreso_a_posicion(estado.progreso_metros)
		sprites[estado.piloto].position = pos
