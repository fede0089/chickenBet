// Place your Spring DSL code here
import bet.chicken.*
beans = {

	memcachedCache( MemcachedCache )

	{

		defaultCacheTimeSeconds = grailsApplication.config.cache.duration;

		servers                 = grailsApplication.config.cache.servers;

	}
}
