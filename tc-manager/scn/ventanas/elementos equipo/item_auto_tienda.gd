extends "res://scn/ventanas/elementos equipo/item_auto.gd"
class_name ItemAutoTienda

@onready var lab_precio: Label = $LabPrecio
@onready var but_comprar: Button = $ButComprar

signal auto_comprado

func ingresar_auto(autoin:Auto):
	auto = autoin
	if autoin.imagen != null:
		texture_rect.texture = auto.imagen
	else:
		texture_rect.texture = PlaceholderTexture2D.new()
	lab_nombre.text = auto.nombre
	lab_precio.text = str("$" , auto.precio)
	
func actualizar_ui():
	if Juego.get_dinero() >= auto.precio:
		but_comprar.disabled = false
	else:
		but_comprar.disabled = true


func _on_but_comprar_pressed() -> void:
	if Juego.comprar_auto(auto):
		emit_signal("auto_comprado")
