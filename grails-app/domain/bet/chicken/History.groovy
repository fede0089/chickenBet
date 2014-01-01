package bet.chicken

class History {
	Map<Integer,String> winnings
	Date lotteryDate
	LotteryResults results
	
	static hasMany=[players:Player]

    static constraints = {
    }
}
