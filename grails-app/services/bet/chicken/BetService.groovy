package bet.chicken
class BetException extends RuntimeException{
	String message
	Bet bet	
}

class BetService {

    def createBet(BetCommandObject bco) {

		def player = Player.findByAlias(bco.alias)
		def bet = new Bet(numbers:bco.numbers)
		if (player)
			player.addToCurrentBets(bet).save()
		else 		
			new Player(alias:bco.alias).addToCurrentBets(bet).save()

    }
	
	def list(){
		Bet.list()
	}
}
