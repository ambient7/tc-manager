extends Node

var equipo: Equipo
var diaActual: int = 1
var pilotosDisponibles: Array[Piloto] = []

const NOMBRES = [
	"Alejandro", "Alejo", "Alfonso", "Angel", "Antonio", "Arturo", 
	"Benjamin", "Bruno", "Carlos", "Cesar", "Cristian", 
	"Daniel", "David", "Diego", "Eduardo", "Emiliano", 
	"Emmanuel", "Enzo", "Elian", "Ernesto", "Felipe", "Fernando", 
	"Francisco", "Gabriel", "Gael", "Gerardo", "Gonzalo", 
	"Hector", "Hugo", "Ignacio", "Isaac", "Javier", 
	"Jesus", "Joaquin", "Jorge", "Jose", "Juan", 
	"Julian", "Leonardo", "Lorenzo", "Lucas", "Luis", 
	"Manuel", "Marcelo", "Marco", "Mario", "Martin", 
	"Mateo", "Miguel", "Nicolas", "Pablo", "Santiago", "Thiago" , "Vicente"
  ];

const APELLIDOS = [
	"Aguirre", "Alvarez", "Benitez", "Blanco", "Cabrera", 
	"Calderon", "Campos", "Castillo", "Castro", "Chavez", 
	"Contreras", "Cruz", "Cueva", "Delgado", "Diaz", "Dominguez", "Espindola",
	"Fernandez", "Flores", "Fuentes", "Garcia", "Gomez", 
	"Gonzalez", "Gutierrez", "Hernandez", "Herrera", "Juarez", 
	"Ledesma", "Lopez", "Luna", "Martinez", "Medina", 
	"Molina", "Morales", "Muñoz", "Navarro", "Ortega", 
	"Ortiz", "Peralta", "Pereyra", "Perez", "Ramirez", 
	"Ramos", "Rivera", "Rodriguez", "Rojas", "Romero", 
	"Ruiz", "Sanchez", "Silva", "Soto", "Vazquez"
	];

func _ready() -> void:
	equipo = Equipo.new()
	equipo.nombre = "Mi Equipo"
	equipo.calidad = 5
	equipo.reputacion = 100
	equipo.dinero = 10000

func avanzar_dia() -> void:
	diaActual += 1

func contratar_piloto(piloto: Piloto) -> bool: 
	if equipo.dinero >= piloto.salario:
		equipo.dinero -= piloto.salario
		piloto.contratado = true
		piloto.diaPago = diaActual
		equipo.pilotosContratados.append(piloto)
		pilotosDisponibles.erase(piloto)
		return true
	return false

func generar_nombre() -> String:
	var nomTemp = str( NOMBRES.get(randi_range( 0,len(NOMBRES)-1 )  )   )
	return nomTemp
	
func generar_apellido() -> String:
	var apeTemp = str( APELLIDOS.get(randi_range( 0,len(APELLIDOS)-1 )  )   )
	return apeTemp

func generar_piloto():
	var p = Piloto.new()
	var chanNom = randi_range(1,3)
	var chanApe = randi_range(1,3)
	
	if int(chanNom) < 3:
		p.nombre = generar_nombre()
	else:
		p.nombre = generar_nombre() + " " + generar_nombre()
		
	if int(chanApe) < 3:
		p.apellido = generar_apellido()
	else:
		p.apellido = generar_apellido() + " " + generar_apellido()
	
	p.habilidad = randi_range(1, equipo.calidad)
	p.agresividad = randi_range(20, 80)
	p.salario = p.habilidad * 1000
	p.contratado = true
	p.estado = "DISPONIBLE"
	pilotosDisponibles.append(p)

func get_dinero(): return equipo.dinero
func get_contratados(): return equipo.pilotosContratados
