package entidades;

import interfaz.Interfaz;

public class Base {

    static int diaActual;
    static int dinero;
    Piloto piloto;


    public static void terminarDia() {diaActual += 1;}
    public static void modDinero(int op, int cant) {
        if(op == 1){dinero = dinero + cant;}
        else{dinero = dinero - cant;}
    }

    public void setPiloto(Piloto piloto) { this.piloto = piloto;};

    public static int getDiaActual() {return diaActual;}
    public static int getDinero() {return dinero;}

}
