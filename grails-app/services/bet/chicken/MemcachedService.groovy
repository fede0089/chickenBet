package bet.chicken
import net.spy.memcached.DefaultHashAlgorithm

import org.codehaus.groovy.grails.web.servlet.GrailsApplicationAttributes
import org.apache.commons.logging.LogFactory

import grails.util.GrailsUtil
import grails.util.Environment

import java.util.List;
import java.util.Map;
import java.util.concurrent.Future;
import java.util.concurrent.TimeoutException
import java.util.concurrent.Future
import java.util.concurrent.TimeUnit
import java.util.concurrent.TimeoutException

import  grails.plugin.databasesession.SessionProxyFilter
import net.spy.memcached.ConnectionFactoryBuilder
import net.spy.memcached.MemcachedClient
import net.spy.memcached.auth.AuthDescriptor
import net.spy.memcached.auth.PlainCallbackHandler

import org.apache.commons.logging.Log;
import org.grails.datastore.mapping.validation.ValidationException
import org.springframework.beans.factory.InitializingBean

import net.spy.memcached.AddrUtil
import net.spy.memcached.internal.BulkFuture
import net.spy.memcached.transcoders.Transcoder;
import grails.plugin.databasesession.InvalidatedSessionException;
import grails.plugin.databasesession.PersistentSession;
import grails.plugin.databasesession.Persister
import groovy.lang.Closure;


class MemcachedService implements InitializingBean,Persister {

	def grailsApplication

	private MemcachedClient cache;

	def             name                    = 'default';
	int             defaultCacheTimeSeconds = 21600;       // default 2 minutes
	long            timeoutInMillis         = 800;          // default 800 ms
	String          servers;
	Transcoder      transcoder;
	def             useAsync                = false;
	
	void setBeanName( String beanName )
	{
		name = beanName
	}

	void afterPropertiesSet()
	{
		log.debug( "Initializing memcached server $servers" );


		if (Environment.current==Environment.PRODUCTION){
			try {
				AuthDescriptor ad = new AuthDescriptor(["PLAIN" ],
					new PlainCallbackHandler(System.getenv("MEMCACHEDCLOUD_USERNAME"), System.getenv("MEMCACHEDCLOUD_PASSWORD")));
			
				 cache = new MemcachedClient(
						  new ConnectionFactoryBuilder()
							  .setProtocol(ConnectionFactoryBuilder.Protocol.BINARY)
							  .setAuthDescriptor(ad).build(),
					  AddrUtil.getAddresses(System.getenv("MEMCACHEDCLOUD_SERVERS")));
			
			} catch (IOException ex) {
				// the Memcached client could not be initialized.
			}
		}
		else{
			if( !servers )
			{
				//throw new IllegalArgumentException( "Memcached server was not set." );
				servers="127.0.0.1:11211"
			}
			ConnectionFactoryBuilder connectionFactoryBuilder = new ConnectionFactoryBuilder();
			connectionFactoryBuilder.setHashAlg( DefaultHashAlgorithm.KETAMA_HASH );
			connectionFactoryBuilder.setProtocol( ConnectionFactoryBuilder.Protocol.BINARY );
			connectionFactoryBuilder.setOpTimeout( timeoutInMillis );
			cache = new MemcachedClient( connectionFactoryBuilder.build(), AddrUtil.getAddresses( servers ) );

		}
			
		
		if( !transcoder )
		{
			transcoder = new GroovyObjectsTranscoder( compressionThreshold : 1024 * 1024 );
		}
	}

	Future getAsync( key )
	{
		log.info( "Async request key $key from cache $name" );

		if( key in String )
		{
			return cache.asyncGet( key, transcoder );
		}

		if( key in Collection )
		{
			return cache.asyncGetBulk( key, transcoder );
		}

		throw new IllegalArgumentException( "Key must be a String or Collection<String> and was: $key" );
	}

	def get( key )
	{
		if( !key )
		{
			log.debug( "Invalid key : ${key}" );
			throw new IllegalArgumentException( "key was $key" );
		}

		def value;

		if( key in Collection )
		{
			log.debug( "Key collection : ${key}" );
			value = getBulk( key );
		}
		else
		{
			if( key in String )
			{
				log.debug( "Single key : ${key}" );
				value = getSingle( key );
			}
			else
			{
				log.debug( "Invalid key : ${key}" );
				throw new IllegalArgumentException( "key must be a String or Collection<String> and was: $key" );
			}
		}

		//log.debug( "Value content:\n $value" );

		return value;
	}

