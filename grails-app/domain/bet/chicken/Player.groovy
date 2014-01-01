package bet.chicken

class Player {
	String alias
	
	static hasMany = [currentBets:Bet]
	
	static constraints = {
		currentBets minSize:0
	}

}
