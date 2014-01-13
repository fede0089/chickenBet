package bet.chicken

class Player {
	String alias
	
	static hasMany = [currentBets:CurrentBet]
	
	static constraints = {
		currentBets minSize:0
	}
	
	static mapping = {
		currentBets cascade: "all-delete-orphan"
	}

}
