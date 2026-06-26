extends PanelContainer
class_name ItemNoticia

@export var titulo: String
@export var cuerpo: String

@onready var label_titulo: Label = $MarginContainer/VBoxContainer/LabelTitulo
@onready var label_cuerpo: Label = $MarginContainer/VBoxContainer/LabelCuerpo



func actualizar_texto():
	label_titulo.text = titulo
	label_cuerpo.text = cuerpo


func importar_noticia(noticia):
	label_titulo.text = noticia.titulo
	label_cuerpo.text = noticia.cuerpo
