package bet.chicken
class BetException extends RuntimeException{
	String message
	Bet bet	
}

class BetService {

    def createBet(BetCommandObject bco,String alias) {

		def player = Player.findByAlias(alias)
		def bet = new Bet(numbers:bco.numbers)
		if (player)
			player.addToCurrentBets(bet).save()
		else 		
			new Player(alias:alias).addToCurrentBets(bet).save()

    }
	
	def list(){
		Bet.list()
	}
	
	def checkWinners(BetCommandObject bco){
		def results = bco.numbers
		def allBets = list()
		def allMatches = allBets.collect{bet->
			[winnings:(bet.numbers.count {number-> results.contains(number)}),player:bet.player]
		}
		
		allMatches.groupBy {winner->
			winner.winnings
		}
		
		
		
	}
}
