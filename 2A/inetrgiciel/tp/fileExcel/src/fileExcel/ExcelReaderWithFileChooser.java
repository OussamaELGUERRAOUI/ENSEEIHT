import javax.swing.*;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class ExcelReaderWithFileChooser {
    public static void main(String[] args) {
        // Création de la boîte de dialogue de sélection de fichier
        JFileChooser fileChooser = new JFileChooser();
        fileChooser.setDialogTitle("Sélectionner le fichier CSV");
        fileChooser.setFileFilter(new FileNameExtensionFilter("Fichiers CSV (*.csv)", "csv"));

        // Affichage de la boîte de dialogue
        int userSelection = fileChooser.showOpenDialog(null);

        if (userSelection == JFileChooser.APPROVE_OPTION) {
            // Récupération du fichier sélectionné
            String csvFilePath = fileChooser.getSelectedFile().getAbsolutePath();

            List<List<String>> data = new ArrayList<>();

            try (BufferedReader reader = new BufferedReader(new FileReader(csvFilePath))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split(",");
                    List<String> row = Arrays.asList(parts);
                    data.add(row);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }

            // Maintenant, vous avez les données dans la liste de listes "data"
            for (List<String> row : data) {
                System.out.println(row);
            }
        }
    }
}
