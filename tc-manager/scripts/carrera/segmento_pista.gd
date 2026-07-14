@icon("res://addons/at-icons/node/road.svg")
extends Resource
class_name SegmentoPista

enum TIPO { RECTA, CURVA }

@export var tipo: TIPO
@export var longitud: int          # metros
@export var velocidad_max: int         # límite del segmento
@export_group("Curvas")
@export_range(0,100,1.0) var habilidad_requerida: int   # para curvas
@export_range(0,3,1) var angulo: int
@export var aceleracion_requerida: int # para curvas
