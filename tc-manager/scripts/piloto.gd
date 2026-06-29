@icon("res://addons/at-icons/node/steering_wheel.svg")
extends Resource
class_name Piloto


enum ESTADO_PILOTO {
	
	DISPONIBLE,
	ENTRENARA,
	ENTRENANDO,
	PRACTICANDO
	
}

@export var nombre: String
@export var apellido: String

@export var experiencia: int
@export var habilidad: int
@export var agresividad: int # variable secreta

@export var salario: int
@export var diaPago: int
@export var contratado:bool

@export var estado: ESTADO_PILOTO
@export var comienzo_entreno: int
@export var fin_entreno: int
@export var entreno_restante: int
