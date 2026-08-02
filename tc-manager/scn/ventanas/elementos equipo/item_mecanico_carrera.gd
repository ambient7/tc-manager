extends "res://scripts/ui/elementos/item_piloto.gd"

const CHECKMARK = preload("uid://ki6osksbg3g2")
const CROSS = preload("uid://bprhcoty4m42s")
@onready var but_elegir: Button = $ButElegir

signal mecanico_elegido(mecanico)
signal mecanico_removido(mecanico)

var estado:bool = false


func ingresar_mecanico(mecanico_ingresado):
	mecanico = mecanico_ingresado
	label_nombre.text = str(mecanico_ingresado.nombre + " " + mecanico_ingresado.apellido)
	label_habilidad.text = str(mecanico.habilidad)
	
func cruz():
	but_elegir.icon = CROSS
	estado = false

func check():
	but_elegir.icon = CHECKMARK
	estado = true

func desactivar():
	but_elegir.disabled = true

func activar():
	but_elegir.disabled = false

func _on_but_elegir_pressed() -> void:
	
	if estado:
		cruz()
		mecanico_removido.emit(mecanico)
	else:
		check()
		mecanico_elegido.emit(mecanico)
		
