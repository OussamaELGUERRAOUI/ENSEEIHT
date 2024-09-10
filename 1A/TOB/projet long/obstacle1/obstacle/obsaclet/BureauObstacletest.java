package obsaclet;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Point;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionListener;
import java.util.ArrayList;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;

public class BureauObstacleTest extends JFrame implements MouseListener, MouseMotionListener {
    private ArrayList<BureauObstacle> obstacles = new ArrayList<>();
    private BureauObstacle currentObstacle;
    private int offsetX, offsetY;
    private JButton addButton = new JButton("Ajouter");
    private JPanel drawingPanel = new JPanel() {
        protected void paintComponent(Graphics g) {
            super.paintComponent(g);
            Graphics2D g2d = (Graphics2D) g;
            for (BureauObstacle obstacle : obstacles) {
                obstacle.paint(g2d);
            }
        }
    };

    public BureauObstacleTest() {
        setTitle("Bureau Obstacle Test");
        setSize(400, 400);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new BorderLayout());

        drawingPanel.setBackground(Color.WHITE);
        drawingPanel.addMouseListener(this);
        drawingPanel.addMouseMotionListener(this);

        addButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                addObstacle();
            }
        });

        JPanel buttonPanel = new JPanel();
        buttonPanel.add(addButton);

        add(drawingPanel, BorderLayout.CENTER);
        add(buttonPanel, BorderLayout.SOUTH);
    }

    public void addObstacle() {
        int x = (int) (Math.random() * drawingPanel.getWidth());
        int y = (int) (Math.random() * drawingPanel.getHeight());
        int width = 50 + (int) (Math.random() * 50);
        int height = 50 + (int) (Math.random() * 50);
        BureauObstacle obstacle = new BureauObstacle(x, y, width, height);
        obstacles.add(obstacle);
        drawingPanel.repaint();
    }

    public void mousePressed(MouseEvent e) {
        Point point = e.getPoint();
        for (BureauObstacle obstacle : obstacles) {
            if (obstacle.getHitbox().contains(point)) {
                currentObstacle = obstacle;
                offsetX = point.x - obstacle.x;
                offsetY = point.y - obstacle.y;
                return;
            }
        }
    }

    public void mouseDragged(MouseEvent e) {
        if (currentObstacle != null) {
            Point point = e.getPoint();
            currentObstacle.x = point.x - offsetX;
            currentObstacle.y = point.y - offsetY;
            drawingPanel.repaint();
        }
    }

    public void mouseReleased(MouseEvent e) {
        currentObstacle = null;
    }

    public void mouseClicked(MouseEvent e) {
    }

    public void mouseEntered(MouseEvent e) {
    }

    public void mouseExited(MouseEvent e) {
    }

    public void mouseMoved(MouseEvent e) {
    }

    public static void main(String[] args) {
        BureauObstacleTest test = new BureauObstacleTest();
        test.setVisible(true);
    }
}
