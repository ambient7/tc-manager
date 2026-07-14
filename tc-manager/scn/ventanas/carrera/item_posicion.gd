extends PanelContainer

@onready var label_posicion: Label = $HBoxContainer/Posición/LabelPosicion
@onready var label_nombre: Label = $HBoxContainer/LabelNombre
@onready var texture_rect: TextureRect = $HBoxContainer/TextureRect


const FLAG_CHECKERED = preload("uid://p5s3nsi4vfff")
const MEDAL_1_ST = preload("uid://cqdp3qle8fxyb")
const MEDAL_2_ND = preload("uid://bt8vcyd61xn5y")
const MEDAL_3_RD = preload("uid://dkcofp44rvygq")
const NODE_WARNING = preload("uid://dgjmtspryavlb")
const SKULL = preload("uid://bkutygbxro7yf")
const WRENCH = preload("uid://csi6ucctnlhaf")


var posicion
var nombre

func actualizar_datos(pos,nom,estado,lugar):
	label_posicion.text = str(pos)
	label_nombre.text = _formatear_apellido(nom)
	
	match estado:
		0:
			texture_rect.texture = null
		1:
			match lugar:
				1:
					texture_rect.texture = MEDAL_1_ST
				2:
					texture_rect.texture = MEDAL_2_ND
				3:
					texture_rect.texture = MEDAL_3_RD
				_:
					texture_rect.texture = FLAG_CHECKERED
		2:
			texture_rect.texture = WRENCH
	
func _formatear_apellido(apellido):
# Split the string by spaces and remove any extra empty spaces
	var palabras = apellido.split(" ", false)
	
	# Check if the string has exactly two words
	if palabras.size() == 2:
		var primero = palabras[0]
		var segundo = palabras[1]
		
		# Get the first character of the first word and append the second word
		return primero.substr(0, 1) + ". " + segundo
	
	# Return original string if it doesn't have exactly two words
	return apellido
