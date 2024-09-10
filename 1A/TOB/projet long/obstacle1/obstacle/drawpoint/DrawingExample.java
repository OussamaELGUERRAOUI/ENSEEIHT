package drawpoint;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Point;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.util.ArrayList;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;

public class DrawingExample extends JPanel {
    private ArrayList<Point> points = new ArrayList<Point>();
    private JButton drawButton = new JButton("Draw point");
    private Color color = Color.black;
    private Point selectedPoint = null;
    
    public DrawingExample() {
        add(drawButton);
        drawButton.addMouseListener(new MouseAdapter() {
            public void mousePressed(MouseEvent e) {
                ColorChoiceFrame colorFrame = new ColorChoiceFrame();
                color = colorFrame.getColor();
                points.add(e.getPoint());
                repaint();
            }
        });
        
        addMouseListener(new MouseAdapter() {
            public void mousePressed(MouseEvent e) {
                for (Point p : points) {
                    if (p.distance(e.getPoint()) <= 10) {
                        selectedPoint = p;
                        break;
                    }
                }
            }
            
            public void mouseReleased(MouseEvent e) {
                selectedPoint = null;
            }
        });
        
        addMouseMotionListener(new MouseAdapter() {
            public void mouseDragged(MouseEvent e) {
                if (selectedPoint != null) {
                    selectedPoint.setLocation(e.getPoint());
                    repaint();
                }
            }
        });
    }
    
    public void paintComponent(Graphics g) {
        super.paintComponent(g);
        g.setColor(color);
        for (Point p : points) {
            g.fillOval(p.x - 5, p.y - 5, 10, 10);
        }
    }
    
    public static void main(String[] args) {
        JFrame frame = new JFrame("Drawing Example");
        frame.setSize(400, 400);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.add(new DrawingExample());
        frame.setVisible(true);
    }
}
