extends Panel

@onready var label_nombre: Label = $labelNombre
@onready var label_habilidad: Label = $labelHabilidad
@onready var label_salario: Label = $labelSalario
@onready var ventana_equipo: Control = $"../../../../.."


var piloto: Piloto
var mecanico: Mecanico
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
	
func ingresar_mecanico(mecanico_ingresado):
	mecanico = mecanico_ingresado
	label_nombre.text = str(mecanico_ingresado.nombre + " " + mecanico_ingresado.apellido)
	label_habilidad.text = "Habilidad: " + str(mecanico.habilidad)
	label_salario.text = "Salario: $" + str(mecanico.salario)

func actualizar_ui():
	pass
