import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.util.ArrayList;
import java.awt.Graphics;

public class MovingPoints extends JFrame implements MouseListener, MouseMotionListener {
    private ArrayList<Point> points = new ArrayList<Point>();
    private Point selectedPoint = null;


    public MovingPoints() {
        super("Déplacer des points");

        

        // Créer un panneau de dessin pour dessiner les points
        JPanel drawingPanel = new JPanel() {
            public void paintComponent(Graphics g) {
                super.paintComponent(g);
                for (Point p : points) {
                    g.setColor(Color.RED);
                    g.fillRect(p.x - 5, p.y - 5, 20, 20);
                }
            }
        };
        drawingPanel.setBackground(Color.WHITE);
        drawingPanel.addMouseListener(this);
        drawingPanel.addMouseMotionListener(this);
        getContentPane().add(drawingPanel);

        // Afficher la fenêtre
        setSize(400, 400);
        setVisible(true);
    }

    // Trouver le point sélectionné
    private Point getSelectedPoint(int x, int y) {
        for (Point p : points) {
            if (p.distance(x, y) <= 20) {
                return p;
            }
        }
        return null;
    }

    // Implémenter les méthodes MouseListener et MouseMotionListener
    public void mouseClicked(MouseEvent e) {
    }

    public void mousePressed(MouseEvent e) {
        // Sélectionner le point sur lequel l'utilisateur a cliqué
        selectedPoint = getSelectedPoint(e.getX(), e.getY());
        
        if (selectedPoint == null) {
            // Si aucun point n'a été sélectionné, ajouter un nouveau point
            points.add(new Point(e.getX(), e.getY()));
            repaint();
                
            }
            
            

        }

    

    public void mouseReleased(MouseEvent e) {
        // Désélectionner le point lorsque l'utilisateur relâche le bouton de la souris
        selectedPoint = null;
    }

    public void mouseEntered(MouseEvent e) {
    }

    public void mouseExited(MouseEvent e) {
    }

    public void mouseDragged(MouseEvent e) {
        // Déplacer le point sélectionné lorsque l'utilisateur le fait glisser
        if (selectedPoint != null) {
            selectedPoint.setLocation(e.getX(), e.getY());
            repaint();
        }
    }

    public void mouseMoved(MouseEvent e) {
    }

    public static void main(String[] args) {
        MovingPoints app = new MovingPoints();
        app.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }
}
