extends Control

@onready var ventana_equipo: Control = $VentanaEquipo

var pilotos: Array[Piloto]
var mecanicos : Array[Mecanico]

func _ready() -> void:
	stock_tienda(3)

func _terminar_dia():
	Juego.avanzar_dia()
	Juego.pilotosDisponibles = []
	Juego.mecanicos_disponibles = []
	stock_tienda(3)
	if Juego.diaActual == 32:
		Juego.diaActual = 1
	ventana_equipo.actualizarUI()
	ventana_equipo.noticia_divisor()
	for p in Juego.equipo.pilotosContratados:
		entrenamiento(p)
	
func stock_tienda(cant) -> void:
	for x in cant:
		Juego.generar_piloto()
		pilotos = Juego.pilotosDisponibles
		var mec = Juego.generar_mecanico()
		Juego.mecanicos_disponibles.append(mec)
		mecanicos = Juego.mecanicos_disponibles
		
	ventana_equipo.stockearTienda(Juego.pilotosDisponibles,Juego.mecanicos_disponibles)

func entrenamiento(piloto: Piloto):
	if piloto.estado == Piloto.ESTADO_PILOTO.DISPONIBLE:
		return  # no hace nada si no está entrenando
	
	if piloto.entreno_restante > 0:
		piloto.habilidad += 1
		piloto.entreno_restante -= 1
		var noticia = NoticiasBd.importar_plantilla(
			NoticiasBd.ENTRENAMIENTO_EXITO,
			{"piloto": piloto.nombre + " " + piloto.apellido,
			"dias_restantes": piloto.entreno_restante
			}
		)
		ventana_equipo.agregar_noticia(noticia)
	elif piloto.entreno_restante == 0:
		piloto.estado = Piloto.ESTADO_PILOTO.DISPONIBLE
		var noticia = NoticiasBd.importar_plantilla(
			NoticiasBd.ENTRENAMIENTO_TERMINADO,
			{"piloto": piloto.nombre + " " + piloto.apellido
			}
		)
		ventana_equipo.agregar_noticia(noticia)


func _on_ventana_equipo_dia_terminado() -> void:
	_terminar_dia()
