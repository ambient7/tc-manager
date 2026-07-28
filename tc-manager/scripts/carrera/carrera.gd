extends Node2D

const CAR = preload("uid://bfk75obdq66j6")

const WRENCH = preload("uid://csi6ucctnlhaf")
const MCQUEEN = preload("res://assets/311-3115851_rayo-mcqueen-wallpaper-disney-cars-lightning-mcqueen_13percent.png")
const CAR_GREEN = preload("uid://cky2517iun4w5")
const ITEM_POSICION = preload("uid://cot5eqgor4siu")


@onready var simulador = $Simulador
@onready var label_vueltas: Label = $CanvasLayer/PanelSup/LabelVueltas
@onready var container_posiciones: VBoxContainer = $CanvasLayer/Posiciones/ContainerPosiciones

@onready var but_boxes: Button = $CanvasLayer/Controles/ButBoxes
@onready var ico_pendiente: TextureRect = $CanvasLayer/Controles/ButBoxes/IcoPendiente
@onready var ico_boxes: TextureRect = $CanvasLayer/Controles/ButBoxes/IcoBoxes



var pista: PistaBase

var sprites: Dictionary = {}  # piloto → Sprite2D


func _ready() -> void:
	pass

func preparaciones():
	simulador.progreso_actualizado.connect(_on_progreso_actualizado)
	
	add_child(pista)
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
		container_posiciones.add_child(item_posicion)
		item_posicion.actualizar_datos(p.lugar,p.piloto.apellido,estado,p.lugar)
	
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

func _on_but_vel_0_pressed() -> void:
	simulador.velocidad_sim = 0


func _on_but_vel_1_pressed() -> void:
	simulador.velocidad_sim = 1


func _on_but_vel_2_pressed() -> void:
	simulador.velocidad_sim = 10

func _on_but_boxes_pressed() -> void:
	simulador.entrar_boxes_jugador()
