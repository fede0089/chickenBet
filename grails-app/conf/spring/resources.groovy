// Place your Spring DSL code here
import bet.chicken.*
beans = {
	sessionProxyFilter(bet.chicken.MySessionProxyFilter) {
		persister = ref('memcachedService')
	 }
	
	gormPersisterService(bet.chicken.MemcachedService){
		
	}
}
