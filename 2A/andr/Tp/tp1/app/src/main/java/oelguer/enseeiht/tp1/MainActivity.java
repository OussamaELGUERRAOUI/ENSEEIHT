package oelguer.enseeiht.tp1;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_main);
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });

        // Récupérer le bouton et le champ de texte
        /*Button button = findViewById(R.id.button);
        EditText editText = findViewById(R.id.editTextText);

        // Définir un écouteur sur le bouton
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // Obtenir l'URL saisie par l'utilisateur
                String url = editText.getText().toString();
                // Créer un objet Uri à partir de l'URL
                Uri webpage = Uri.parse(url);
                // Créer un nouvel Intent avec l'action ACTION_VIEW pour ouvrir le navigateur
                Intent intent = new Intent(Intent.ACTION_VIEW, webpage);
                // Démarrer l'activité du navigateur
                startActivity(intent);
            }
        });*/
    }
}
