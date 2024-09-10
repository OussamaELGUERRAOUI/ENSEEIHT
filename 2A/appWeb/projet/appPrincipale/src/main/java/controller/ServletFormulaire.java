package controller;



import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;



import com.google.gson.Gson;
import com.google.gson.JsonObject;

@WebServlet("/")
public class ServletFormulaire extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lecture des données du formulaire
    	System.out.println("accées do postFormulaire");
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        
        String requestBody = sb.toString();
        System.out.println(requestBody);
        // Parse le JSON
        Gson gson = new Gson();
        JsonObject jsonObject = gson.fromJson(requestBody, JsonObject.class);
        

        // Envoyer une réponse au client
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("accés do get");
		
        /*for (int i = 1; i <= 3; i++) {
            Map<String, Object> block = new HashMap<>();
            block.put("title", "Bloc " + i);
            block.put("isVisible", false);

            List<Map<String, Object>> questions = new ArrayList<>();
            for (int j = 1; j <= 2; j++) {
                Map<String, Object> question = new HashMap<>();
                question.put("id", (i - 1) * 2 + j);
                question.put("content", "Question " + i + "." + j);
                question.put("isVisible", true);
                question.put("response", ""); // Ajoutez cette ligne pour inclure la réponse
                questions.add(question);
            }

            block.put("questions", questions);
            blocks.add(block);
        }*/
        // Récupérer les données de la base de données
        HashMap<String, Object> data = facade.getBlock();
        // Convertir les données en JSON
        String json = new Gson().toJson(data);
        System.out.println(json);
        // Envoyer la réponse au client
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);;
	}
}

  


