package pack;


import javax.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity
public class Block {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String titre;

    @OneToMany(mappedBy = "bloc", cascade = CascadeType.ALL)
    private List<Question> questions;

    @ManyToOne
    private University university;

    // Getters and setters
    public Block() {
    }

    

    public Block(String titre) {
        this.titre = titre;
        this.questions = new ArrayList<Question>();
    }

    public Long getId() {
        return id;
    }

    public String getTitre() {
        return titre;
    }

    public List<Question> getQuestions() {
        return questions;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public void setQuestions(List<Question> questions) {
        this.questions = questions;
    }

    public void addQuestion(Question question) {
        this.questions.add(question);
    }

    public void removeQuestion(Question question) {
        this.questions.remove(question);
    }
}

