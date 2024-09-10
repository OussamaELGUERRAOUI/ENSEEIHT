package obstacle;

import java.awt.Shape;

public class Obstacle {
    private int x;
    private int y;
    private Shape shape;

    public Obstacle(int x, int y, Shape shape) {
        this.x = x;
        this.y = y;
        this.shape = shape;
    }

    public int getX() {
        return x;
    }

    public int getY() {
        return y;
    }

    public Shape getShape() {
        return shape;
    }
}
