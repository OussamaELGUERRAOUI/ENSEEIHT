package allumettes;

import org.junit.*;
import static org.junit.Assert.*;

public class strategieexperteTest {
    @Test
    public void test1() throws CoupInvalideException {
        Jeu jeu = new SujetReel(Jeu.PRISE_MAX + 1);
        // vérifier qu'il y a trois allumettes.
        assertEquals("le nombre des allumettes est incorrect", Jeu.PRISE_MAX + 1, jeu.getNombreAllumettes());
        Strategie strategie = new strategie_expert();
        // vérifier que le nombre prise est trois.
        assertEquals("le nombre prise est incorrect", Jeu.PRISE_MAX, strategie.getPrise(jeu));

    }

    @Test
    public void test2() throws CoupInvalideException {
        Jeu jeu = new SujetReel(Jeu.PRISE_MAX);
        // vérifier qu'il y a deux allumettes
        assertEquals("le nombre des allumettes", Jeu.PRISE_MAX, jeu.getNombreAllumettes());
        Strategie strategie = new strategie_expert();
        // vérifier que le nombre prise est deux
        assertEquals("le nombre prise est incorrect", Jeu.PRISE_MAX - 1, strategie.getPrise(jeu));
    }

    @Test
    public void test3() throws CoupInvalideException {
        Jeu jeu = new SujetReel(Jeu.PRISE_MAX - 1);
        // vérifier qu'il y a deux allumettes
        assertEquals("le nombre des allumettes", Jeu.PRISE_MAX - 1, jeu.getNombreAllumettes());
        Strategie strategie = new strategie_expert();
        // vérifier que le nombre prise est 1
        assertEquals("le nombre prise est incorrect", 1, strategie.getPrise(jeu));
    }

}
