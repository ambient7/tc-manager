extends Control

#escena para testear pistas

@export var pista: PackedScene

@onready var carrera: Node2D = $Carrera


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	carrera.pista = pista.instantiate()
	carrera.carrera_ejemplo()
	carrera.preparaciones()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
