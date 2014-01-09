package bet.chicken
import org.joda.time.DateTime
import org.joda.time.format.DateTimeFormat
import org.grails.databinding.BindingFormat

class BetCommandObject{
	
	@BindingFormat('dd/MM/yyyy')
	Date date
	List<Integer> numbers
}

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
			def date = DateTimeFormat.forPattern("EEEE dd/MM/yyyy").print(dateToFormat)
			render """<span style='color:white;'>No se registra un sorteo para la fecha <b><i>${date}</i></b></span></span>
					<g:link class='btn btn-danger' onClick='document.location.reload(true)'> Volver </g:link>"""
		}
		
		
	}
	
	def checkWinners(BetCommandObject bco){
		def winners
		try{
			winners = betService.checkWinners(bco)
			betService.saveHistory(bco,winners)
		}
		catch (BetException e){
			//TODO - Throw exception
		}
		render template:'checkWinners',model:[winners:winners]
	}
	
}
