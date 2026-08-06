extends Control

const CAR = preload("uid://bfk75obdq66j6")

const WRENCH = preload("uid://csi6ucctnlhaf")
const MCQUEEN = preload("res://assets/311-3115851_rayo-mcqueen-wallpaper-disney-cars-lightning-mcqueen_13percent.png")
const CAR_GREEN = preload("uid://cky2517iun4w5")
const ITEM_POSICION = preload("uid://cot5eqgor4siu")

const WHATSAPP_CAR = preload("uid://h224g3v14mm2")
const CLIO = preload("uid://dn24e1vpgo35x")
const PISTA_OBLIGADO = preload("uid://bsit7ymvkqkwk")

const VENTANA_EQUIPO = preload("uid://cq7phlle4mkm6")
const MASTER = preload("uid://7r7id01wel28")


const ITEM_PILOTO_CARRERA = preload("uid://r75t0y5p4pmi")
const ITEM_AUTO_CARRERA = preload("uid://cxfbghwrm4mmi")
const ITEM_MECANICO_CARRERA = preload("uid://cky3mh1wgo8xe")

const MEDAL_1_ST = preload("uid://cqdp3qle8fxyb")
const MEDAL_2_ND = preload("uid://bt8vcyd61xn5y")
const MEDAL_3_RD = preload("uid://dkcofp44rvygq")
const FLAG_CHECKERED = preload("uid://p5s3nsi4vfff")
const BADGE = preload("uid://bjoi1nyx4euar")


@onready var simulador = $Simulador
@onready var label_vueltas: Label = $CanvasLayer/PanelSup/LabelVueltas
@onready var container_posiciones: VBoxContainer = $CanvasLayer/Posiciones/ContainerPosiciones

@onready var sub_viewport: SubViewport = $AspectRatioContainer/SubViewportContainer/SubViewport
@onready var sub_viewport_container: SubViewportContainer = $AspectRatioContainer/SubViewportContainer


@onready var but_boxes: Button = $CanvasLayer/Controles/ButBoxes
@onready var ico_pendiente: TextureRect = $CanvasLayer/Controles/ButBoxes/IcoPendiente
@onready var ico_boxes: TextureRect = $CanvasLayer/Controles/ButBoxes/IcoBoxes

@onready var but_comenzar: Button = $CanvasIntro/Panel/ButComenzar
@onready var canvas_intro: CanvasLayer = $CanvasIntro
@onready var rich_pista: RichTextLabel = $CanvasIntro/Panel/RichPista
@onready var rich_vueltas: RichTextLabel = $CanvasIntro/Panel/RichVueltas
@onready var pilotos_container: VBoxContainer = $CanvasIntro/Panel/TabContainer/Personal/ScrollContainer/PanelContainer/PilotosContainer
@onready var autos_container: HFlowContainer = $CanvasIntro/Panel/TabContainer/Auto/ScrollContainerAutos/PanelContainer/AutosContainer
@onready var mecanicos_container: VBoxContainer = $CanvasIntro/Panel/TabContainer/Personal/ScrollContainerMecanicos/PanelContainer/MecanicosContainer
@onready var label_auto_elegido: Label = $CanvasIntro/Panel/TabContainer/Auto/LabelAutoElegido
@onready var label_piloto_elegido: Label = $CanvasIntro/Panel/TabContainer/Personal/LabelPilotoElegido
@onready var label_mecanico_elegido: Label = $CanvasIntro/Panel/TabContainer/Personal/LabelMecanicoElegido

@onready var canvas_resultados: CanvasLayer = $CanvasResultados
@onready var rich_posicion: RichTextLabel = $CanvasResultados/Panel/RichPosicion
@onready var rich_nombre: RichTextLabel = $CanvasResultados/Panel/RichNombre
@onready var texture_resultado: TextureRect = $CanvasResultados/Panel/TextureResultado
@onready var rich_recompensas: RichTextLabel = $CanvasResultados/Panel/ScrollRecompensas/PanelContainer/MarginContainer/RichRecompensas
@onready var rich_piloto: RichTextLabel = $CanvasResultados/Panel/ScrollPiloto/PanelContainer/MarginContainer/RichPiloto



