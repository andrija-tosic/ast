package SymbolTable;

public class SymbolTable {
	
	/*tabela simbola za "language scope"
	u ovom slucaju tu pripadaju samo tipovi*/
	private SymbolNode types;
	
	/* tabela simbola za oblast vazenja programa */
	private SymbolNode variables;

	int typeKindIndex;
	
	public SymbolTable( )
	{
		types = new Type( "unknown", Type.UNKNOWN, null);
		types = new Type( "char", Type.CHAR, types );
		types = new Type( "int", Type.INT, types );
		types = new Type( "double", Type.DOUBLE, types );
		variables = null;
		types = null;

		typeKindIndex = 5;
	}

	public boolean addVar(String name, Type type)
	{
		Variable existing = this.getVar( name );
		if (existing != null)
			return false;

		variables = new Variable( name, type, variables );
		return true;
	}
	
	public Variable getVar( String name )
	{
		SymbolNode current = variables;
		while ( current != null && 
				current.name.compareTo( name ) != 0 )
			current = current.next;
		return ( Variable ) current;
	}

	public boolean addType(String name ) {
		Type existing = this.getType(name);
		if (existing != null)
			return false;

		types = new Type(name, typeKindIndex++, types);
		return true;
	}
	
	public Type getType(String typeName)
	{
		SymbolNode current = types;
		while ( current != null && 
				current.name.compareTo( typeName ) != 0 )
			current = current.next;
		return ( Type ) current;
	}
	
	public SymbolNode getVariables()
	{
		return variables;
	}

}
