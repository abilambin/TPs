package logicline.modeleSemantique;

import java.util.HashSet;
import java.util.Set;

public class Variable extends Formule {

	protected String v;
	
	public Variable(String v){
	 	this.v = v;
	}
	
	@Override
	public String toString() {
		return v;
	}

	@Override
	public Set<String> variablesLibres() {
		Set<String> variablesLibres = new HashSet<String>();
		variablesLibres.add(v);
		return variablesLibres;
	}

	@Override
	public Formule substitue(Substitution s) {
		if (s.get(v) == null)
			return this;
		else
			return s.get(v);
	}

	@Override
	public boolean valeur() throws VariableLibreException {
		// TODO Auto-generated method stub
		return false;
	}

}
