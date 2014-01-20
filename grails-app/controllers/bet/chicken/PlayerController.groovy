package bet.chicken
import grails.plugin.springsecurity.annotation.Secured
import grails.converters.JSON

class PlayerException extends RuntimeException{
	String message
	Player player
}

@Secured(['ROLE_ADMIN'])
class PlayerController {
	
	def playerService
	
	static scaffold  = true
	
	def query(String id){
		
		def players 
		try {
			players = playerService.retrievePlayersLike(id)
		}
		catch (PlayerException p){
			//TODO - Throw exception
		}
		render players as JSON
	}
	
	def verifyPlayerExistance(String alias){
		def player
		try {
			player = playerService.getPlayer(alias)
		}
		catch (PlayerException p){
			//TODO - Throw exception
		}
	
		render status:((!player)?404:200)
			
	}
}
