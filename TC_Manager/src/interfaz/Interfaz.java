package interfaz;
import javax.swing.*;

import entidades.GeneradorEntidades;
import entidades.Piloto;
import entidades.Base;

import java.awt.event.*;

public class Interfaz implements ActionListener{
	
	JButton butTerminarDia;
	JLabel labelDia;

	
	public Interfaz() {
		
		// Creating instance of JFrame
        JFrame frame = new JFrame();

        // Creating instance of JButton
        butTerminarDia = new JButton(" Terminar dia");
        butTerminarDia.setBounds(500, 20, 120, 32);
        butTerminarDia.addActionListener(this);
        
        labelDia = new JLabel("Día: " + Base.getDiaActual());
        labelDia.setBounds(20,20, 100, 32);
        
        // adding butTerminarDia in JFrame
        frame.add(butTerminarDia);
        frame.add(labelDia);

        // 400 width and 500 height
        frame.setSize(640, 480);

        // using no layout managers
        frame.setLayout(null);

        // making the frame visible
        frame.setVisible(true);
        //frame.setDefaultCloseOperation(EXIT_ON_CLOSE);
	}

	public void actualizar() {

		labelDia.setText("Día: " + Base.getDiaActual());

	}

	public void actionPerformed(ActionEvent e) { 
	    if (e.getSource() == butTerminarDia) {
	    	
	    	Base.terminarDia();
	    	
	    }
	}
	
    public static void main(String[] args) {

		Interfaz interfaz = new Interfaz();

    }

}
