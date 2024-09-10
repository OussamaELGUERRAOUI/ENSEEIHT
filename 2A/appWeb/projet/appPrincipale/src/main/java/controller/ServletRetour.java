package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.jws.WebService;
import javax.servlet.http.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import pack.Block;
import pack.Facade;
import pack.Question;

@WebService("/retour")
public class ServletRetour implements HttpServletRequest{

    private static final long serialVersionUID = 1L;


    private Facade facade = new Facade();
     


    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        
        HashMap<String, Object> data = new HashMap<>();
        // Récupérer les données
        HashMap<String,List< String>> paysUni = facade.getUniversitiesWithPays();
        data.put("paysUni", paysUni);

        
        
        
        // Récupaérer des blocs
        List<Block> blocks = facade.getAllBlocks();
        List<Map<String, Object>> blocks = new ArrayList<>();
        for (Block block : blocks) {
            Map<String, Object> blockmMap = new HashMap<>();
            String titre = block.getTitre();
            blockmMap.put("title", titre);
        
            List<Question> questions = block.getQuestions();
            List<Map<String, Object>> questionsList = new ArrayList<>();
            for (Question question : questions) {
                Map<String, Object> questionMap = new HashMap<>();
                questionMap.put("content", question.getContenu());
                List<String> reponse = new ArrayList<>();
                questionMap.put("reponse", reponse);
                questionsList.add(questionMap);
            }
            blockmMap.put("questions", questionsList);
            blocks.add(blockmMap);
        }
        data.put("blocks", blocks);

        System.out.println(blocks);

        // Répondre avec un objet JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(new Gson().toJson(data));

        
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lecture des données du formulaire
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
        
        String university = jsonObject.get("university").getAsString();
        System.out.println(university);

        
        HashMap<String, Object> data = facade.getBlocksByUniversity(university);

        // Répondre avec un objet JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String json = new Gson().toJson(data);
        System.out.println(json);
        response.getWriter().write(json);
    }
        

}