var pista: PistaBase
var piloto_elegido: Piloto
var auto_elegido: Auto
var posicion_jugador: int
var premio_total: int
var premio_final: int
var mecanicos_elegidos: Array[Mecanico]
var sprites: Dictionary = {}  # piloto → Sprite2D


func _ready() -> void:
	if pista == null:
		setup(PISTA_OBLIGADO.instantiate(),150000)

func setup(pistain: PistaBase, premio:int):
	
	pista = pistain
	premio_total = premio
	
	if pista != null:
		rich_pista.text = "[font_size=30][b]" + pista.nombre_pista + "[/b][/font_size]"
		rich_vueltas.text = "[font_size=30]" + str(pista.vueltas) + " vueltas[/font_size]"
	
	if len(Juego.get_contratados()) == 0:
		for x in range(10):
			Juego.añadir_piloto(Juego.generar_piloto_simple())
			Juego.añadir_mecanico(Juego.generar_mecanico())
		
	if len(Juego.get_autos_comprados()) == 0:
		Juego.añadir_auto(WHATSAPP_CAR)
		Juego.añadir_auto(CLIO)
		
	
	var pilotos = Juego.get_contratados()
	var autos = Juego.get_autos_comprados()
	var mecanicos = Juego.get_mecanicos()
	
	if len(pilotos) > 0:
		for p in pilotos:
			var item = ITEM_PILOTO_CARRERA.instantiate()
			pilotos_container.add_child(item)
			item.ingresarPiloto(p)
			item.piloto_elegido.connect(elegir_piloto)
	
	if len(autos) > 0:
		for a in autos:
			var item = ITEM_AUTO_CARRERA.instantiate()
			autos_container.add_child(item)
			item.ingresar_auto(a)
			item.auto_elegido.connect(elegir_auto)
	
	if len(mecanicos) > 0:
		for m in mecanicos:
			var item = ITEM_MECANICO_CARRERA.instantiate()
			mecanicos_container.add_child(item)
			item.ingresar_mecanico(m)
			item.mecanico_elegido.connect(elegir_mecanico)
			item.mecanico_removido.connect(remover_mecanico)

func elegir_piloto(piloto:Piloto):
	
	piloto_elegido = piloto
	label_piloto_elegido.text = "Piloto:    " + piloto_elegido.nombre + " " + piloto_elegido.apellido
	
	check_comenzar()

func elegir_auto(auto:Auto):
	
	auto_elegido = auto
	label_auto_elegido.text = "Auto:    " + auto.nombre
	
	check_comenzar()

func elegir_mecanico(mecanico:Mecanico):
	
	mecanicos_elegidos.append(mecanico)
	var texto = ""

	for i in mecanicos_elegidos.size():
		texto += "   %d. %s\n" % [i + 1, mecanicos_elegidos[i].nombre + " " + mecanicos_elegidos[i].apellido]
	
	texto = "Mecanicos:\n" + texto
	
	label_mecanico_elegido.text = texto
	
	if len(mecanicos_elegidos) == 4:
		for c in mecanicos_container.get_children():
			if c.estado == false:
				c.desactivar()
	else:
		for c in mecanicos_container.get_children():
			c.activar()
			
	check_comenzar()
	
func remover_mecanico(mecanico:Mecanico):
	
	mecanicos_elegidos.erase(mecanico)
	
	var texto = ""

	for i in mecanicos_elegidos.size():
		texto += "   %d. %s\n" % [i + 1, mecanicos_elegidos[i].nombre + " " + mecanicos_elegidos[i].apellido]
	
	texto = "Mecanicos:\n" + texto
	
	label_mecanico_elegido.text = texto
	
	if len(mecanicos_elegidos) == 4:
		for c in mecanicos_container.get_children():
			if c.estado == false:
				c.desactivar()
	else:
		for c in mecanicos_container.get_children():
			c.activar()
	
	check_comenzar()

func check_comenzar():
	if piloto_elegido != null and auto_elegido != null:
		but_comenzar.disabled = false
	else:
		but_comenzar.disabled = true


func preparaciones():
	simulador.progreso_actualizado.connect(_on_progreso_actualizado)
	simulador.carrera_terminada.connect(terminar)
	
	sub_viewport_container.add_child(pista)
	# Crear un sprite por cada piloto
	for estado in simulador.estados:
		
		var sprite = Sprite2D.new()
		
		if estado.jugador:
			sprite.texture = CAR_GREEN
		else:
			sprite.texture = CAR
		add_child(sprite)
		sprites[estado.piloto] = sprite

