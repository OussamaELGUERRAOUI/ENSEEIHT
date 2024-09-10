import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.canvas.Canvas;
import javafx.scene.canvas.GraphicsContext;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.BorderPane;
import javafx.scene.paint.Color;
import javafx.stage.Stage;

public class BuildingModeler extends Application {

    private double startX, startY, endX, endY;
    private boolean isDrawing;
    private boolean isMoving;
    private double mouseX, mouseY;
    private Rectangle selectedRectangle;

    public static void main(String[] args) {
        launch(args);
    }

    @Override
    public void start(Stage primaryStage) throws Exception {
        BorderPane root = new BorderPane();
        Canvas canvas = new Canvas(800, 600);
        root.setCenter(canvas);

        GraphicsContext gc = canvas.getGraphicsContext2D();
        gc.setFill(Color.WHITE);
        gc.fillRect(0, 0, canvas.getWidth(), canvas.getHeight());

        canvas.setOnMousePressed(e -> {
            startX = e.getX();
            startY = e.getY();
            endX = e.getX();
            endY = e.getY();
            isDrawing = true;
            isMoving = false;
            for (Rectangle rectangle : rectangles) {
                if (rectangle.contains(startX, startY)) {
                    selectedRectangle = rectangle;
                    isDrawing = false;
                    isMoving = true;
                    mouseX = e.getX();
                    mouseY = e.getY();
                    break;
                }
            }
        });

        canvas.setOnMouseReleased(e -> {
            if (isDrawing) {
                double x = Math.min(startX, endX);
                double y = Math.min(startY, endY);
                double width = Math.abs(endX - startX);
                double height = Math.abs(endY - startY);
                rectangles.add(new Rectangle(x, y, width, height));
                drawRectangles(gc);
            }
            isDrawing = false;
            isMoving = false;
            selectedRectangle = null;
        });

        canvas.setOnMouseDragged(e -> {
            if (isDrawing) {
                endX = e.getX();
                endY = e.getY();
                drawRectangles(gc);
            }
            if (isMoving) {
                double deltaX = e.getX() - mouseX;
                double deltaY = e.getY() - mouseY;
                selectedRectangle.move(deltaX, deltaY);
                drawRectangles(gc);
                mouseX = e.getX();
                mouseY = e.getY();
            }
        });

        Scene scene = new Scene(root);
        primaryStage.setScene(scene);
        primaryStage.show();
    }

    private void drawRectangles(GraphicsContext gc) {
        gc.setFill(Color.WHITE);
        gc.fillRect(0, 0, gc.getCanvas().getWidth(), gc.getCanvas().getHeight());
        for (Rectangle rectangle : rectangles) {
            gc.setFill(Color.BLUE);
            gc.fillRect(rectangle.getX(), rectangle.getY(), rectangle.getWidth(), rectangle.getHeight());
        }
    }

    private java.util.List<Rectangle> rectangles = new java.util.ArrayList<>();

    private static class Rectangle {
        private double x;
        private double y;
        private double width;
        private double height;

        public Rectangle(double x, double y, double width, double height) {
            this.x = x;
            this.y = y;
            this.width = width;
            this.height = height;
        }

        public boolean contains(double x, double y) {
            return x >= this.x && x <= this.x + this.width &&
                    y >= this.y && y <= this.y + this.height;
        }

        public void move(double deltaX, double deltaY) {
            x += deltaX;
            y += deltaY;
        }

        public double getX() {
            return x;
        }
    }
}
