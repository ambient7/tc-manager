@icon("res://addons/at-icons/node/wheel.svg")
extends Resource
class_name Ruedas

@export var nombre: String = ""
@export var nivel: int = 1

@export var vida_max: float = 100.0
@export var vida_actual: float = 100.0
@export var desgaste_por_km: float = 2.0  # % por km — blandas ~4.0, duras ~1.5

func porcentaje_vida() -> float:
	return vida_actual / vida_max

func modificador_rendimiento() -> float:
	# Sin penalización hasta el 50% de vida
	var p = porcentaje_vida()
	if p > 0.5:
		return 1.0
	return 0.5 + p   # cae de 1.0 a 0.5 linealmente

func aplicar_desgaste(km: float, factor: float = 1.0) -> void:
	vida_actual -= desgaste_por_km * km * factor
	vida_actual = max(vida_actual, 0.0)

func restaurar() -> void:
	vida_actual = vida_max
