extends "res://scripts/ui/elementos/item_piloto.gd"

@onready var ico_ocupado: RichTextLabel = $icoOcupado
@onready var but_entrenar: Button = $butEntrenar
@onready var but_despedir: Button = $butDespedir
@onready var label_experiencia: Label = $labelExperiencia

@onready var win_entrenar: Window = $WinEntrenar
@onready var numero_dias: SpinBox = $WinEntrenar/Control/NumeroDias


func ingresarPiloto(pilotoIngresado):
	piloto = pilotoIngresado
	label_nombre.text = str(pilotoIngresado.nombre + " " + pilotoIngresado.apellido)
	label_habilidad.text = "Habilidad: " + str(piloto.habilidad)
	label_salario.text = "Salario: $" + str(piloto.salario)
	label_experiencia.text = "Experiencia: " + str(piloto.habilidad)
	if piloto.estado != Piloto.ESTADO_PILOTO.DISPONIBLE:
		ico_ocupado.visible = true
		but_despedir.disabled = true
		but_entrenar.disabled = true
	else:
		ico_ocupado.visible = false
		but_despedir.disabled = false
		but_entrenar.disabled = false



func _on_but_entrenar_pressed() -> void:
	win_entrenar.show()
	
	
func _on_win_entrenar_close_requested() -> void:
	win_entrenar.hide()


func _on_but_win_entrenar_pressed() -> void:
	piloto.estado = Piloto.ESTADO_PILOTO.ENTRENARA
	piloto.comienzo_entreno = Juego.diaActual
	piloto.fin_entreno = piloto.comienzo_entreno + int(numero_dias.value)
	piloto.entreno_restante =  int(numero_dias.value)
	emit_signal("piloto_a_entrenar", piloto.comienzo_entreno, piloto.fin_entreno)
	
	win_entrenar.hide()
