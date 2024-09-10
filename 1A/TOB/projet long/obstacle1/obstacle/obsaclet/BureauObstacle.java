package obsaclet;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Shape;
import java.awt.geom.AffineTransform;
import java.awt.geom.Rectangle2D;

public class BureauObstacle {
    private int largeur;
    private int longueur;
    private Color color = Color.BLACK;
    int x, y;

    public BureauObstacle(int x, int y, int largeur, int longueur) {
        this.x = x;
        this.y = y;
        this.largeur = largeur;
        this.longueur = longueur;
    }

    public Shape getHitbox() {
        int centerX = x;
        int centerY = y;
        int width = largeur / 2;
        int height = longueur / 2;
        Rectangle2D.Double rect = new Rectangle2D.Double(centerX - width, centerY - height, largeur, longueur);
        Double angle = Math.atan(x / y);
        AffineTransform transform = AffineTransform.getRotateInstance(angle, centerX, centerY);
        Shape transformedRect = transform.createTransformedShape(rect);
        return transformedRect;
    }

    public void paint(Graphics g) {
        Graphics2D g2d = (Graphics2D) g;
        Shape hitbox = getHitbox();
        g2d.setColor(color);
        g2d.fill(hitbox);
    }

}
