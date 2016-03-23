package logicline.modeleSemantique;

import java.util.HashSet;
import java.util.Set;

public class Non extends Formule {

	protected Formule formule;
	protected Set<String> variablesLibres;
	
	public Non(Formule formule){
	 	this.formule = formule;
	 	this.variablesLibres = new HashSet<String>();
	 	
	}
	
	@Override
	public String toString() {
		return "¬("+formule+")";
	}

	@Override
	public Set<String> variablesLibres() {
		variablesLibres.addAll(formule.variablesLibres());
		return variablesLibres;
	}

	@Override
	public Formule substitue(Substitution s) {
		return new Non(formule.substitue(s));
	}

	@Override
	public boolean valeur() throws VariableLibreException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Formule negation(){
		return this.formule;
	}

	@Override
	public Formule entrerNegations(){
		return formule.negation();
	}
	
	@Override
	public boolean contientEt(){
		return this.formule.contientEt();
	}

}
