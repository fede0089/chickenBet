package bet.chicken

import net.spy.memcached.transcoders.SerializingTranscoder

import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory

/**
 * @author: Pablo Molnar
 * @since: Sep 12, 2010
 */
public class GroovyObjectsTranscoder extends SerializingTranscoder
{
	private static Log log  = LogFactory.getLog( this );
	
	private def classLoader = GroovyObjectsTranscoder.classLoader;

	boolean doCompression()
	{
		return true;
	}

	/**
	 * Deserialize groovy objects. Classloader workaround
	 */
	protected Object deserialize( byte[] bytes )
	{
		Object object;

		try
		{
			def fis   = new ByteArrayInputStream( bytes );
			def input = new GroovyObjectInputStream( fis, classLoader );
			object    = input.readObject();
			
			input.close();
			fis.close();
		}
		catch( e )
		{
			log.error( "Error deserializing object from memcached.", e.message );
		}

		return object;
	}

	private class GroovyObjectInputStream extends ObjectInputStream
	{
		private ClassLoader myClassLoader;

		public GroovyObjectInputStream( ClassLoader myClassLoader ) throws IOException, SecurityException
		{
			super();
			this.myClassLoader = myClassLoader;
		}

		public GroovyObjectInputStream( InputStream input, ClassLoader myClassLoader ) throws IOException
		{
			super( input )
			this.myClassLoader = myClassLoader;
		}

		@Override
		protected Class<?> resolveClass( ObjectStreamClass desc ) throws IOException, ClassNotFoundException
		{
			String name = desc.getName();
			return Class.forName( name, false, myClassLoader );
		}
	}
}