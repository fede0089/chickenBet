package bet.chicken

import grails.converters.JSON

class PlayerException extends RuntimeException{
	String message
	Player player
}

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
			playerService.getPlayer(alias)
		}
		catch (PlayerException p){
			//TODO - Throw exception
		}
	
		render (!player)? [status:404]:[status:200]
			
	}
}
