package bet.chicken
import grails.plugin.springsecurity.annotation.Secured
import org.joda.time.DateTime
import org.joda.time.format.DateTimeFormat
import org.grails.databinding.BindingFormat

class BetCommandObject{
	
	@BindingFormat('dd/MM/yyyy')
	Date date
	List<Integer> numbers
}
@Secured(['ROLE_ADMIN'])
class BetController {

	BetService betService
	PlayerService playerService
	
	
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
	
	def history(){
		
	}
	
	//BetCommandObject used only to bind date
	def getHistoryByDate(BetCommandObject bco){
		def history
		try{
			history = betService.getHistoryByDate(bco.date)
			render template:"history",model:[history:history]
		}
		catch (BetException e){
			def dateToFormat= new DateTime(bco.date)
			def date = DateTimeFormat.forPattern("EEEE dd/MM/yyyy").withLocale(new Locale("es", "ES")).print(dateToFormat)
			render "<span style='color:white;'>No se registra un sorteo para la fecha <b><i>${date}</i></b></span></span>"
		}
		
		
	}
	
	def checkWinners(BetCommandObject bco){
		def winners
		try{
			if (!betService.checkUniqueDate(bco.date))
				render status:409 
			winners = betService.checkWinners(bco)
			betService.saveHistory(bco,winners)
		}
		catch (BetException e){
			//TODO
		}
		render template:'checkWinners',model:[winners:winners]
	}
	
	def removeBet(String playerId,String betId){
		try {
			betService.removeBet(playerId,betId)
			def bets = betService.list()
			render template:"list",model:[bets:bets],status:200
		}
		catch (BetException be){
			render status:404
		}
		catch(Exception e){
			render status:500
		}
	}
	
}
