package bet.chicken

class BetCommandObject{
	String alias
	List<Integer> numbers
}

class BetController {

	def betService
	def playerService

	static scaffold  = true

	def createBetForm(){

	}

	def createBet(BetCommandObject bco) {
		try{
			def player= betService.createBet(bco)
		}
		catch (BetException e){
			//TO-DO
		}
		
		render status:200
	
		
	}
	
	def list(){
		def bets = betService.list()
		[bets:bets]
	}
	
}
