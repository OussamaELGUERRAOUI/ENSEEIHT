import java.awt.*;
import java.awt.event.*;
import java.util.ArrayList;
import javax.swing.*;

public class RectangleMovableResizable extends JFrame implements MouseListener, MouseMotionListener, ActionListener {
    private ArrayList<Rectangle> rectangles = new ArrayList<Rectangle>();
    private Rectangle selectedRectangle = null;
    private JPopupMenu popupMenu;
    private JMenuItem deleteMenuItem, resizeMenuItem, newRectangleMenuItem;

    public RectangleMovableResizable() {
        super("RectangleMovableResizable");

        // Créer un panneau de dessin pour dessiner les rectangles
        JPanel drawingPanel = new JPanel() {
            public void paintComponent(Graphics g) {
                super.paintComponent(g);
                for (Rectangle r : rectangles) {
                    g.setColor(Color.BLUE);
                    g.fillRect(r.x, r.y, r.width, r.height);
                }
            }
        };
        drawingPanel.setBackground(Color.WHITE);
        drawingPanel.addMouseListener(this);
        drawingPanel.addMouseMotionListener(this);
        getContentPane().add(drawingPanel);

        // Créer le menu contextuel
        popupMenu = new JPopupMenu();
        deleteMenuItem = new JMenuItem("Supprimer le rectangle");
        resizeMenuItem = new JMenuItem("Changer la taille");
        newRectangleMenuItem = new JMenuItem("Ajouter un rectangle");
        deleteMenuItem.addActionListener(this);
        resizeMenuItem.addActionListener(this);
        newRectangleMenuItem.addActionListener(this);
        popupMenu.add(deleteMenuItem);
        popupMenu.add(resizeMenuItem);
        popupMenu.add(newRectangleMenuItem);
        drawingPanel.setComponentPopupMenu(popupMenu);

        // Afficher la fenêtre
        setSize(400, 400);
        setVisible(true);
    }

    // Trouver le rectangle sélectionné
    private Rectangle getSelectedRectangle(int x, int y) {
        for (Rectangle r : rectangles) {
            if (r.contains(x, y)) {
                return r;
            }
        }
        return null;
    }

    // Implémenter les méthodes MouseListener et MouseMotionListener
    public void mouseClicked(MouseEvent e) {
        if (SwingUtilities.isLeftMouseButton(e)) {
            // Ajouter un nouveau rectangle si aucun rectangle n'est sélectionné
            if (selectedRectangle == null) {
                rectangles.add(new Rectangle(e.getX(), e.getY(), 50, 50));
                repaint();
            }
        }
    }

    public void mousePressed(MouseEvent e) {
        // Sélectionner le rectangle sur lequel l'utilisateur a cliqué
        selectedRectangle = getSelectedRectangle(e.getX(), e.getY());
    }

    public void mouseReleased(MouseEvent e) {
        // Désélectionner le rectangle lorsque l'utilisateur relâche le bouton de la
        // souris
        selectedRectangle = null;
    }

    public void mouseEntered(MouseEvent e) {
    }

    public void mouseExited(MouseEvent e) {
    }

    public void mouseDragged(MouseEvent e) {
        // Déplacer le rectangle sélectionné lorsque l'utilisateur le fait glisser
        if (selectedRectangle != null) {
            int dx = e.getX() - selectedRectangle.x;
            int dy = e.getY() - selectedRectangle.y;
            selectedRectangle.setLocation(e.getX(), e.getY());
            repaint();
        }
    }

    public void mouseMoved(MouseEvent e) {
    }

    // Implémenter la méthode actionPerformed pour gérer les actions du menu
    // contextuel
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == deleteMenuItem) {
            rectangles.remove(selectedRectangle);
            selectedRectangle = null;
            repaint();
        } else if (e.getSource() == resizeMenuItem) {
            int newWidth = Integer.parseInt(JOptionPane.showInputDialog("Entrez la nouvelle largeur"));
            int newHeight = Integer.parseInt(JOptionPane.showInputDialog("Entrez la nouvelle hauteur"));
            selectedRectangle.setSize(newWidth, newHeight);
            repaint();
        } else if (e.getSource() == newRectangleMenuItem) {
            rectangles.add(new Rectangle(50, 50, 50, 50));
            repaint();
        }
    }

    public static void main(String[] args) {
        RectangleMovableResizable app = new RectangleMovableResizable();
        app.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }
}
