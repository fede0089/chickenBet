package bet.chicken
import net.spy.memcached.MemcachedClient
import org.springframework.beans.factory.InitializingBean
import net.spy.memcached.AddrUtil


import grails.transaction.Transactional

@Transactional
class MemcachedService implements InitializingBean {

	static final Object NULL = "NULL"
	def MemcachedClient memcachedClient

	def void afterPropertiesSet() {
		memcachedClient = new MemcachedClient(AddrUtil.getAddresses("127.0.0.1:11211"))
	}

	def get(String key) {
		return memcachedClient.get(key)
	}

	def set(String key, Object value) {
		memcachedClient.set(key, 600, value)
	}

	def delete(String key) {
		memcachedClient.delete(key)
	}

	def clear() {
		memcachedClient.flush()
	}

	def update(key, function) {
		def value = function()
		if (value == null) value = NULL
		set(key, value)
		return value
	}

	def get(key, function) {
		def value = get(key)
		if (value == null) {
			value = update(key, function)
		}
		return (value == NULL) ? null : value;
	}
}