func carrera_ejemplo():
	simulador.carrera_ejemplo(pista)

func carrera():
	simulador.carrera(pista,mecanicos_elegidos,piloto_elegido,auto_elegido)

func _on_progreso_actualizado(estados):
	_actualizar_sprites(estados)
	_lista_posiciones(estados)

func _actualizar_sprites(ordenados) -> void:
	var lider = ordenados[0]
	
	label_vueltas.text = "Vuelta %d/%d" % [min(lider.vuelta_actual, pista.vueltas), pista.vueltas]
	
	for estado in simulador.estados:
		var pos = simulador.pista.progreso_a_posicion(estado.progreso_metros)
		sprites[estado.piloto].position = pos
	
	var estado_boxes = simulador.get_estado_boxes_jugador()
	match estado_boxes:
		1:
			boxes_no()
		2:
			boxes_si()
		3:
			en_boxes()
	
func _lista_posiciones(posiciones):
	
	
	for c in container_posiciones.get_children():
		c.queue_free()
	
	for p in posiciones:
		var item_posicion = ITEM_POSICION.instantiate()
		var estado: int
		if p.termino == true:
			estado = 1
		elif p.en_boxes:
			estado = 2
		else:
			estado = 0
		
		if p.jugador:
			posicion_jugador = p.lugar
			
		
		container_posiciones.add_child(item_posicion)
		item_posicion.actualizar_datos(p.lugar,p.piloto.apellido,estado,p.lugar,p.jugador)
	
func boxes_si():
	but_boxes.text = "Cancelar"
	but_boxes.disabled = false
	
	ico_pendiente.visible = true
	ico_boxes.visible = false
	
func boxes_no():
	but_boxes.text = "Entrar a boxes"
	but_boxes.disabled = false
	
	ico_pendiente.visible = false
	ico_boxes.visible = false
	
func en_boxes():
	but_boxes.text = "Boxes..."
	but_boxes.disabled = true

	ico_pendiente.visible = false
	ico_boxes.visible = true


func terminar(ordenados,jugador):
	canvas_resultados.visible = true
	match posicion_jugador:
		1:
			premio_final = premio_total
			texture_resultado.texture = MEDAL_1_ST
			rich_posicion.text = "[font_size=30][b]Primer puesto[/b][/font_size]"
		2:
			premio_final = premio_total / 1.5
			texture_resultado.texture = MEDAL_2_ND
			rich_posicion.text = "[font_size=30][b]Segundo puesto[/b][/font_size]"
		3:
			premio_final = premio_total / 2
			texture_resultado.texture = MEDAL_3_RD
			rich_posicion.text = "[font_size=30][b]Tercer puesto[/b][/font_size]"
		var r when r > 3 and r <= 10:
			premio_final = premio_total / 4
			texture_resultado.texture = BADGE
			rich_posicion.text = "[font_size=30][b]Puesto " + str(posicion_jugador)  + "[/b][/font_size]"
		var r when r > 10:
			premio_final = 0
			texture_resultado.texture = FLAG_CHECKERED
			rich_posicion.text = "[font_size=30][b]Puesto " + str(posicion_jugador)  + "[/b][/font_size]"
	
	rich_nombre.text = jugador.piloto.nombre + " " + jugador.piloto.apellido
	
	var texto = "[ul]
	$ " + str(premio_final) +"[/ul]"
	
	rich_recompensas.text = texto
	
	Juego.add_dinero(premio_final)
	
	print("premio total" + str(premio_total))
	print("premio " + str(premio_final))
	
	
func _on_but_vel_0_pressed() -> void:
	simulador.velocidad_sim = 0


func _on_but_vel_1_pressed() -> void:
	simulador.velocidad_sim = 1


func _on_but_vel_2_pressed() -> void:
	simulador.velocidad_sim = 100

func _on_but_boxes_pressed() -> void:
	simulador.entrar_boxes_jugador()


func _on_but_comenzar_pressed() -> void:
	canvas_intro.queue_free()
	carrera()
	preparaciones()


func _on_but_continuar_pressed() -> void:
	self.get_parent().add_child(MASTER.instantiate())

	queue_free()
