extends Control

@onready var ventana_equipo: Control = $VentanaEquipo

var pilotos: Array[Piloto]

func _ready() -> void:
	stock_tienda(3)

func _terminar_dia():
	Juego.avanzar_dia()
	Juego.pilotosDisponibles = []
	stock_tienda(3)
	ventana_equipo.actualizarUI()
	if Juego.diaActual == 32:
		Juego.diaActual = 1
	

func stock_tienda(cant) -> void:
	for x in cant:
		Juego.generar_piloto()
		pilotos = Juego.pilotosDisponibles
	ventana_equipo.stockearTienda(Juego.pilotosDisponibles)


func _on_ventana_equipo_terminar_dia() -> void:
	_terminar_dia()
