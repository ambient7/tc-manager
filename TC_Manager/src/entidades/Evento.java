package entidades;
import java.util.*;
import java.util.ArrayList;

public class Evento {
    private String descripcion;
    private List<String> opciones;
    private List<Map<String, Double>> consecuencias; // una por opción

    // constructor, getters...

    public Map<String, Double> aplicarDecision(int opcionElegida) {
        return consecuencias.get(opcionElegida);
    }
}
