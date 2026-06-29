@icon("res://addons/at-icons/node/road.svg")
extends Resource
class_name SegmentoPista

enum TIPO { RECTA, CURVA }

@export var tipo: TIPO
@export var longitud: int          # metros
@export var habilidad_requerida: int   # para curvas
@export var aceleracion_requerida: int # para curvas
@export var velocidad_max: int         # límite del segmento
