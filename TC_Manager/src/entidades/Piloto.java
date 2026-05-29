package entidades;
import java.util.*;
import java.util.ArrayList;

public class Piloto {
	private String nombre;
    private String apellido;
    private int id;
    private int experiencia;

    // Constructor con parámetros
    public Piloto(String nombre, String apellido, int id, int experiencia) {
        this.nombre = nombre;   // "this" distingue el campo del parámetro
        this.apellido = apellido;
        this.id = id;
        this.experiencia = experiencia;
    }

    // Getters
    public String getNombre() { return nombre; }
    public String getApellido() {return apellido;}
    public int getID()    { return id; }
    public int getExperiencia(){ return experiencia; }

    // Setter
    public void setExperiencia(int experiencia) { this.experiencia = experiencia; }
    
    //add
    public void addExperiencia(int experiencia) { this.experiencia += experiencia; }
}
