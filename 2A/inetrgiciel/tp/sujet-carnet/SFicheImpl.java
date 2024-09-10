import java.util.*;
import java.io.*;

public class SFicheImpl implements SFiche{

    private String nom;
    private String email;

    public SFicheImpl(String n, String e){
        this.nom = n;
        this.email = e;
    }

    public String getNom(){
        return this.nom;
    }

    public String getEmail(){
        return this.email;
    }
    
}
