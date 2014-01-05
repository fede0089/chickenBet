package bet.chicken

import java.util.logging.Logger;

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

		//Iterates over all bets
		def allMatches = allBets.collect{bet->

			//New array for missing Numbers
			def missing =[]
			missing.addAll(bet.numbers)
			
			//New array for matched Numbers
			def matched = []

			//Return winners map with [winnings : aciertos, player: jugador, missing: numeros que faltaron,matched: numeros acertados]
			def quantity = bet.numbers.count {number->
				if (results.contains(number)){
					matched.add(number)					
					missing.remove(number as Object)
				}

			}
			
			[winnings:quantity,player:bet.player,missing:missing,matched:matched]
		}

		allMatches.groupBy {winner->
			winner.winnings
		}
	}
	
	def saveHistory (BetCommandObject bco,winners){
		//TODO
		
		def lotteryResults = new LotteryResults(results:bco.numbers)
	
		def history = new History(lotteryDate:bco.date,results:lotteryResults,winners:winners).save()
		
		if (!history)
			throw new BetException(message:"Error al guardar la historia")
			
	}
}