	def get( String key, Closure closure )
	{
		def value = get( key );
		if( value )
		{
			return value;
		}

		def object = closure.call();
		if( object != null )
		{
			put( key, object );
		}

		return object;
	}

	private def getSingle( String key )
	{
		log.info( "Request key $key from cache $name" );

		if( useAsync )
		{
			Future<Object> f;
			try
			{
				f = cache.asyncGet( key, transcoder );
				f.get( timeoutInMillis, TimeUnit.MILLISECONDS );
			}
			catch( TimeoutException e )
			{
				f?.cancel( true );
			}
			catch( e )
			{
				log.error( "Error getting key $key from memcached", e );
			}
		}
		else
		{
			try
			{
				return cache.get( key, transcoder );
			}
			catch( e )
			{
				log.error( "Error getting key $key from memcached", e );
				return null;
			}
		}
	}

	private Map getBulk( keys )
	{
		log.info( "Request bulk with keys $keys from cache $name" );

		if( useAsync )
		{
			BulkFuture<Object> f;
			try
			{
				f = cache.asyncGetBulk( keys, transcoder );
				f.getSome( timeoutInMillis, TimeUnit.DAYS )( timeoutInMillis, TimeUnit.MILLISECONDS );
				if( f.timeout )
				{
					log.error( "Not all keys retrieved from memcached due to memcached timeouts" );
				}
			}
			catch( TimeoutException e )
			{
				f?.cancel( true );
			}
			catch( e )
			{
				log.error( "Error getting key $key from memcached", e );
			}
		}
		else
		{
			try
			{
				return cache.getBulk( keys, transcoder );
			}
			catch( e )
			{
				log.error( "Error getting bulk with keys $keys from memcached", e );
				return [:];
			}
		}
	}

	void put( String key, value, cacheTimeSeconds = defaultCacheTimeSeconds )
	{
		assert value != null, "Value can't be null.";

		log.info( "Adding key $key to cache $name for $cacheTimeSeconds seconds." );

		try
		{
			cache.set( key, cacheTimeSeconds, value, transcoder );
		}
		catch( e )
		{
			log.error( "Error putting key $key in memcached", e );
		}
	}

	def delete( String key )
	{
		log.info( "Delete key $key to cache $name" );

		try
		{
			cache.delete( key );
		}
		catch( e )
		{
			log.error( "Error deleting key $key in memcached", e );
		}
	}

	def clear()
	{
		log.info( "Clearing cache $name" );

		try
		{
			cache.flush();
		}
		catch( e )
		{
			log.error( "Error flushing memcached", e );
		}
	}

	Long increment( String key, int by = 1, cacheTimeSeconds = defaultCacheTimeSeconds )
	{
		log.info( "Increment key $key by $by" );

		try
		{
			return cache.incr( key, by, 1, cacheTimeSeconds );
		}
		catch( e )
		{
			log.error( "Error incrementing key $key in memcached", e );
			return 0;
		}
	}

	Long getIncrement( String key )
	{
		log.info( "Get increment key $key" );

		try
		{
			def value = getSingle( key );
			if( !value )
			{
				return 0;
			}

			return Long.parseLong( value.toString().trim() );
		}
		catch( e )
		{
			log.error( "Error getting increment key $key in memcached", e );
			return 0;
		}
	}

	@Override
	public Object getAttribute(String sessionId, String name)
			throws InvalidatedSessionException {
				
		if (name == null) return null

		if (GrailsApplicationAttributes.FLASH_SCOPE == name) {
			// special case; use request scope since a new deserialized instance is created each time it's retrieved from the session
			def fs = SessionProxyFilter.request.getAttribute(GrailsApplicationAttributes.FLASH_SCOPE)
			if (fs != null) {
				return fs
			}
		}

		try {
			def session = get(sessionId)
			checkInvalidated session
			session.lastAccessedTime = System.currentTimeMillis()

			def attribute = session[name]

			if (attribute != null && GrailsApplicationAttributes.FLASH_SCOPE == name) {
				SessionProxyFilter.request.setAttribute(GrailsApplicationAttributes.FLASH_SCOPE, attribute)
			}
			
			put(sessionId,session)

			return attribute
		}
		catch (e) {
			handleException e
		}
	}

