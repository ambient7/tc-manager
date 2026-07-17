extends "res://scripts/ui/elementos/item_piloto.gd"

signal mecanico_contratado


@onready var button: Button = $Button


func ingresar_mecanico(mecanico_ingresado:Mecanico):
	mecanico = mecanico_ingresado
	label_nombre.text = str(mecanico.nombre + " " + mecanico.apellido)
	label_habilidad.text = "Habilidad: " + str(mecanico.habilidad)
	label_salario.text = "Salario: $" + str(mecanico.salario)

func actualizar_ui():
	if Juego.get_dinero() >= mecanico.salario:
		button.disabled = false
	else:
		button.disabled = true


func _on_button_pressed() -> void:
	if Juego.contratar_mecanico(mecanico):
		emit_signal("mecanico_contratado")
	queue_free()
