extends Control

signal terminar_dia

#@onready var juego: Node = $"../Juego"
@onready var labelDias = $panDias/labelDias
@onready var lab_dinero: Label = $panDinero/labDinero
@onready var container_pilotos_tienda: VBoxContainer = $TabContainer/Contratar/ScrollContainer/containerPilotosTienda
@onready var container_pilotos_personal: VBoxContainer = $TabContainer/Equipo/ScrollContainer/containerPilotosPersonal
var itemPilotoTienda = preload("res://scn/ventanas/elementos equipo/item_piloto_tienda.tscn")
var itemPilotoPersonal = preload("res://scn/ventanas/elementos equipo/item_piloto_personal.tscn")
var pilotosDisponibles: Array[Piloto]

func _ready() -> void:
	actualizarUI()

func stockearTienda(pilotos):
	pilotosDisponibles = pilotos
	for c in container_pilotos_tienda.get_children():
		c.queue_free()
	var labPilotos = Label.new()
	labPilotos.text = "Pilotos disponibles:"
	labPilotos.custom_minimum_size.y = 32
	labPilotos.vertical_alignment = VERTICAL_ALIGNMENT_TOP
	container_pilotos_tienda.add_child(labPilotos)
	for p in pilotos:
			var itemInstancia = itemPilotoTienda.instantiate()
			container_pilotos_tienda.add_child(itemInstancia)
			itemInstancia.ingresarPiloto(p)
			itemInstancia.actualizarUI.connect(_on_actualizar_ui)

func cargarPersonal(pilotos):
	for c in container_pilotos_personal.get_children():
		c.queue_free()
	for p in pilotos:
			var itemInstancia = itemPilotoPersonal.instantiate()
			container_pilotos_personal.add_child(itemInstancia)
			itemInstancia.ingresarPiloto(p)
			itemInstancia.actualizarUI.connect(_on_actualizar_ui)

func actualizarUI(): 
	labelDias.text = "Dia " + str(Juego.diaActual)
	lab_dinero.text = "$" + str(Juego.get_dinero())
	pilotosDisponibles = Juego.pilotosDisponibles
	cargarPersonal(Juego.get_contratados())
	
func _on_but_terminar_dia_pressed() -> void:
	emit_signal("terminar_dia")
	
func _on_actualizar_ui():
	actualizarUI()
