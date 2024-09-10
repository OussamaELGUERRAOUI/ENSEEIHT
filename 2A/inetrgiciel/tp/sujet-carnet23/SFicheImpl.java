
public class SFicheImpl implements SFiche{
	
	private String nom ;
	private String mail;
	
	public SFicheImpl (String n, String m) {
		this.nom = n;
		this.mail = m;
	}
	
	

	@Override
	public String getNom() {
		
		return this.nom;
	}

	@Override
	public String getEmail() {
		
		return this.mail;
	}

}
