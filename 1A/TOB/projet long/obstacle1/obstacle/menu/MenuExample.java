package menu;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
 
public class MenuExample extends JFrame implements MouseListener {
 
    private JPopupMenu menu;
    private JMenuItem menuItem1, menuItem2, menuItem3;
    private JMenuItem menuItem4, menuItem5, menuItem6;
    private int x, y;
 
    public MenuExample() {
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
        
        addMouseListener(this);
    }
 
    

    public void mouseClicked(MouseEvent e) {
        if (e.getButton() == MouseEvent.BUTTON3) {
            x = e.getX();
            y = e.getY();
            menu.show(this, x, y);
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
        MenuExample frame = new MenuExample();
        frame.setTitle("Menu Example");
        frame.setSize(400, 400);
        frame.setVisible(true);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }
 
    class MenuItemListener implements ActionListener {
        public void actionPerformed(ActionEvent e) {
            if (e.getSource() == menuItem1) {
                Graphics g = getGraphics();
                g.drawOval(x, y, 1, 1);
            } else if (e.getSource() == menuItem2) {
                Graphics g = getGraphics();
                g.drawRect(x, y, 50, 50);
            } else if (e.getSource() == menuItem3) {
                Graphics g = getGraphics();
                g.drawOval(x, y, 1, 1);
                g.drawOval(x + 40, y + 40, 1, 1);
            }
        }
    }
}

