package pack;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;

import javax.ejb.*;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.*;





@Singleton
public class Facade {

    @PersistenceContext
    private EntityManager em;

    public void createBlock (String titre) {
        Block block = new Block(titre);
        em.persist(block);
    }

    public void deleteBlock (String titre) {
        Block block = em.createQuery("SELECT b FROM Block b WHERE b.titre = :titre", Block.class)
                        .setParameter("titre", titre)
                        .getSingleResult();
        
        em.remove(block);
    }

    public void addQuestionToBlock (String nameBlock, String question) {
    	Block block = em.createQuery("SELECT b FROM Block b WHERE b.titre = :nameBlock", Block.class)
                        .setParameter("nameBlock", nameBlock)
                        .getSingleResult();
        Question q = new Question(question);
        block.addQuestion(q);
        em.persist(q);
        em.persist(block);
    }

    public void deleteQuestionFromBlock (String nameBlock, String question) {
        Block block = em.createQuery("SELECT b FROM Block b WHERE b.titre = :nameBlock", Block.class)
                        .setParameter("nameBlock", nameBlock)
                        .getSingleResult();
        Question q = em.createQuery("SELECT q FROM Question q WHERE q.contenu = :question", Question.class)
                        .setParameter("question", question)
                        .getSingleResult();
        block.removeQuestion(q);
        em.remove(q);
        em.persist(block);
    }

    public Collection<Block> getAllBlocks() {
    	TypedQuery<Block> req = em.createQuery("SELECT b FROM Block b", Block.class);
        return req.getResultList();
    }



    public void Collection<Question> getQuestionsByBlock(String nameBlock) {
        Block block = em.createQuery("SELECT b FROM Block b WHERE b.titre = :nameBlock", Block.class)
                        .setParameter("nameBlock", nameBlock)
                        .getSingleResult();
        return block.getQuestions();
    }

    public Hashtable<String, List<String>> getReponsesByUniversity(String nameUniversity) {
        Hashtable<String, List<String>> hashtable = new Hashtable<String, List<String>>();
        University university = em.createQuery("SELECT u FROM University u WHERE u.name = :nameUniversity", University.class)
                        .setParameter("nameUniversity", nameUniversity)
                        .getSingleResult();
        List<Question> Question = university.getQuestions();
        for (Question q : Question) {
            List<Reponse> r = q.getReponses();
            String question = q.getContenu();
            List<String> reponses = new ArrayList<String>();
            for (Reponse reponse : r) {
                reponses.add(reponse.getContenu());
            }
            hashtable.put(question, reponses);
        }
        return hashtable;
    }
    
    


    public void createUniversity(String name, String pays, List<String> specialite, List<String> cadres) {
        University university = new University(name, pays, specialite, cadres);
        // verif si le pays existe
        Pays p = em.createQuery("SELECT p FROM Pays p WHERE p.name = :pays", Pays.class)
                        .setParameter("pays", pays)
                        .getSingleResult();
        if (p == null) {
            p = new Pays(pays);
            p.addUniversity(university);
            em.persist(p);
        } else{
            List<University> universities = p.getUniversities();
            if(!universities.contains(university)) {
                p.addUniversity(university);
                em.persist(p);
            }
        }
        em.persist(university);
    }

    public HashMap<String, List<String>> getUniversitiesWithPays() {
        HashMap<String, List<String>> hashMap = new HashMap<String, List<String>>();
        List<Pays> pays = em.createQuery("SELECT p FROM Pays p", Pays.class).getResultList();
        for (Pays p : pays) {
            List<University> universities = p.getUniversities();
            List<String> names = new ArrayList<String>();
            for (University u : universities) {
                names.add(u.getName());
            }
            hashMap.put(p.getName(), names);
        }
        return hashMap;
    }




    public HashMap<String, Object> getBlocksByUniversity(String nameUniversity) {
        HashMap<String, Object> hashMap = new HashMap<String, Object>();
        University university = em.createQuery("SELECT u FROM University u WHERE u.name = :nameUniversity", University.class)
                        .setParameter("nameUniversity", nameUniversity)
                        .getSingleResult();
        List<Block> blocks = university.getBlocks();
        List<HashMap<String, Object>> blocksList = new ArrayList<HashMap<String, Object>>();
        for (Block b : blocks) {
            HashMap<String, Object> blockMap = new HashMap<String, Object>();
            blockMap.put("title", b.getTitre());
            List<Question> questions = b.getQuestions();
            List<HashMap<String, Object>> questionsList = new ArrayList<HashMap<String, Object>>();
            for (Question q : questions) {
                HashMap<String, Object> questionMap = new HashMap<String, Object>();
                questionMap.put("content", q.getContenu());
                List<String> reponses = new ArrayList<String>();
                for (Reponse r : q.getReponses()) {
                    reponses.add(r.getContenu());
                }
                questionMap.put("reponse", reponses);
                questionsList.add(questionMap);
            }
            blockMap.put("questions", questionsList);
            blocksList.add(blockMap);
        }
        hashMap.put("blocks", blocksList);
        return hashMap;
    }





    public void addReponseToQuestion(String nameUniversity, String bloc, String question, String reponse) {
        University university = em.createQuery("SELECT u FROM University u WHERE u.name = :nameUniversity", University.class)
                        .setParameter("nameUniversity", nameUniversity)
                        .getSingleResult();
        List<Block> blocks = university.getBlocks();
        for (Block b : blocks) {
            if (b.getTitre().equals(bloc)) {
                List<Question> questions = b.getQuestions();
                for (Question q : questions) {
                    if (q.getContenu().equals(question)) {
                        Reponse r = new Reponse(reponse);
                        q.addReponse(r);
                        em.persist(r);
                        em.persist(q);
                    }
                }

            }
        }
        em.persist(university);
    }



    public HashMap<String, Object> getBlock(String nameUniversity, String bloc) {

        List<Block> blocks = em.createQuery("SELECT b FROM Block b WHERE b.titre = :bloc", Block.class)
                        .setParameter("bloc", bloc)
                        .getResultList();
        
        HashMap<String, Object> hashMap = new HashMap<String, Object>();
        for (Block b : blocks) {
            hashMap.put("title", b.getTitre());
            List<Question> questions = b.getQuestions();
            List<String> questionsList = new ArrayList<String>();
            for (Question q : questions) {
                questionsList.add(q.getContenu());
            }
            hashMap.put("questions", questionsList);
        }
        return hashMap;
        
    }


       


   


    
}
