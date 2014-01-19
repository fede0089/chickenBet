package bet.chicken

class History {
	List<String> sevenWinners
	List<String> fiveWinners
	List<String> sixWinners
	Date lotteryDate
	LotteryResults results
	List<OldBet> oldBets
	
	static embedded = ['oldBets','results']
	
	static mapWith = "mongo"

	static hasMany=[oldBets:OldBet]

    static constraints = {
    }
}
