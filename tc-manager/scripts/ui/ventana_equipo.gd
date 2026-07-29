extends Control

signal dia_terminado

@onready var labelDias = $panDias/labelDias
@onready var lab_dinero: Label = $panDinero/labDinero
@onready var container_pilotos_tienda: VBoxContainer = $TabContainer/Contratar/ScrollContainer/containerPilotosTienda
@onready var container_pilotos_personal: VBoxContainer = $TabContainer/Equipo/ScrollContainer/containerPilotosPersonal
@onready var noticia_container: VBoxContainer = $TabContainer/Noticias/Panel/ScrollContainer/NoticiaContainer
@onready var container_autos_tienda: HFlowContainer = $TabContainer/Tienda/ScrollContainer/ContainerAutosTienda


const ITEM_NOTICIA = preload("uid://djeskgjksc266")
const ITEM_EVENTO = preload("uid://bw020ca4arlcy")
const SEPARADOR_DIA = preload("uid://bkfgpdps85n61")
var itemPilotoTienda = preload("res://scn/ventanas/elementos equipo/item_piloto_tienda.tscn")
var itemPilotoPersonal = preload("res://scn/ventanas/elementos equipo/item_piloto_personal.tscn")
const ITEM_MECANICO_TIENDA = preload("uid://dveh6dl5vl442")
const ITEM_MECANICO = preload("uid://oy6qfcljq85r")
const ITEM_AUTO_TIENDA = preload("uid://b2ogtsvskoxsi")
const ITEM_AUTO_EQUIPO = preload("uid://dfas7vddxo3qw")


var pilotosDisponibles: Array[Piloto]
var mecanicos_disponibles: Array[Mecanico]

var autos_todos: Array[Auto]

func _ready() -> void:
	_cargar_autos_todos()
	stockear_autos()
	actualizarUI()

func stockearTienda(pilotos,mecanicos):
	pilotosDisponibles = pilotos
	mecanicos_disponibles = mecanicos
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
	var labMecanicos = Label.new()
	labMecanicos.text = "Mecanicos disponibles:"
	labMecanicos.custom_minimum_size.y = 32
	labMecanicos.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	container_pilotos_tienda.add_child(labMecanicos)
	for m in mecanicos:
		var itemInstancia = ITEM_MECANICO_TIENDA.instantiate()
		container_pilotos_tienda.add_child(itemInstancia)
		itemInstancia.ingresar_mecanico(m)
		itemInstancia.mecanico_contratado.connect(_on_actualizar_ui)
			
func cargarPersonal(pilotos, mecanicos, autos):
	for c in container_pilotos_personal.get_children():
		c.queue_free()
	for p in pilotos:
			var itemInstancia = itemPilotoPersonal.instantiate()
			container_pilotos_personal.add_child(itemInstancia)
			itemInstancia.ingresarPiloto(p)
			itemInstancia.piloto_a_entrenar.connect(_on_piloto_entrenar)
	var labMecanicos = Label.new()
	labMecanicos.text = "Mecanicos:"
	labMecanicos.custom_minimum_size.y = 32
	labMecanicos.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	container_pilotos_personal.add_child(labMecanicos)
	for m in mecanicos:
			var itemInstancia = ITEM_MECANICO.instantiate()
			container_pilotos_personal.add_child(itemInstancia)
			itemInstancia.ingresar_mecanico(m)
			
	var lab_autos = Label.new()
	lab_autos.text = "Autos en posesión:"
	lab_autos.custom_minimum_size.y = 32
	lab_autos.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	container_pilotos_personal.add_child(lab_autos)
	
	var container_autos = HFlowContainer.new()
	container_autos.set_h_size_flags(SIZE_EXPAND_FILL)
	container_autos.set_v_size_flags(SIZE_EXPAND_FILL)
	container_pilotos_personal.add_child(container_autos)
	
	for a in autos:
		var itemInstancia = ITEM_AUTO_EQUIPO.instantiate()
		container_autos.add_child(itemInstancia)
		itemInstancia.ingresar_auto(a)
		
func stockear_autos():
	
	for c in container_autos_tienda.get_children():
		c.queue_free()
	for a in autos_todos:
		var auto_item = ITEM_AUTO_TIENDA.instantiate()
		container_autos_tienda.add_child(auto_item)
		auto_item.auto_comprado.connect(actualizarUI)
		auto_item.ingresar_auto(a)
	
func actualizarUI(): 
	labelDias.text = "Dia " + str(Juego.diaActual)
	lab_dinero.text = "$" + str(Juego.get_dinero())
	pilotosDisponibles = Juego.pilotosDisponibles
	mecanicos_disponibles = Juego.mecanicos_disponibles
	cargarPersonal(Juego.get_contratados(), Juego.get_mecanicos(), Juego.get_autos_comprados())
	for c in container_pilotos_tienda.get_children():
		if c is Panel:
			c.actualizar_ui()
	
	for c in container_autos_tienda.get_children():
		if c is Panel:
			c.actualizar_ui()

func _cargar_autos_todos():
	var path_autos = "res://resources/autitardos/"
	
	# Open the directory
	var dir = DirAccess.open(path_autos)
	if not dir:
		push_error("Failed to open directory: " + path_autos)
		return

	# Begin scanning the directory contents
	dir.list_dir_begin()
	var file_name = dir.get_next()

	while file_name != "":
		# Ensure it's a file, not a directory or a hidden file
		if not dir.current_is_dir() and not file_name.begins_with("."):
			# Crucial export fix: skip .import files and load the original file name
			if not file_name.ends_with(".import"):
				var full_path = path_autos.path_join(file_name)
				var resource = load(full_path)
				
				if resource:
					autos_todos.append(resource)
					
		file_name = dir.get_next()
		
	dir.list_dir_end()
	
	for a in autos_todos:
		print(a.nombre)
	
func noticia_divisor():
	var item = SEPARADOR_DIA.instantiate()
	item.get_child(0).text = "Dia " + str(Juego.diaActual)
	noticia_container.add_child(item)
	noticia_container.move_child(item,0)

func agregar_noticia(noticia: Noticia) -> void:
	var item = ITEM_NOTICIA.instantiate()
	noticia_container.add_child(item)
	noticia_container.move_child(item,0)
	item.importar_noticia(noticia)
	
func _on_but_terminar_dia_pressed() -> void:
	emit_signal("dia_terminado")
	
func _on_actualizar_ui():
	actualizarUI()

func _on_piloto_entrenar(piloto):
	actualizarUI()
	var noticia = NoticiasBd.importar_plantilla(NoticiasBd.ENTRENAMIENTO_PROXIMO,
	{ "piloto": piloto.nombre + " " + piloto.apellido }
	)
	
	agregar_noticia(noticia)
