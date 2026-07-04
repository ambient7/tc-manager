@icon("res://addons/at-icons/node/brain.svg")
extends Node
class_name SimuladorCarrera

const GODPILOT = preload("uid://bkdmfe7dwaw4q")
const CRISTIAN = preload("uid://dfni46jgakjn1")

const CLIO = preload("uid://dn24e1vpgo35x")
const WHATSAPP_CAR = preload("uid://h224g3v14mm2")


const TIEMPO_PIT_STOP = 28.0           # segundos fijos
const DISTANCIA_REBASE_METROS = 15.0   # qué tan cerca deben estar para intentar rebase
const FACTOR_DESGASTE_CURVA = 2.5
const FACTOR_DESGASTE_RECTA = 1.0

@export var pista: PistaBase

var estados: Array[EstadoPilotoCarrera] = []
var estrategia_ia: EstrategiaIA
var velocidad_sim: float = 1.0
var corriendo: bool = false
var index_jugador: int = -1  # índice en `estados` que controla el jugador

signal vuelta_completada(estado: EstadoPilotoCarrera)
signal pit_stop_realizado(estado: EstadoPilotoCarrera, es_jugador: bool)
signal rebase_ocurrido(atacante: EstadoPilotoCarrera, defensor: EstadoPilotoCarrera, exito: bool)
signal carrera_terminada(resultados: Array)

signal progreso_actualizado  # la UI escucha esto

func carrera_ejemplo(p) -> void:
	var cantidad_corredores = 20
	var participantes: Array[Dictionary]
	for c in cantidad_corredores:
		var autorand = randi_range(0,1)
		if autorand == 0:
			participantes.append({"piloto":Juego.generar_piloto_simple(), "auto": WHATSAPP_CAR})
		elif autorand == 1:
			participantes.append({"piloto":Juego.generar_piloto_simple(), "auto": CLIO})
	iniciar(p,participantes,1)

func iniciar(p: PistaBase, participantes: Array, idx_jugador: int) -> void:
	pista = p
	estados.clear()
	estrategia_ia = EstrategiaIA.new()
	index_jugador = idx_jugador

	for i in participantes.size():
		var e = EstadoPilotoCarrera.new()
		e.piloto = participantes[i].piloto
		e.auto_data = participantes[i].auto
		e.lugar = i + 1
		e.progreso_metros += e.lugar * 16
		estados.append(e)
	
	emit_signal("progreso_actualizado")
	await get_tree().create_timer(3).timeout

	corriendo = true


func _process(delta: float) -> void:
	if not corriendo: 
		return
	
	var delta_time = delta * velocidad_sim
	var longitud_pista = pista.longitud_total_metros()
	var longitud_carrera = longitud_pista * pista.vueltas
	
	for i in estados.size():
		var estado = estados[i]
		if estado.termino:
			continue
			
		if estado.en_boxes:
			_procesar_boxes(estado, delta_time)
			continue
			
		if i != index_jugador:
			_evaluar_pit_ia(estado, longitud_pista, longitud_carrera)
			
		_avanzar_estado(estado, delta_time, longitud_pista)

		if estado.progreso_metros >= longitud_carrera:
			estado.termino = true
			estado.progreso_metros = longitud_carrera
		
	_chequear_rebases()
	_actualizar_lugares()
	emit_signal("progreso_actualizado")

func _procesar_boxes(estado: EstadoPilotoCarrera, dt: float) -> void:
	estado.tiempo_restante_boxes -= dt
	if estado.tiempo_restante_boxes <= 0.0:
		estado.en_boxes = false
		estado.auto_data.ruedas.restaurar()
		var es_jugador = estados.find(estado) == index_jugador
		pit_stop_realizado.emit(estado, es_jugador)

func _evaluar_pit_ia(estado: EstadoPilotoCarrera, longitud_pista: float, longitud_carrera: float) -> void:
	var vueltas_restantes = pista.vueltas - estado.vuelta_actual
	if estrategia_ia.debe_entrar_boxes(estado, vueltas_restantes):
		entrar_boxes(estado)

func entrar_boxes(estado: EstadoPilotoCarrera) -> void:
	estado.en_boxes = true
	estado.tiempo_restante_boxes = TIEMPO_PIT_STOP

