import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.util.ArrayList;
import java.awt.Graphics;

public class MovingPoints1 extends JFrame implements MouseListener, MouseMotionListener {
    private ArrayList<Point> points = new ArrayList<Point>();
    private Point selectedPoint = null;
    private JPopupMenu menu;
    private JMenuItem menuItem1, menuItem2, menuItem3;
    private JMenuItem menuItem4, menuItem5, menuItem6;
    private int x, y;

    public MovingPoints1() {
        super("Déplacer des points");
        menu = new JPopupMenu();
        menuItem1 = new JMenuItem("Dessiner un point");
        menuItem2 = new JMenuItem("Dessiner un rectangle");
        menuItem3 = new JMenuItem("Dessiner deux points avec distance de 2 cm");
        menuItem4 = new JMenuItem("Dessiner un cercle");
        menuItem5 = new JMenuItem("Dessiner un carré");
        menuItem6 = new JMenuItem("Dessiner un triangle");
        menu.add(menuItem1);
        menu.add(menuItem2);
        menu.add(menuItem3);
        menuItem1.add(menuItem4);
        menuItem1.add(menuItem5);
        menuItem2.add(menuItem6);
        menuItem1.addActionListener(new MenuItemListener());
        menuItem2.addActionListener(new MenuItemListener());
        menuItem3.addActionListener(new MenuItemListener());

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

    public void mouseClicked(MouseEvent e) {
        if (e.getButton() == MouseEvent.BUTTON3) {
            x = e.getX();
            y = e.getY();
            menu.show(this, x, y);
        }
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

    public void mousePressed(MouseEvent e) {
        // Sélectionner le point sur lequel l'utilisateur a cliqué
        selectedPoint = getSelectedPoint(e.getX(), e.getY());

        if (selectedPoint == null) {
            menu.show(this, e.getX(), e.getY());

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
        MovingPoints1 app = new MovingPoints1();
        app.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }

    class MenuItemListener implements ActionListener {
        public void actionPerformed(ActionEvent e) {
            if (e.getSource() == menuItem1) {
                points.add(new Point(x, y));
                repaint();
            } else if (e.getSource() == menuItem2) {
                points.add(new Point(x, y));
                repaint();
            } else if (e.getSource() == menuItem3) {
                points.add(new Point(x, y));
                repaint();

            }
        }
    }

}
