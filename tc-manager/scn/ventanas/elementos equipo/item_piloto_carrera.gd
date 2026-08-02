extends "res://scripts/ui/elementos/item_piloto.gd"

const CHECKMARK = preload("uid://ki6osksbg3g2")
const CROSS = preload("uid://lbws0x68g27p")
@onready var but_elegir: Button = $ButElegir

signal piloto_elegido(piloto)

func ingresarPiloto(pilotoIngresado):
	piloto = pilotoIngresado
	label_nombre.text = str(pilotoIngresado.nombre + " " + pilotoIngresado.apellido)
	label_habilidad.text = str(piloto.habilidad)
	label_salario.text = "Salario: $" + str(piloto.salario)

func desactivar():
	but_elegir.icon = CROSS
	but_elegir.disabled = true

func activar():
	but_elegir.icon = CHECKMARK
	but_elegir.disabled = false

func _on_but_elegir_pressed() -> void:
	piloto_elegido.emit(piloto)
