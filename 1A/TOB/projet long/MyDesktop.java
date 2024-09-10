import tile.TileDesktop;
import tile.TileFrame;
import tile.TileWidget;
import tile.event.TileMouseEvent;
import tile.event.TileMouseListener;
import tile.TileComponent;

public class MyDesktop extends TileDesktop {

    public static void main(String[] args) {
        // Initialisation du cadre de l'application Tile
        TileFrame.init();

        // Création d'une instance de MyDesktop
        MyDesktop desktop = new MyDesktop();

        // Ajout d'un bouton à la zone de travail
        TileWidget widget = new TileWidget(100, 50, 200, 100);
        widget.addComponent(new TileComponent("Cliquez ici !"));
        widget.addMouseListener(new TileMouseListener() {
            public void mouseClicked(TileMouseEvent e) {
                System.out.println("Le bouton a été cliqué !");
            }
        });
        desktop.add(widget);

        // Définition des propriétés de l'application Tile
        TileProperties properties = TileProperties.get();
        properties.setTitle("Mon bureau Tile");
        properties.setTheme(TileProperties.Theme.LIGHT);

        // Affichage du bureau Tile
        TileFrame.show(desktop);
    }
}
