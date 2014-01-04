package bet.chicken
class BetCommandObject{
	List<Integer> numbers
}

class BetController {

	def betService
	def playerService

	static scaffold  = true

	def createBet(BetCommandObject bco,	String alias) {
		def player
		
		try{
			player= betService.createBet(bco,alias)
		}
		catch (BetException e){
			//TODO - Throw exception
		}
		
		render status:200
	}
	
	def loadResults(){
		
	}
	
	def list(){
		def bets
		try{
			bets = betService.list()	
		}
		catch (BetException e){
			//TODO - Throw exception
		}
		[bets:bets]
	}
	
	def checkWinners(BetCommandObject bco){
		def winners
		try{
			winners = betService.checkWinners(bco)
		}
		catch (BetException e){
			//TODO - Throw exception
		}
		[winners:winners]
	}
	
}
