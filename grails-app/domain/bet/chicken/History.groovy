package bet.chicken

class History {
	List<Map<Integer,Player>> winnings
	Date lotteryDate
	LotteryResults results
	
	static hasMany=[players:Player]

    static constraints = {
    }
}
