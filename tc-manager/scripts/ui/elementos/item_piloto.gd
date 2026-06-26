extends Panel

@onready var label_nombre: Label = $labelNombre
@onready var label_habilidad: Label = $labelHabilidad
@onready var label_salario: Label = $labelSalario
@onready var ventana_equipo: Control = $"../../../../.."


var piloto: Piloto
signal piloto_contratado
signal piloto_a_entrenar(piloto)

var nombre
var habilidad
var salario


func ingresarPiloto(pilotoIngresado):
	piloto = pilotoIngresado
	label_nombre.text = str(pilotoIngresado.nombre + " " + pilotoIngresado.apellido)
	label_habilidad.text = "Habilidad: " + str(piloto.habilidad)
	label_salario.text = "Salario: $" + str(piloto.salario)

func actualizar_ui():
	pass
