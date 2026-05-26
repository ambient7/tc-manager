package entidades;
import java.util.*;
import java.util.ArrayList;

import interfaz.Interfaz;

public class Base {

    int diasTotal;
    
    public static void main(String[] args)
    {
        Interfaz ui = new Interfaz();
    }
    
    public void terminarDia() {
    	
    	diasTotal += 1;
    	
    }

}
