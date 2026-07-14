extends RefCounted
class_name EstadoPilotoCarrera


var piloto: Piloto
var auto_data: Auto

# Posición en la carrera
var progreso_metros: float = 0.0    # metros totales recorridos (incluye vueltas)
var vuelta_actual: int = 1
var lugar: int = 0

# Física de simulación
var velocidad_actual: float = 0.0   # km/h actual
var potencial: float = 0.0          # acumulado en rectas, consumido en curvas

# Tiempo
var tiempo_total: float = 0.0       # segundos

# Boxes
var entrar_a_boxes = false
var en_boxes: bool = false
var tiempo_restante_boxes: float = 0.0

# Carrera terminada
var termino: bool = false

func progreso_en_vuelta_actual(longitud_pista: float) -> float:
	return fmod(progreso_metros, longitud_pista)
