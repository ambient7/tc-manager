extends Control

signal dia_terminado

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
			itemInstancia.piloto_contratado.connect(_on_actualizar_ui)

func cargarPersonal(pilotos):
	for c in container_pilotos_personal.get_children():
		c.queue_free()
	for p in pilotos:
			var itemInstancia = itemPilotoPersonal.instantiate()
			container_pilotos_personal.add_child(itemInstancia)
			itemInstancia.ingresarPiloto(p)
			itemInstancia.piloto_a_entrenar.connect(_on_piloto_entrenar)

func actualizarUI(): 
	labelDias.text = "Dia " + str(Juego.diaActual)
	lab_dinero.text = "$" + str(Juego.get_dinero())
	pilotosDisponibles = Juego.pilotosDisponibles
	cargarPersonal(Juego.get_contratados())
	for c in container_pilotos_tienda.get_children():
		if c is Panel:
			c.actualizar_ui()
	
func _on_but_terminar_dia_pressed() -> void:
	emit_signal("dia_terminado")
	
func _on_actualizar_ui():
	actualizarUI()

func _on_piloto_entrenar(i,f):
	actualizarUI()
