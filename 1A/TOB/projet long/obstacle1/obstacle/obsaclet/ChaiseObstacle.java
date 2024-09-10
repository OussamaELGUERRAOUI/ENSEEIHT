package obsaclet;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Shape;
import java.awt.geom.Path2D;

public class ChaiseObstacle {
    private int taille;
    private Color couleur;
    int x, y;

    public ChaiseObstacle(int x, int y, int taille, Color couleur) {
        this.x = x;
        this.y = y;
        this.taille = taille;
        this.couleur = couleur;
    }

    public void setX(int x) {
        this.x = x;
    }

    public int getX() {
        return this.x;
    }

    public void setY(int y) {
        this.y = y;
    }

    public int getY() {
        return this.y;
    }

    public void setTaille(int taille) {
        this.taille = taille;
    }

    public int getTaille() {
        return this.taille;
    }

    public void setCouleur(Color couleur) {
        this.couleur = couleur;
    }

    public Color getCouleur() {
        return this.couleur;
    }

    public Shape getHitbox() {
        int centerX = getX();
        int centerY = getY();
        int size = getTaille();
        Path2D.Double path = new Path2D.Double();
        path.moveTo(centerX, centerY - size / 2);
        path.lineTo(centerX + size / 2, centerY + size / 2);
        path.lineTo(centerX - size / 2, centerY + size / 2);
        path.closePath();
        return path;
    }

    public void paint(Graphics g) {
        Graphics2D g2d = (Graphics2D) g;
        Shape hitbox = getHitbox();
        g2d.setColor(Color.RED);
        g2d.draw(hitbox);
        g2d.setColor(getCouleur());
        g2d.fill(hitbox);
    }

}
