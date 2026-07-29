extends Panel
class_name ItemAuto

@onready var texture_rect: TextureRect = $TextureRect
@onready var lab_nombre: Label = $LabNombre


var auto:Auto

func ingresar_auto(autoin:Auto):
	auto = autoin
	texture_rect.texture = auto.imagen
	lab_nombre.text = auto.nombre
