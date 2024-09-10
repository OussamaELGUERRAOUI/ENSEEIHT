import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class MenuExample extends JFrame implements MouseListener {

    JPopupMenu popupMenu;

    public MenuExample() {
        super("Menu Example");
        setSize(400, 400);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

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

        // Crée le menu déroulant
        popupMenu = new JPopupMenu();
        popupMenu.add(new JMenuItem("1"));
        popupMenu.add(new JMenuItem("2"));
        popupMenu.add(new JMenuItem("3"));

        // Ajoute un écouteur de clic de souris à la fenêtre
        addMouseListener(this);
    }

    public void mouseClicked(MouseEvent e) {
        // Vérifie si le clic est un clic droit de souris
        if (e.getButton() == MouseEvent.BUTTON3) {
            // Affiche le menu déroulant à la position du clic de souris
            popupMenu.show(this, e.getX(), e.getY());
        }
    }

    public void mousePressed(MouseEvent e) {
    }

    public void mouseReleased(MouseEvent e) {
    }

    public void mouseEntered(MouseEvent e) {
    }

    public void mouseExited(MouseEvent e) {
    }

    public static void main(String[] args) {
        MenuExample menuExample = new MenuExample();
        menuExample.setVisible(true);
    }
}
