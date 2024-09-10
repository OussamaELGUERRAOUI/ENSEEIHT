package obstacle;

import javax.swing.*;

import obsaclet.BureauObstacle;
import obsaclet.ChaiseObstacle;

import java.awt.*;
import java.awt.event.*;
import java.util.ArrayList;

public class afficherObstacle extends JFrame {
    private JPanel drawingArea;
    private JMenuBar menuBar;
    private JMenu obstacleMenu;
    private JMenuItem bureauMenuItem, chaiseMenuItem;

    private ArrayList<Obstacle> obstacles = new ArrayList<>();

    public afficherObstacle() {
        super("Obstacle Simulator");

        // Set up the drawing area
        drawingArea = new JPanel() {
            @Override
            protected void paintComponent(Graphics g) {
                super.paintComponent(g);
                for (Obstacle o : obstacles) {
                    o.paint(g);
                }
            }
        };
        drawingArea.setBackground(Color.WHITE);
        drawingArea.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                // Add new obstacle to the list
                Obstacle o = null;
                if (bureauMenuItem.isSelected()) {
                    o = new BureauObstacle(e.getX(), e.getY(), 50, 50);
                } else if (chaiseMenuItem.isSelected()) {
                    o = new ChaiseObstacle(e.getX(), e.getY(), 50, Color.BLACK);
                }
                if (o != null) {
                    obstacles.add(o);
                    drawingArea.repaint();
                }
            }
        });
        add(drawingArea);

        // Set up the menu bar
        menuBar = new JMenuBar();
        obstacleMenu = new JMenu("Obstacle");
        bureauMenuItem = new JCheckBoxMenuItem("Bureau");
        chaiseMenuItem = new JCheckBoxMenuItem("Chaise");
        ButtonGroup group = new ButtonGroup();
        group.add(bureauMenuItem);
        group.add(chaiseMenuItem);
        obstacleMenu.add(bureauMenuItem);
        obstacleMenu.add(chaiseMenuItem);
        menuBar.add(obstacleMenu);
        setJMenuBar(menuBar);

        // Set up the frame
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(600, 400);
        setLocationRelativeTo(null);
        setVisible(true);
    }

    public static void main(String[] args) {
        afficherObstacle frame = new afficherObstacle();
    }
}
