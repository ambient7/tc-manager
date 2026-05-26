package entidades;

public class GeneradorEntidades {
	
	private static final String[] NOMBRES = {"Alejo", "Carlos", "Luis", "Eduardo", "Fernando"};
    private static final String[] EQUIPOS = {"Red Bull", "Ferrari", "Mercedes"};
	
	
	public static Piloto generadorPiloto() {
		
		String nombre = NOMBRES[(int)(Math.random() * NOMBRES.length)];
        int id = (int)(Math.random() * 99) + 1;
        int experiencia = (int)(Math.random() * 100) / 10;
        return new Piloto(nombre, id, experiencia);
		
	}
	
}
