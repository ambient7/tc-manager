@icon("res://addons/at-icons/node/brain.svg")
extends Node
class_name SimuladorCarrera

const GODPILOT = preload("uid://bkdmfe7dwaw4q")
const CLIO = preload("uid://dn24e1vpgo35x")


@export var pista: PistaBase
var estados: Array[EstadoPilotoCarrera] = []
var velocidad_sim: float = 1.0
var corriendo: bool = false

signal progreso_actualizado  # la UI escucha esto

func _ready() -> void:
	var pilotogod = EstadoPilotoCarrera.new()
	pilotogod.piloto = GODPILOT
	pilotogod.auto_data = CLIO
	estados.append(pilotogod)
	corriendo = true
	

func _process(delta: float) -> void:
	if not corriendo: return
	var dt = delta * velocidad_sim
	for estado in estados:
		if estado.en_boxes:
			estado.tiempo_boxes -= dt
			if estado.tiempo_boxes <= 0.0:
				estado.en_boxes = false
				estado.auto.ruedas.vida_actual = estado.auto.ruedas.vida_max
			continue
		
		var segmento = pista.get_segmento_en(estado.progreso_metros)
		estado.velocidad_actual = 200
		estado.progreso_metros += (estado.velocidad_actual / 3.6) * dt
		estado.tiempo_total += dt
		
	emit_signal("progreso_actualizado")

func calcular_velocidad(estado, segmento):
	
	
	pass

func tiempo_parada_boxes(auto: Auto) -> float:
	var tiempo_base = 25.0  # segundos fijos (entrada + salida del pit lane)
	var tiempo_cambio = 3.0  # segundos del cambio en sí
	return tiempo_base + tiempo_cambio

func hacer_pit_stop(auto: Auto) -> void:
	auto.ruedas.vida_actual = auto.ruedas.vida_max  # ruedas nuevas
	# en el futuro: podría reparar motor parcialmente, etc.
