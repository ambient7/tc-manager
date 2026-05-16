package entidades;
import java.util.*;
import java.util.ArrayList;

public abstract class Base {

    protected Equipo organizacion;
    protected int cicloActual = 1;
    protected int totalCiclos;

    public void iniciar() {
        configurarJuego();       // cada tema define esto
        while (cicloActual <= totalCiclos) {
            procesarCiclo();
            mostrarEstado();
            cicloActual++;
        }
        mostrarResultadoFinal();
    }

    protected abstract void configurarJuego();
    protected abstract void procesarCiclo();
    protected abstract void mostrarEstado();
    protected abstract void mostrarResultadoFinal();

}
