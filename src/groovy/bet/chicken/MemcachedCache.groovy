package bet.chicken

import java.util.concurrent.Future
import java.util.concurrent.TimeUnit
import java.util.concurrent.TimeoutException

import net.spy.memcached.AddrUtil
import net.spy.memcached.ConnectionFactoryBuilder
import net.spy.memcached.DefaultHashAlgorithm
import net.spy.memcached.MemcachedClient
import net.spy.memcached.internal.BulkFuture
import net.spy.memcached.transcoders.Transcoder

import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory
import org.springframework.beans.factory.BeanNameAware
import org.springframework.beans.factory.InitializingBean

class MemcachedCache implements InitializingBean, BeanNameAware {
	private static Log log = LogFactory.getLog( this );

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
		if( !servers )
		{
			//throw new IllegalArgumentException( "Memcached server was not set." );
			servers="127.0.0.1:2550"
		}

		log.debug( "Initializing memcached server $servers" );

		ConnectionFactoryBuilder connectionFactoryBuilder = new ConnectionFactoryBuilder();
		connectionFactoryBuilder.setHashAlg( DefaultHashAlgorithm.KETAMA_HASH );
		connectionFactoryBuilder.setProtocol( ConnectionFactoryBuilder.Protocol.BINARY );
		connectionFactoryBuilder.setOpTimeout( timeoutInMillis );

		cache = new MemcachedClient( connectionFactoryBuilder.build(), AddrUtil.getAddresses( servers ) );

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
}

