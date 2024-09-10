import java.awt.Color;
import java.awt.Graphics;
import java.util.ArrayList;
import java.util.Random;

import javax.swing.JFrame;
import javax.swing.JPanel;

import sim.field.continuous.Continuous2D;
import sim.engine.SimState;
import sim.engine.Steppable;
import sim.engine.Stoppable;
import sim.util.Bag;
import sim.util.Double2D;
import sim.util.MutableDouble2D;

import org.menge.crowd.Simulator;
import org.menge.crowd.behavior.StaticBehavior;
import org.menge.crowd.behavior.WaypointBehavior;
import org.menge.crowd.demo.Building;
import org.menge.crowd.demo.Door;
import org.menge.crowd.demo.Room;
import org.menge.crowd.demo.Wall;
import org.menge.crowd.model.Model;
import org.menge.crowd.model.ModelFactory;
import org.menge.crowd.model.ModelParams;
import org.menge.crowd.navigation.NavMesh;
import org.menge.crowd.navigation.NavMeshParams;
import org.menge.crowd.navigation.Path;

public class CrowdSimulation extends GUIState {
    public static void main(String[] args) {
        CrowdSimulation simState = new CrowdSimulation();
        Console c = new Console(simState);
        c.setVisible(true);
    }

    public CrowdSimulation() {
        super(new Crowd(120, 1000, 1000));
    }

    public CrowdSimulation(SimState state) {
        super(state);
    }

    public void start() {
        super.start();
        setupPortrayals();
    }

    public void load(SimState state) {
        super.load(state);
        setupPortrayals();
    }

    public void setupPortrayals() {
        Crowd crowd = (Crowd) state;

        Display2D display = new Display2D(1000, 1000, this);
        display.setClipping(false);

        displayFrame = display.createFrame();
        displayFrame.setTitle("Crowd Simulation");
        this.registerFrame(displayFrame);
        displayFrame.setVisible(true);
        display.attach(crowd.getDrawingSurface(), "Agents");
        display.attach(crowd.getWallDrawingSurface(), "Walls");

        JFrame frame = new JFrame("Crowd Simulation");
        JPanel panel = new JPanel() {
            private static final long serialVersionUID = 1L;

            public void paintComponent(Graphics g) {
                super.paintComponent(g);
                Bag allObjects = crowd.getDrawingSurface()
                        .getAllObjects();
                for (Object object : allObjects) {
                    if (object instanceof Agent) {
                        Agent agent = (Agent) object;
                        MutableDouble2D location = agent.getLocation();
                        g.setColor(agent.getColor());
                        g.fillRect((int) location.x, (int) location.y, 4, 4);
                    } else if (object instanceof Wall) {
                        Wall wall = (Wall) object;
                        g.setColor(Color.black);
                        g.drawLine((int) wall.getStart().x, (int) wall.getStart().y, (int) wall.getEnd().x,
                                (int) wall.getEnd().y);
                    } else if (object instanceof Door) {
                        Door door = (Door) object;
                        g.setColor(Color.green);
                        g.drawLine((int) door.getStart().x, (int) door.getStart().y, (int) door.getEnd().x,
                                (int) door.getEnd().y);
                    }
                }
            }
        };
        panel.setBackground(Color.white);
        panel.setSize(1000, 1000);
        frame.add(panel);
        frame.setSize(1000, 1000);
        frame.setVisible(true);
        Stoppable stoppable = crowd.scheduleRepeating(new Steppable() {
            private static final long serialVersionUID = 1L;

            public void step(SimState state) {
                crowd.step(state);
                panel.repaint();
            }
        }, 1);
        crowd.attach(stoppable);
    }
}
