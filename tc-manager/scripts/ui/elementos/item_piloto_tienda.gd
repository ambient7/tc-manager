extends "res://scripts/ui/elementos/item_piloto.gd"

@onready var but_tienda: Button = $butTienda


func ingresarPiloto(pilotoIngresado):
	piloto = pilotoIngresado
	label_nombre.text = str(pilotoIngresado.nombre + " " + pilotoIngresado.apellido)
	label_habilidad.text = "Habilidad: " + str(piloto.habilidad)
	label_salario.text = "Salario: $" + str(piloto.salario)
	if Juego.get_dinero() >= piloto.salario:
		but_tienda.disabled = false
	else:
		but_tienda.disabled = true

func actualizar_ui():
	if Juego.get_dinero() >= piloto.salario:
		but_tienda.disabled = false
	else:
		but_tienda.disabled = true

func _on_but_tienda_pressed() -> void:
	if Juego.contratar_piloto(piloto):
		emit_signal("piloto_contratado")
	queue_free()
	
