package pack;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.*;

@Entity
public class University {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    
   
    private String pays;
    
    private String ville;

    private List<String> specialite;
    private List<String> cadres;
    private List<String> typeSejoure;
    private String langueEnseignement;
    private String exigenceLinguistique;
    private String residenceUniversitaires;
    private String dateFinexam;
    private String dateRat;
    private String moyenneVal;



    @OneToMany(mappedBy = "bloc")
    private List<Block> blocks;
    
    

    public University() {
    }

   

    public University(String name, String pays, List<String> specialite, List<String> cadres) {
        this.name = name;
        this.blocks = new ArrayList<>();
        this.specialite = specialite;
        this.cadres = cadres;
        this.pays = pays;
        
    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    



    public List<Block> getQuestions() {
        return this.blocks;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void addBlock(Block block) {
        this.blocks.add(block);
    }

    public void removeBlock(Block block) {
        this.blocks.remove(block);
    }

    public void setBlocks(List<Block> blocks) {
        this.blocks = blocks;
    }

    public List<Block> getBlocks() {
        return blocks;
    }

    public String getPays() {
        return pays;
    }

   

    public void setPays(String pays) {
        this.pays = pays;
    }

    public String getVille() {
        return ville;
    }

    public void setVille(String ville) {
        this.ville = ville;
    }

    public List<String> getSpecialite() {
        return specialite;
    }

    public void setSpecialite(List<String> specialite) {
        this.specialite = specialite;
    }

    public List<String> getCadres() {
        return cadres;
    }

    public void setCadres(List<String> cadres) {
        this.cadres = cadres;
    }

    public String getLangueEnseignement() {
        return langueEnseignement;
    }

    public void setLangueEnseignement(String langueEnseignement) {
        this.langueEnseignement = langueEnseignement;
    }

    public String getExigenceLinguistique() {
        return exigenceLinguistique;
    }

    public void setExigenceLinguistique(String exigenceLinguistique) {
        this.exigenceLinguistique = exigenceLinguistique;
    }

    public String getResidenceUniversitaires() {
        return residenceUniversitaires;
    }

    public void setResidenceUniversitaires(String residenceUniversitaires) {
        this.residenceUniversitaires = residenceUniversitaires;
    }

    public String getDateFinexam() {
        return dateFinexam;
    }

    public void setDateFinexam(String dateFinexam) {
        this.dateFinexam = dateFinexam;
    }

    public String getDateRat() {
        return dateRat;
    }

    public void setDateRat(String dateRat) {
        this.dateRat = dateRat;
    }

    public String getMoyenneVal() {
        return moyenneVal;
    }

    public void setMoyenneVal(String moyenneVal) {
        this.moyenneVal = moyenneVal;
    }

    public List<String> getTypeSejoure() {
        return typeSejoure;
    }

    public void setTypeSejoure(List<String> typeSejoure) {
        this.typeSejoure = typeSejoure;
    }

    public void addTypeSejoure(String typeSejoure) {
        this.typeSejoure.add(typeSejoure);
    }

    public void addSpecialite(String specialite) {
        this.specialite.add(specialite);
    }

    public void addCadres(String cadres) {
        this.cadres.add(cadres);
    }


    
}

