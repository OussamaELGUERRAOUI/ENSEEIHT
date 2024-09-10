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

class ColorChoiceFrame extends JFrame {
    private JButton greenButton = new JButton("Green");
    private JButton redButton = new JButton("Red");
    private JButton blackButton = new JButton("Black");
    private Color color = Color.black;
    
    public ColorChoiceFrame() {
        setSize(200, 100);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setLayout(new java.awt.FlowLayout());
        add(greenButton);
        add(redButton);
        add(blackButton);
        
        greenButton.addMouseListener(new MouseAdapter() {
            public void mousePressed(MouseEvent e) {
                color = Color.green;
                dispose();
            }
        });
        
        redButton.addMouseListener(new MouseAdapter() {
            public void mousePressed(MouseEvent e) {
                color = Color.red;
                dispose();
            }
        });
        
        blackButton.addMouseListener(new MouseAdapter() {
            public void mousePressed(MouseEvent e) {
                color = Color.black;
                dispose();
            }
        });
        
        setVisible(true);
    }
    
    public Color getColor() {
        return color;
    }
}