	@Override
	public void setAttribute(String sessionId, String name, Object value)
			throws InvalidatedSessionException {
		
		if (name==null)
			return 

		if (value == null) {
			removeAttribute sessionId, name
			return
		}

		// special case; use request scope and don't store in session, the filter will set it in the session at the end of the request
		if (value != null && GrailsApplicationAttributes.FLASH_SCOPE == name) {
			if (value != GrailsApplicationAttributes.FLASH_SCOPE) {
				SessionProxyFilter.request.setAttribute(GrailsApplicationAttributes.FLASH_SCOPE, value)
				return
			}

			// the filter set the value as the key, so retrieve it from the request
			value = SessionProxyFilter.request.getAttribute(GrailsApplicationAttributes.FLASH_SCOPE)
		}

		try {
			def session = get(sessionId)
			checkInvalidated session
			session.lastAccessedTime = System.currentTimeMillis()
			session[name] = value
			put(sessionId,session)
			}
	
		catch (e) {
			handleException e
		}
		
	}

	@Override
	public void removeAttribute(String sessionId, String name)
			throws InvalidatedSessionException {
		if (name == null) return

		try {
			def session = get(sessionId)
			checkInvalidated session
			session.lastAccessedTime = System.currentTimeMillis()
			if(session[name])
				session.remove(name)
			put(sessionId,session)

		}
		catch (e) {
			handleException e
		}
		
	}
			
	
			

	@Override
	public List<String> getAttributeNames(String sessionId)
			throws InvalidatedSessionException {
		try {
			
			def session = get(sessionId)	
			session.keySet() as List
		}
		catch (e) {
			handleException e
		}
	}

	@Override
	public void invalidate(String sessionId) {
		try {
			def session =[:]
		//	PersistentSession session = PersistentSession.lock(sessionId)

			def conf = grailsApplication.config.grails.plugin.databasesession
			def deleteInvalidSessions = conf.deleteInvalidSessions ?: false
			if (deleteInvalidSessions) {
				delete(sessionId)
			}
			else {
				session.invalidated = true
				put(sessionId,session)
			}
		}
		catch (e) {
			handleException e
		}
	}

	
	
	@Override
	public void create(String sessionId) {
		try {
			if (get(sessionId)) 
				return		
			def session = [:]
			session.creationTime = System.currentTimeMillis()
			session.lastAccessedTime = session.creationTime
			session.id = sessionId
			session.maxInactiveInterval = 30
			put(sessionId,session)
			
		}
		catch (e) {
			handleException e
		}
		
	}

	@Override
	public long getLastAccessedTime(String sessionId)
			throws InvalidatedSessionException {
		def session = get(sessionId)
		checkInvalidated session
		session.lastAccessedTime
	}

	@Override
	public void setMaxInactiveInterval(String sessionId, int interval)
			throws InvalidatedSessionException {
		def session = get(sessionId)
		checkInvalidated session

		session.maxInactiveInterval = interval
		if (interval == 0) {
			invalidate sessionId
		}
		else
			put(sessionId,session)
		
	}

	@Override
	public int getMaxInactiveInterval(String sessionId)
			throws InvalidatedSessionException {
		def session = get(sessionId)
		checkInvalidated session
		session.maxInactiveInterval
	}

	@Override
	public boolean isValid(String sessionId) {
		def session = get(sessionId)
		if (session)
			!session.invalidated && session.lastAccessedTime > System.currentTimeMillis() - session.maxInactiveInterval * 1000 * 60
		else
			false
	}
	
	protected void handleException(e) {
		if (e instanceof InvalidatedSessionException || e instanceof ValidationException) {
			throw e
		}
		GrailsUtil.deepSanitize e
		log.error e.message, e
	}
	
	
	protected void checkInvalidated(Map session) {
		if (!session || session.invalidated) {
			throw new InvalidatedSessionException()
		}
	}
	
	protected void checkInvalidated(String sessionId) {
		Boolean invalidated = get(sessionId)?.invalidated
		if (invalidated == null || invalidated) {
			throw new InvalidatedSessionException()
		}
	}
}
