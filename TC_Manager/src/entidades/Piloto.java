package entidades;
import java.util.*;
import java.util.ArrayList;

public class Piloto {
	private String nombre;
    private int id;
    private int experiencia;

    // Constructor con parámetros
    public Piloto(String nombre, int id, int experiencia) {
        this.nombre = nombre;   // "this" distingue el campo del parámetro
        this.id = id;
        this.experiencia = experiencia;
    }

    // Getters
    public String getNombre() { return nombre; }
    public int getID()    { return id; }
    public int getExperiencia(){ return experiencia; }

    // Setter
    public void setExperiencia(int experiencia) { this.experiencia = experiencia; }
    
    //add
    public void addExperiencia(int experiencia) { this.experiencia += experiencia; }
}
