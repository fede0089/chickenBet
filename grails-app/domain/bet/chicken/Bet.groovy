package bet.chicken

abstract class Bet {
	
	List<Integer> numbers
	
	static hasMany =[numbers:Integer]


	static constraints = {
			numbers size:7..7
	}
		

}
