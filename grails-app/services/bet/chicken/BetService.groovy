package bet.chicken

import java.util.logging.Logger;

class BetException extends RuntimeException{
	String message
	Bet bet
}

class BetService {

	def createBet(BetCommandObject bco,String alias) {

		def player = Player.findByAlias(alias)
		def bet = new CurrentBet(numbers:bco.numbers)
		if (player)
			player.addToCurrentBets(bet).save()
		else
			new Player(alias:alias).addToCurrentBets(bet).save()

	}

	def removeBet(playerId,betId){
		def player = Player.get(playerId)
		def bet = CurrentBet.get(betId)
		if (!player.currentBets.remove(bet))
			throw new BetException(message:"Not found")
		
	}
	
	def list(){
		CurrentBet.list()
	}
	
	def listOldBets(){
		OldBet.list()
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
		
		def betsToSave = CurrentBet.list().collect {actualBet->
			def betToSave = new OldBet()
			betToSave.properties=actualBet.properties
			betToSave.lotteryDate = bco.date
			betToSave.playerName=actualBet.player.alias
			betToSave
		}
		
		def sevenWinners=winners[7]?winners[7]*.player.alias:[]
		def sixWinners=winners[6]?winners[6]*.player.alias:[]
		def fiveWinners=winners[5]?winners[5]*.player.alias:[]			
	
		def history = new History(lotteryDate:bco.date,results:lotteryResults,sevenWinners:sevenWinners,sixWinners:sixWinners,fiveWinners:fiveWinners,,oldBets:betsToSave).save()
		
		if (!history)
			throw new BetException(message:"Error al guardar la historia")
			
	}
	
	def getHistoryByDate(Date lotteryDate){
		def history = History.findByLotteryDate(lotteryDate)
		if (!history)
			throw new BetException(message:"History not found")
		history
	}
}
