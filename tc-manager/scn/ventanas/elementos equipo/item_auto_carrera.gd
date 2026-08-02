extends ItemAuto

signal auto_elegido(auto)

func _on_elegir_pressed() -> void:
	auto_elegido.emit(auto)
