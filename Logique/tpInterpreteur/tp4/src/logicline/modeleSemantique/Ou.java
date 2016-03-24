package logicline.modeleSemantique;

import java.util.HashSet;
import java.util.Set;

public class Ou extends Formule {

	protected Formule formule;
	protected Formule formule2;
	protected Set<String> variablesLibres;
	
	public Ou(Formule formule, Formule formule2){
	 	this.formule = formule;
	 	this.formule2 = formule2;
	 	this.variablesLibres = new HashSet<String>();
	 	
	}
	
	@Override
	public String toString() {
		return "("+formule+")"+" ∨ "+"("+formule2+")";
	}

	@Override
	public Set<String> variablesLibres() {
		variablesLibres.addAll(formule.variablesLibres());
		variablesLibres.addAll(formule2.variablesLibres());
		return variablesLibres;
	}

	@Override
	public Formule substitue(Substitution s) {
		return new Ou(formule.substitue(s),formule2.substitue(s));
	}

	@Override
	public boolean valeur() throws VariableLibreException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Formule negation(){
		return new Et( this.formule.negation(), this.formule2.negation());
	}
	
	@Override
	public Formule entrerNegations(){
		return new Ou( this.formule.entrerNegations(), this.formule2.entrerNegations());
	}

	@Override
	public boolean contientEt(){
		return ( this.formule.contientEt() || this.formule2.contientEt() );
	}

}
