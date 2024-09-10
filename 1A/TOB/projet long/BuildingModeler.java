import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Graphics;
import java.awt.Point;
import java.awt.Rectangle;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.SwingUtilities;

public class BuildingModeler extends JFrame {
    private JPanel canvas;
    private List<Rectangle> rectangles;
    private Rectangle selectedRectangle;
    private Point lastMousePosition;

    public BuildingModeler() {
        setTitle("Building Modeler");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new BorderLayout());

        canvas = new JPanel() {
            @Override
            protected void paintComponent(Graphics g) {
                super.paintComponent(g);
                for (Rectangle rectangle : rectangles) {
                    g.setColor(Color.BLUE);
                    g.fillRect(rectangle.x, rectangle.y, rectangle.width, rectangle.height);
                }
            }
        };
        canvas.addMouseListener(new MouseAdapter() {
            @Override
            public void mousePressed(MouseEvent e) {
                lastMousePosition = e.getPoint();
                for (Rectangle rectangle : rectangles) {
                    if (rectangle.contains(lastMousePosition)) {
                        selectedRectangle = rectangle;
                        break;
                    }
                }
                if (selectedRectangle == null) {
                    Rectangle rectangle = new Rectangle(lastMousePosition);
                    rectangles.add(rectangle);
                    selectedRectangle = rectangle;
                }
                canvas.repaint();
            }

            @Override
            public void mouseReleased(MouseEvent e) {
                selectedRectangle = null;
            }
        });
        canvas.addMouseMotionListener(new MouseAdapter() {
            @Override
            public void mouseDragged(MouseEvent e) {
                if (selectedRectangle != null) {
                    int deltaX = e.getX() - lastMousePosition.x;
                    int deltaY = e.getY() - lastMousePosition.y;
                    selectedRectangle.translate(deltaX, deltaY);
                    lastMousePosition = e.getPoint();
                    canvas.repaint();
                }
            }
        });
        add(canvas, BorderLayout.CENTER);

        JPanel buttonPanel = new JPanel();
        JButton addWallButton = new JButton("Add Wall");
        addWallButton.addActionListener(e -> {
            rectangles.add(new Rectangle(lastMousePosition));
            canvas.repaint();
        });
        buttonPanel.add(addWallButton);
        add(buttonPanel, BorderLayout.SOUTH);

        rectangles = new ArrayList<>();
        pack();
        setVisible(true);
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(BuildingModeler::new);
    }
}
