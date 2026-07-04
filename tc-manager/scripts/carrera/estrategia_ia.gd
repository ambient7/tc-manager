class_name EstrategiaIA
extends RefCounted

const UMBRAL_VIDA_CRITICA = 0.25
const UMBRAL_RENDIMIENTO_MINIMO = 0.7

func debe_entrar_boxes(estado: EstadoPilotoCarrera, vueltas_restantes: int) -> bool:
	if estado.en_boxes:
		return false

	var vida = estado.auto_data.ruedas.porcentaje_vida()

	# No vale la pena entrar si es la última vuelta
	if vueltas_restantes <= 0:
		return false

	if vida < UMBRAL_VIDA_CRITICA:
		return true

	if estado.auto_data.ruedas.modificador_rendimiento() < UMBRAL_RENDIMIENTO_MINIMO:
		return true

	return false
