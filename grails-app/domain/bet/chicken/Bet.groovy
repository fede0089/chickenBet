package bet.chicken

class Bet {
	
	List<Integer> numbers
	
	static hasMany =[numbers:Integer]
	
	static belongsTo=[player:Player]

	static constraints = {
			numbers size:7..7
	}
		

}
