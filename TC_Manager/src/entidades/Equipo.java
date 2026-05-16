package entidades;
import java.util.*;
import java.util.ArrayList;

public abstract class Equipo {
	
    protected String nombre;
    protected Map<String, Double> recursos; // "dinero", "reputacion", etc.
    protected List<Miembro> miembros;

    public Equipo(String nombre) {
        this.nombre = nombre;
        this.recursos = new HashMap<>();
        this.miembros = new ArrayList<>();
    }

    public void modificarRecurso(String tipo, double cantidad) {
        recursos.merge(tipo, cantidad, Double::sum);
    }

    public abstract String resumenEstado(); // cada tema lo implementa
	
}
