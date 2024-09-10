import java.awt.Color;


/** Cercle modélise un Cercle géométrique dans un plan équipé d'un
 * repère cartésien.
 *
 * @author  ELGUERRAOUI Oussama <Prénom.Nom@enseeiht.fr>
 */






public class Cercle implements Mesurable2D{
    private Point centre;
    private double rayon;
    private Color couleur;

    
     
    public final static double PI = Math.PI;

    /**E1 translater un cercle avec un déplacement dx suivant l’axe des X et un déplacement dy suivant l’axe des Y..
	 * @param dx déplacement suivant l'axe des X
	 * @param dy déplacement suivant l'axe des Y
	 */
     
     public void translater (double dx, double dy) {

        this.centre.translater(dx, dy);
    }


    
     /**E2 Obtenir le centre du cercle.
 	 * @return centre du cercle
 	 */
     
    
     public Point getCentre() {
        return new Point(this.centre.getX(), this.centre.getY());
    }


    
     /**E3 Obtenir le rayon du cercle.
  	 * @return rayon du cercle
  	 */
     public double getRayon() {
        return this.rayon;
    }


    
     /**E4 Obtenir le diametre du cercle.
   	 * @return diametre du cercle
   	 */
     public double getDiametre() {
        return (this.rayon) *2;
    }


     
     
     
     /**E5 vérfier un point est en l'intérieur d'un cercle au sens large
      * @param A poinr à vérifier .
   	 * @return boolean.
   	 */
     
     public boolean contient (Point A) {
        assert (A != null);
        if (A.distance(this.centre) <= this.rayon) {
            return true;
        }
        else {
            return false;
        }
    }



   
     /**E6 Obtenir le perimetre du cercle.
   	 * @return perimetre du cercle
   	 */
     public double perimetre() {
         assert this.couleur != null;
    	 return 2*PI*(this.rayon);
    }



   
     
     /**E6 Obtenir la surface du cercle.
   	 * @return la surface du cercle.
   	 */
     public double aire() {
        return PI*Math.pow(this.rayon, 2);
    }



   
     /**E9 Obtenir le couleur du cercle.
   	 * @return couleur du cercle
   	 */
     public Color getCouleur() {
        return this.couleur;
    }





    
     /**E10 Changer le couleur du cercle.
	  * @param nouveaucouleur nouveau couleur
	  */
     public void setCouleur(Color nouveaucouleur) {
        assert nouveaucouleur != null;
        this.couleur = nouveaucouleur ;
    }


    
     
     
     /**E11 Construire un cercle à partir de son centre et de son rayon.
 	 * @param c centre
 	 * @param r rayon
 	 */
     public Cercle(Point c, double r) {
        assert r > 0;
        assert c != null;
        this.centre = new Point(c.getX(), c.getY());
        this.rayon = r;
        this.couleur = Color.blue;
    }

   
     
     
     
     /**E12 Construire un cercle à partir  deux points diamétralement opposés.
  	 * @param diam1 points diamétrale
  	 * @param diam2 points diamétrale
  	 */
     public Cercle(Point diam1, Point diam2) {
        assert diam1.distance(diam2) != 0;
        assert diam1 != null ;
        assert diam2 != null;
        double cx = (diam1.getX() + diam2.getX())/2.0 ;
        double cy = (diam1.getY() + diam2.getY())/2.0 ;
        this.centre = new Point(cx,cy) ;
        this.rayon = diam1.distance(diam2)/2.0 ;
        this.couleur = Color.blue;
    }


    
     
     
     
     /**E13 Construire un cercle à partir  deux points diamétralement opposés et de sa couleur.
   	 * @param diam1 points diamétrale
   	 * @param diam2 points diamétrale
   	 * @param col couleur
   	 */
     public Cercle(Point diam1, Point diam2, Color  col) {
        assert diam1 != null ;
        assert diam2 != null;
        assert diam1.distance(diam2) !=0 ;
        assert col != null;
        this.centre = new Point( (diam1.getX() + diam2.getX()) / 2 ,(diam1.getY() + diam2.getY()) / 2) ;
        this.rayon = diam1.distance(diam2)/2.00 ;
        this.couleur = col;


    }



     
     
     
     /**E14 Construire un cercle à partir  du centre et d'un point de cercle.
   	 * @param pc  centre
   	 * @param pconf point du cercle 
   	 */
     public static Cercle creerCercle(Point pc, Point pconf){
        assert pc != null ;
        assert pconf != null;
        assert pc.getX() != pconf.getX() && pc.getY() != pconf.getY() ;
        return new Cercle(pc,pc.distance(pconf));
    }

   
     
     
     
     public String toString(){
        return "C"  + this.rayon + "@" + this.centre.toString();
    }

     /**E15 Afficher le cercle. */
    public void afficher () {
        System.out.print(this);
    }


   
    /**E16 Changer le rayon du cercle.
	  * @param nouveaurayon nouveau rayon
	  */
    public void setRayon(double nouveaurayon){
        assert ( nouveaurayon > 0);
        this.rayon = nouveaurayon;
    }


   
    
    /**E17 Changer le diametre du cercle.
	  * @param nouveaudiametre nouveau diametre
	  */
    public void setDiametre(double nouveaudiametre){
        assert (nouveaudiametre > 0) ;
        this.rayon = nouveaudiametre/2 ;
    }

}
