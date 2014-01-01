package bet.chicken

import grails.converters.JSON

class PlayerController {
	static scaffold  = true
	
	def query(String id){
		def players =  Player.findAllByAliasIlike("%${id}%")
		def result = players.collect {['value':it.alias]}
		render result as JSON
	}
	
	def verifyPlayerExistance(String alias){
		def player = Player.findByAlias(alias)
		if (!player)
			render status:404
		else
			render status:200
			
	}
}
