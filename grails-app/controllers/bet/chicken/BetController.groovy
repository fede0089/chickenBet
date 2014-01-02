package bet.chicken
class BetCommandObject{
	List<Integer> numbers
}

class BetController {

	def betService
	def playerService

	static scaffold  = true

	def createBet(BetCommandObject bco,	String alias) {
		try{
			def player= betService.createBet(bco,alias)
		}
		catch (BetException e){
			//TO-DO
		}
		
		render status:200
	}
	
	def loadResults(){
		
	}
	
	def list(){
		def bets = betService.list()
		[bets:bets]
	}
	
	def checkWinners(BetCommandObject bco){
		def winners = betService.checkWinners(bco)
		[winners:winners]
	}
	
}
