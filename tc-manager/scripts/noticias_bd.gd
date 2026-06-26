extends Node

const ENTRENAMIENTO_PROXIMO = preload("res://resources/noticias/ENTRENAMIENTO_PROXIMO.tres")
const ENTRENAMIENTO_EXITO = preload("uid://l4pwrbko6klm")
const ENTRENAMIENTO_TERMINADO = preload("uid://phvg0fq7tlgc")


func importar_plantilla(plantilla: Noticia, valores: Dictionary) -> Noticia:
	var noticia = Noticia.new()
	noticia.titulo = plantilla.titulo.format(valores)
	noticia.cuerpo = plantilla.cuerpo.format(valores)
	return noticia
