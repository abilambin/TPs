package logicline.modeleSemantique;

import java.util.HashSet;
import java.util.Set;

public class Constante extends Formule {
	
	protected Boolean bool;
	
	public Constante(Boolean bool){
	 	this.bool = bool;
	}
	
	@Override
	public String toString() {
		if (bool){
			return "⊤";
		}
		else
			return "⊥";
	}

	@Override
	public Set<String> variablesLibres() {
		Set<String> variablesLibres = new HashSet<String>();
		return variablesLibres;
	}

	@Override
	public Formule substitue(Substitution s) {
		if (s.get(bool.toString()) == null)
			return this;
		else
			return s.get(bool.toString());
	}

	@Override
	public boolean valeur() throws VariableLibreException {
		// TODO Auto-generated method stub
		return false;
	}

}
