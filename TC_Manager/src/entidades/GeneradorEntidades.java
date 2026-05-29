package entidades;

public class GeneradorEntidades {
	
	private static final String[] NOMBRES = {"Alejo", "Carlos", "Luis", "Eduardo", "Fernando", "Cristian"};
    private static final String[] APELLIDOS = { "González","Rodríguez","Gómez","Fernández","López","Martínez","Díaz","Pérez","Sánchez","Romero", "Cueva" , "Benitez", "Espindola"};

    private static final String[] EQUIPOS = {"Ford", "Chevrolet", "Renault"};
	
	
	public static Piloto generadorPiloto() {
		
		String nombre = NOMBRES[(int)(Math.random() * NOMBRES.length)];
        String apellido = APELLIDOS[(int)(Math.random() * APELLIDOS.length)];
        int id = (int)(Math.random() * 99) + 1;
        int experiencia = (int)(Math.random() * 100) / 10;
        return new Piloto(nombre, apellido, id, experiencia);
		
	}
	
}
