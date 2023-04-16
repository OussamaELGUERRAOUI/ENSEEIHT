package allumettes;

import org.junit.*;
import static org.junit.Assert.*;

public class strategierapideTest {

    @Test
    public void test1() throws CoupInvalideException {
        Jeu jeu = new SujetReel(13);
        // vérifier qu'il y a 13 allumettes.
        assertEquals("le nombre des allumettes", 13, jeu.getNombreAllumettes());
        Strategie strategie = new strategie_rapide();
        int nombreAllumettes = jeu.getNombreAllumettes();
        // vérifier que le nombre prise est trois
        assertEquals("le nombre prise est incorrect", Jeu.PRISE_MAX, strategie.getPrise(jeu));
        jeu.retirer(strategie.getPrise(jeu));
        nombreAllumettes -= Jeu.PRISE_MAX;
        // vérifier que le nombre des allumettes retires est trois
        assertEquals("le nombre des allumettes retirés est incorrect", nombreAllumettes, jeu.getNombreAllumettes());
        

    }

    @Test
    public void test2() throws CoupInvalideException {
        Jeu jeu = new SujetReel(Jeu.PRISE_MAX - 1);
        // vérifier qu'il y a deux allumettes
        assertEquals("le nombre des allumettes", Jeu.PRISE_MAX - 1 , jeu.getNombreAllumettes());
        Strategie strategie = new strategie_rapide();
        // vérifier que le nombre prise est deux
        assertEquals("le nombre prise est incorrect", Jeu.PRISE_MAX - 1, strategie.getPrise(jeu));
    }

    @Test
    public void test3() throws CoupInvalideException {
        Jeu jeu = new SujetReel(1);
        // vérifier qu'il y a 1 allumettes
        assertEquals("le nombre des allumettes est incorrect", 1, jeu.getNombreAllumettes());
        Strategie strategie = new strategie_rapide();
        // vérifier que le nombre prise est 1
        assertEquals("le nombre prise incorrect",1, strategie.getPrise(jeu));
    }

}
