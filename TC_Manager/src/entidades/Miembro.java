package entidades;
import java.util.*;
import java.util.ArrayList;

public abstract class Miembro {
    protected String nombre;
    protected Map<String, Integer> atributos; // "velocidad", "experiencia", etc.
    protected double salario;

    public Miembro(String nombre, double salario) {
        this.nombre = nombre;
        this.salario = salario;
        this.atributos = new HashMap<>();
    }

    public int getAtributo(String clave) {
        return atributos.getOrDefault(clave, 0);
    }
}
