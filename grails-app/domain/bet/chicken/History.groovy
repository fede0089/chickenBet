package bet.chicken

class History {
	List<Map<Integer,Player>> winnings
	Date lotteryDate
	LotteryResults results

	
	static hasMany=[oldBets:OldBet]

    static constraints = {
    }
}
