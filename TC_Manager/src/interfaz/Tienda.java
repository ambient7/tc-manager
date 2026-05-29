package interfaz;
import javax.swing.*;
import java.awt.event.*;

import entidades.Base;
import entidades.GeneradorEntidades;
import entidades.Piloto;

public class Tienda implements ActionListener{

    JButton butBuscar, butContratar;
    JLabel labelPiloto;

    public Tienda(){

        JFrame frame = new JFrame();

        butBuscar = new JButton("Buscar pilotos");
        butBuscar.setBounds(20,20,120,32);
        butBuscar.addActionListener(this);

        labelPiloto = new JLabel("Piloto");
        labelPiloto.setBounds(20,60,420,64);

        butContratar = new JButton("Contratar Piloto");
        butContratar.setBounds(20,120,120,32);

        frame.add(butBuscar);
        frame.add(labelPiloto);
        frame.add(butContratar);

        frame.setSize(640, 480);
        frame.setLayout(null);
        frame.setVisible(true);
        //frame.setDefaultCloseOperation(EXIT_ON_CLOSE);

    }

    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == butBuscar) {

            String nombre;
            int id;
            int xp;

            Piloto piloto = GeneradorEntidades.generadorPiloto();
            nombre = piloto.getNombre();
            String apellido = piloto.getApellido();
            id = piloto.getID();
            xp = piloto.getExperiencia();
            labelPiloto.setText("Nombre: "+ nombre + " " + apellido + " - Experiencia: " + xp);

        }
        if (e.getSource() == butContratar && Base.getDinero() >= 100){



        }
    }

    public static void main(String[] args) {

        Tienda interfaz = new Tienda();

    }
}