func _avanzar_estado(estado: EstadoPilotoCarrera, dt: float, longitud_pista: float) -> void:
	var metros_en_vuelta = estado.progreso_en_vuelta_actual(longitud_pista)
	var segmento = pista.get_segmento_en(metros_en_vuelta)

	var velocidad = _calcular_velocidad(estado, segmento)
	estado.velocidad_actual = velocidad

	var metros_recorridos = (velocidad / 3.6) * dt
	estado.progreso_metros += metros_recorridos
	estado.tiempo_total += dt

	_aplicar_potencial(estado, segmento, dt)
	_aplicar_desgaste(estado, segmento, metros_recorridos)
	_chequear_nueva_vuelta(estado, longitud_pista)

func _calcular_velocidad(estado: EstadoPilotoCarrera, segmento: SegmentoPista) -> float:
	var motor = estado.auto_data.motor
	var ruedas = estado.auto_data.ruedas

	if segmento.tipo == SegmentoPista.TIPO.RECTA:
		return min(motor.velocidad_maxima, segmento.velocidad_max)
	else:
		var eficiencia = clamp(
			float(estado.piloto.habilidad) / float(segmento.habilidad_requerida),
			0.5, 1.0
		)
		var velocidad_angulo = 1.0
		match segmento.angulo:
			1:
				velocidad_angulo = 1.0
			2:
				velocidad_angulo = 1.2
			3:
				velocidad_angulo = 1.5
		return float(motor.aceleracion * velocidad_angulo) * eficiencia * ruedas.modificador_rendimiento()

func _aplicar_potencial(estado: EstadoPilotoCarrera, segmento: SegmentoPista, dt: float) -> void:
	if segmento.tipo == SegmentoPista.TIPO.RECTA:
		estado.potencial += float(estado.piloto.experiencia) * 0.1 * dt
	else:
		estado.potencial = 0.0

func _aplicar_desgaste(estado: EstadoPilotoCarrera, segmento: SegmentoPista, metros: float) -> void:
	var km = metros / 1000.0
	var factor = FACTOR_DESGASTE_CURVA if segmento.tipo == SegmentoPista.TIPO.CURVA else FACTOR_DESGASTE_RECTA
	estado.auto_data.ruedas.aplicar_desgaste(km, factor)

func _chequear_nueva_vuelta(estado: EstadoPilotoCarrera, longitud_pista: float) -> void:
	var vuelta_calculada = int(estado.progreso_metros / longitud_pista) + 1
	if vuelta_calculada > estado.vuelta_actual:
		estado.vuelta_actual = vuelta_calculada
		vuelta_completada.emit(estado)

func _chequear_rebases() -> void:
	for i in estados.size():
		for j in estados.size():
			if i == j:
				continue
			var a = estados[i]
			var b = estados[j]
			if a.en_boxes or b.en_boxes or a.termino or b.termino:
				continue

			var distancia = a.progreso_metros - b.progreso_metros
			# Solo el que va detrás puede intentar rebasar al que va adelante
			if distancia < 0 and abs(distancia) < DISTANCIA_REBASE_METROS:
				_intentar_rebase(a, b)

func _intentar_rebase(atacante: EstadoPilotoCarrera, defensor: EstadoPilotoCarrera) -> void:
	var longitud_pista = pista.longitud_total_metros()
	var metros_en_vuelta = atacante.progreso_en_vuelta_actual(longitud_pista)
	var segmento = pista.get_segmento_en(metros_en_vuelta)

	if segmento.tipo != SegmentoPista.TIPO.RECTA:
		return  # rebases solo en recta por ahora

	var ventaja = atacante.potencial - defensor.potencial
	var defensa = float(defensor.piloto.agresividad) * randf_range(0.8, 1.2)

	if ventaja > defensa:
		var temp = atacante.progreso_metros
		atacante.progreso_metros = defensor.progreso_metros + 0.5
		defensor.progreso_metros = temp - 0.5
		atacante.potencial = 0.0
		rebase_ocurrido.emit(atacante, defensor, true)
	elif ventaja > defensa * 0.7:
		atacante.potencial *= 0.5
		defensor.potencial *= 0.5
		rebase_ocurrido.emit(atacante, defensor, false)

func _actualizar_lugares() -> void:
	var ordenados = estados.duplicate()
	ordenados.sort_custom(func(a, b): return a.progreso_metros > b.progreso_metros)
	for i in ordenados.size():
		ordenados[i].lugar = i + 1

func _todos_terminaron() -> bool:
	for e in estados:
		if not e.termino:
			return false
	return true

func get_estado_jugador() -> EstadoPilotoCarrera:
	if index_jugador < 0 or index_jugador >= estados.size():
		return null
	return estados[index_jugador]
