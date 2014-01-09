package bet.chicken

class OldBet extends Bet {
	
	String playerName
	Date lotteryDate
	
	static belongsTo=History

    static constraints = {
    }
}
