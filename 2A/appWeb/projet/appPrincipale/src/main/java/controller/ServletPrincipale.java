package controller;

import java.io.BufferedReader;
import java.io.IOException;

import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import pack.Facade;

@WebServlet("/princ")
public class ServletPrincipale extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    Facade facade = new Facade();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	System.out.println("accées");
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
        String action = jsonObject.get("action").getAsString();
        System.out.println(action);
        
        
        if(action.equals("addSchool")) {
            // Récupérer les données du formulaire
            String schoolName =jsonObject.get("schoolName").getAsString(); 
            String country = jsonObject.get("country").getAsString();  
            String cadreOptions = jsonObject.get("cadreOptions").getAsString();
            String specialite = jsonObject.get("specialite").getAsString();  

            facade.createSchool(schoolName, country, cadreOptions, specialite);
                    
            
            response.setContentType("application/json");
            response.getWriter().write(gson.toJson("School added successfully"));
          
        } else if(action.equals("addInformation") ){
            // Récupérer les données du formulaire
            
            System.out.println("addInformation");
            
            // Traitement des données
            
        }
        
        else if(action.equals("addBloc")) {
            // Récupérer les données du formulaire
            String blocName = jsonObject.get("blocName").getAsString();
            System.out.println(blocName);

            // Traitement des données
            facade.createBlock(blocName);
            
            // Répondre avec un objet JSON
            response.setContentType("application/json");
            response.getWriter().write(gson.toJson("Bloc added successfully"));
        }
        else if (action.equals("deleteBloc")){
            // Récupérer les données du formulaire
            String blocName = jsonObject.get("blocName").getAsString();
            System.out.println(blocName);
            
            // Traitement des données
            facade.deleteBlock(blocName);
            
            // Répondre avec un objet JSON
            response.setContentType("application/json");
            response.getWriter().write(gson.toJson("Bloc deleted successfully"));

        }

        else if(action.equals("addQuestion")) {
            // Récupérer les données du formulaire
            String questionContent = jsonObject.get("questionContent").getAsString();
            String blocName = jsonObject.get("blocName").getAsString();
            System.out.println(questionContent);
            System.out.println(blocName);
            
            // Traitement des données
            facade.addQuestionToBlock(blocName, questionContent);
            
            // Répondre avec un objet JSON
            response.setContentType("application/json");
            response.getWriter().write(gson.toJson("Question added successfully"));
        }

        else if(action.equals("deleteQuestion")){
            // Récupérer les données du formulaire
            String questionContent = jsonObject.get("questionContent").getAsString();
            String blocName = jsonObject.get("blocName").getAsString();
            System.out.println(questionContent);
            System.out.println(blocName);
            
            // Traitement des données
            facade.deleteQuestionFromBlock(blocName, questionContent);
            
            // Répondre avec un objet JSON
            response.setContentType("application/json");
            response.getWriter().write(gson.toJson("Question deleted successfully"));
        }
        
        
        
        
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	System.out.println("accées doGet");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
         
        // Sample data to send as JSON
         List<Map<String, Object>> blocks = new ArrayList<>();
         for (int i = 1; i <= 3; i++) {
             Map<String, Object> block = new HashMap<>();
             block.put("title", "Bloc " + i);
             block.put("isVisible", false);
 
             List<Map<String, Object>> questions = new ArrayList<>();
             for (int j = 1; j <= 2; j++) {
                 Map<String, Object> question = new HashMap<>();
                 question.put("id", (i - 1) * 2 + j);
                 question.put("content", "Question " + i + "." + j);
                 question.put("isVisible", true);
                 questions.add(question);
             }
 
             block.put("questions", questions);
             blocks.add(block);
         }
 
         // Convert the data to JSON using Gson library
         String json = new Gson().toJson(blocks);
         System.out.println(json);
 
         response.getWriter().write(json);
    }
}
