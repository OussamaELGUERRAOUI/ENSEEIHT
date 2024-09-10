/* ------------------------------------------------------- 
		Les packages Java qui doivent etre importes.
*/
import java.lang.*;
import java.awt.*;
import java.awt.event.*;
import java.applet.*;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.rmi.RemoteException;
import javax.swing.*;



/* ------------------------------------------------------- 
		Implementation de l'application
*/

public class Saisie extends JApplet {
	private static final long serialVersionUID = 1;
	TextField nom, email;
	Choice carnets;
	Label message;
	public void init() {
		setSize(300,200);
		setLayout(new GridLayout(6,2));
		add(new Label("  Nom : "));
		nom = new TextField(30);
		add(nom);
		add(new Label("  Email : "));
		email = new TextField(30);
		add(email);
		add(new Label("  Carnet : "));
		carnets = new Choice();
		carnets.addItem("Carnet1");
		carnets.addItem("Carnet2");
		add(carnets);
		add(new Label(""));
		add(new Label(""));
		Button Abutton = new Button("Ajouter");
		Abutton.addActionListener(new AButtonAction());
		add(Abutton);
		Button Cbutton = new Button("Consulter");
		Cbutton.addActionListener(new CButtonAction());
		add(Cbutton);
		message = new Label();
		add(message);
	}

	// La reaction au bouton Consulter
	class CButtonAction implements ActionListener {
		public void actionPerformed(ActionEvent ae) {
			String n, c;
			n = nom.getText();
			c = carnets.getSelectedItem();
			message.setText("Consulter("+n+","+c+")        ");


			try{
				Registry registry = LocateRegistry.getRegistry("localhost", 1234);
			    System.out.println("Registry located");

		
				if(c == "Carnet1"){
				
					Carnet c1 = (Carnet) registry.lookup("Carnet0");
					RFiche rf = c1.Consulter(n, true);
					if(rf != null){
						message.setText("Consulter("+n+","+c+") = ("+rf.getNom()+","+rf.getEmail()+")");
						System.out.println("Consulter("+n+","+c+") = ("+rf.getNom()+","+rf.getEmail()+")");
					}
					else{
						message.setText("Consulter("+n+","+c+") = null");
					}
				}
				
			
		
				else{
				
					Carnet c2 = (Carnet)registry.lookup("Carnet1");
					RFiche rf = c2.Consulter(n, true);
					if(rf != null){
						message.setText("Consulter("+n+","+c+") = ("+rf.getNom()+","+rf.getEmail()+")");
					}
					else{
						message.setText("Consulter("+n+","+c+") = null");
					}
				}
			
			
				
			}catch(Exception ex){
				ex.printStackTrace();
			
		}
	}
}
	// La reaction au bouton Ajouter
	class AButtonAction implements ActionListener {
		public void actionPerformed(ActionEvent ae) {
			String n, e, c;
			n = nom.getText();
			e = email.getText();
			c = carnets.getSelectedItem();
			message.setText("Ajouter("+n+","+e+","+c+")        ");
			
			if(c == "Carnet1"){
				try{
					// Localiser le registre RMI
			
					Registry registry = LocateRegistry.getRegistry("localhost", 1234);
			
					System.out.println("Registry located");
					
					// Chercher le carnet
					Carnet c1 = (Carnet) registry.lookup("Carnet0");
					SFiche sf = new SFicheImpl(n, e);
					c1.Ajouter(sf);
					message.setText("Ajouter("+n+","+e+","+c+") = OK");
				}
				catch(Exception ex){
					ex.printStackTrace();
				}
			}
			else{
				try{
					// Localiser le registre RMI
			
					Registry registry = LocateRegistry.getRegistry("localhost", 1234);
			
					System.out.println("Registry located");
					Carnet c2 = (Carnet) registry.lookup("Carnet1");
					SFiche sf = new SFicheImpl(n, e);
					c2.Ajouter(sf);
					System.out.println("Ajout effectue");
					message.setText("Ajouter("+n+","+e+","+c+") = OK");

				}
				catch(Exception ex){
					ex.printStackTrace();
				}
			}
		
			
		}
	}
	
	public static void main(String args[]) {
		Saisie a = new Saisie();
		a.init();
		a.start();
		JFrame frame = new JFrame("Applet");
		frame.setSize(400,200);
  	frame.getContentPane().add(a);
  	frame.setVisible(true);
	}
	
}


