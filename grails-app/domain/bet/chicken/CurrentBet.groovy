package bet.chicken

class CurrentBet extends Bet{
	
	static belongsTo=[player:Player]
	
    static constraints = {
    }
}
