extends Control

@onready var ventana_equipo: Control = $VentanaEquipo

var pilotos: Array[Piloto]

func _ready() -> void:
	stock_tienda(30)

func _terminar_dia():
	Juego.avanzar_dia()
	Juego.pilotosDisponibles = []
	stock_tienda(3)
	ventana_equipo.actualizarUI()
	if Juego.diaActual == 32:
		Juego.diaActual = 1
	for p in Juego.equipo.pilotosContratados:
		entrenamiento(p)

func stock_tienda(cant) -> void:
	for x in cant:
		Juego.generar_piloto()
		pilotos = Juego.pilotosDisponibles
	ventana_equipo.stockearTienda(Juego.pilotosDisponibles)

func entrenamiento(piloto: Piloto):
	if piloto.entreno_restante > 0:
		piloto.habilidad += 1
		piloto.entreno_restante -= 1
	if piloto.entreno_restante == 0:
		piloto.estado = Piloto.ESTADO_PILOTO.DISPONIBLE


func _on_ventana_equipo_dia_terminado() -> void:
	_terminar_dia()
