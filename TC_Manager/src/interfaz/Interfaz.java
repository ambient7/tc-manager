package interfaz;
import java.io.*;
import javax.swing.*;

import entidades.GeneradorEntidades;
import entidades.Piloto;

import java.awt.*;
import java.awt.event.*;

public class Interfaz implements ActionListener{
	
	JButton button;
	JLabel textoPiloto;
	
	public Interfaz() {
		
		// Creating instance of JFrame
        JFrame frame = new JFrame();

        // Creating instance of JButton
        button = new JButton(" Generar piloto");
        button.setBounds(150, 200, 220, 50);
        button.addActionListener(this);
        
        textoPiloto = new JLabel("Nombre: \nExperiencia: \nID:");
        textoPiloto.setBounds(150,60, 400, 100);
        
        // adding button in JFrame
        frame.add(button);
        frame.add(textoPiloto);

        // 400 width and 500 height
        frame.setSize(500, 600);

        // using no layout managers
        frame.setLayout(null);

        // making the frame visible
        frame.setVisible(true);
		
		
		
	}
	
	public void actionPerformed(ActionEvent e) { 
	    if (e.getSource() == button) {
	    	
	    	String nombre;
	    	int id;
	    	int xp;
	    	
	    	Piloto piloto = GeneradorEntidades.generadorPiloto();
	    	nombre = piloto.getNombre();
	    	id = piloto.getID();
	    	xp = piloto.getExperiencia();
	    	textoPiloto.setText("Nombre: "+ nombre + " Experiencia: " + xp + " ID:" + id);
	    	
	    }
	}
	
    public static void main(String[] args) {
        Interfaz interfaz = new Interfaz();
    }
	
}
