package obstacle;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Shape;
import java.awt.geom.Path2D;

import javax.swing.JFrame;
import javax.swing.JPanel;
import obstacle.obstacle;

public class dessinobstacle extends JFrame {
    private obstacle obstacle1, obstacle2;

    public dessinobstacle() {
        // création des obstacles
        obstacle1 = new obstacle(100, 100, 150, 150, Color.BLUE);
        obstacle2 = new obstacle(200, 200, 250, 250, Color.RED);

        // définition des paramètres de la fenêtre
        setTitle("Simulation de déplacement dans un bâtiment");
        setSize(400, 400);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(EXIT_ON_CLOSE);

        // ajout du panneau de dessin à la fenêtre
        JPanel panel = new JPanel() {
            @Override
            public void paintComponent(Graphics g) {
                super.paintComponent(g);

                // dessin des obstacles
                Shape shape1 = obstacle1.dessiner(g);
                Shape shape2 = obstacle2.dessiner(g);

                // dessin du contour des obstacles
                Graphics2D g2d = (Graphics2D) g;
                g2d.setColor(Color.BLACK);
                g2d.draw(shape1);
                g2d.draw(shape2);
            }
        };
        add(panel);
    }

    public static void main(String[] args) {
        ObstacleFrame frame = new dessinobstacle();
        frame.setVisible(true);
    }
}
