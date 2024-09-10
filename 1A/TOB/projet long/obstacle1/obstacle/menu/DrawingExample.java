import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class DrawingExample extends JFrame implements MouseListener, MouseMotionListener, ActionListener {
    private int x, y;
    private int pointSize = 10;
    private Color currentColor = Color.BLACK;
    private JPopupMenu colorMenu;
    private JMenuItem redMenuItem;
    private JMenuItem greenMenuItem;
    private JMenuItem blackMenuItem;

    public DrawingExample() {
        super("Draw Point Example");

        // Set up the JFrame
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(400, 400);
        setVisible(true);

        // Set up the JPopupMenu
        colorMenu = new JPopupMenu();
        redMenuItem = new JMenuItem("Red");
        greenMenuItem = new JMenuItem("Green");
        blackMenuItem = new JMenuItem("Black");
        redMenuItem.addActionListener(this);
        greenMenuItem.addActionListener(this);
        blackMenuItem.addActionListener(this);
        colorMenu.add(redMenuItem);
        colorMenu.add(greenMenuItem);
        colorMenu.add(blackMenuItem);

        // Add listeners to the JFrame
        addMouseListener(this);
        addMouseMotionListener(this);
    }

    public void paint(Graphics g) {
        super.paint(g);

        // Draw the point
        g.setColor(currentColor);
        g.fillOval(x - pointSize / 2, y - pointSize / 2, pointSize, pointSize);
    }

    public void mousePressed(MouseEvent e) {
        if (e.getButton() == MouseEvent.BUTTON1) {
            // Show the JPopupMenu at the current mouse position
            colorMenu.show(this, e.getX(), e.getY());
        }
    }

    public void mouseMoved(MouseEvent e) {
        // Save the current mouse position
        x = e.getX();
        y = e.getY();

        // Repaint the JFrame
        repaint();
    }

    // The remaining methods are not used in this example
    public void mouseReleased(MouseEvent e) {
    }

    public void mouseEntered(MouseEvent e) {
    }

    public void mouseExited(MouseEvent e) {
    }

    public void mouseClicked(MouseEvent e) {
    }

    public void mouseDragged(MouseEvent e) {
    }

    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == redMenuItem) {
            currentColor = Color.RED;
        } else if (e.getSource() == greenMenuItem) {
            currentColor = Color.GREEN;
        } else if (e.getSource() == blackMenuItem) {
            currentColor = Color.BLACK;
        }
    }

    public static void main(String[] args) {
        DrawingExample example = new DrawingExample();
    }
}
