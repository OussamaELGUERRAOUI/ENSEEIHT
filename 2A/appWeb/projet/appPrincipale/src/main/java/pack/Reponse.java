package pack;



import javax.persistence.*;

@Entity
public class Reponse {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String contenu;

    @ManyToOne
    private Question question;
    
    @OneToOne
    private Etudiant etudiant;
    

    public Reponse() {
    }

    public Reponse(String contenu) {
        this.contenu = contenu;   
    }

    public Reponse(String contenu, Question question) {
        this.contenu = contenu;
        this.question = question;
    }
    
    public Long getId() {
        return id;
    }

    public String getContenu() {
        return contenu;
    }

    public Question getQuestion() {
        return question;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setContenu(String contenu) {
        this.contenu = contenu;
    }

    
}

