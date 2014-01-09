package bet.chicken

class Player {
	String alias
	
	static hasMany = [currentBets:CurrentBet]
	
	static constraints = {
		currentBets minSize:0
	}

}
