package bet.chicken

class History {
	List<Map<Integer,Player>> winnings
	Date lotteryDate
	LotteryResults results
	List<OldBet> oldBets
	
	static embedded = ['oldBets','results']
	
	static mapWith = "mongo"

	static hasMany=[oldBets:OldBet]

    static constraints = {
    }
}
