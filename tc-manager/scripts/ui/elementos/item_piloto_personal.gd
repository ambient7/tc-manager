extends "res://scripts/ui/elementos/item_piloto.gd"

@onready var ico_ocupado: RichTextLabel = $icoOcupado
@onready var but_entrenar: Button = $butEntrenar
@onready var but_despedir: Button = $butDespedir

func ingresarPiloto(pilotoIngresado):
	piloto = pilotoIngresado
	label_nombre.text = str(pilotoIngresado.nombre + " " + pilotoIngresado.apellido)
	label_habilidad.text = "Habilidad: " + str(piloto.habilidad)
	label_salario.text = "Salario: $" + str(piloto.salario)
	if piloto.estado != "DISPONIBLE":
		ico_ocupado.visible = true
		but_despedir.disabled = true
		but_entrenar.disabled = true
	else:
		ico_ocupado.visible = false
		but_despedir.disabled = false
		but_entrenar.disabled = false
