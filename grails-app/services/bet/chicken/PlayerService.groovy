package bet.chicken

class PlayerService {

    def retrievePlayersLike(String query) {		
		def players =  Player.findAllByAliasIlike("%${query}%")
		players.collect {['value':it.alias]}
    }
	
	def getPlayer(String alias){
		Player.findByAlias(alias)
	}
}
