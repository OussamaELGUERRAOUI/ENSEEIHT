package pack;

import java.util.List;

import javax.persistence.*;

@Entity
public class Question {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String contenu;

    @ManyToOne
    private Block bloc;

    

    @OneToMany(mappedBy = "question", cascade = CascadeType.ALL)
    private List<Reponse> reponses;

    // Getters and setters
    public Question() {
    }

    public Question(String contenu) {
        this.contenu = contenu;
    }

    public Question(String contenu, Block bloc) {
        this.contenu = contenu;
        this.bloc = bloc;
    }

    public Long getId() {
        return id;
    }

    public String getContenu() {
        return contenu;
    }

    public Block getBloc() {
        return bloc;
    }

    public List<Reponse> getReponses() {
        return reponses;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setContenu(String contenu) {
        this.contenu = contenu;
    }

    public void setBloc(Block bloc) {
        this.bloc = bloc;
    }

    public void setReponses(List<Reponse> reponses) {
        this.reponses = reponses;
    }

    public void addReponse(Reponse reponse) {
        reponses.add(reponse);
    }  
}
