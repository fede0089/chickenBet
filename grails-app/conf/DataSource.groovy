dataSource {
    pooled = true
    driverClassName = "org.h2.Driver"
    username = "sa"
    password = ""
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory'
}
// environment specific settings
environments {
    development {
		
		
        dataSource {
            dbCreate = "create-drop" // one of 'create', 'create-drop', 'update', 'validate', ''
            url = "jdbc:h2:mem:devDb;MVCC=TRUE;LOCK_TIMEOUT=10000"
        }
		
		grails {
			mongo {
				host = "127.0.0.1"
				port = 27017
				databaseName = "chickenBet"
			}
		}
		/*	
		dataSource {			
				dbCreate = "create-drop"			
				url = "jdbc:sqlserver://FEDERICOM-PC:1433;"
				driverClassName="com.microsoft.sqlserver.jdbc.SQLServerDriver"	
				username = "sa"			
				password = "34847863"			
		}*/
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:h2:mem:testDb;MVCC=TRUE;LOCK_TIMEOUT=10000"
        }
    }
    production {
       /* dataSource {
            dbCreate = "update"
            url = "jdbc:h2:prodDb;MVCC=TRUE;LOCK_TIMEOUT=10000"
            pooled = true
            properties {
               maxActive = -1
               minEvictableIdleTimeMillis=1800000
               timeBetweenEvictionRunsMillis=1800000
               numTestsPerEvictionRun=3
               testOnBorrow=true
               testWhileIdle=true
               testOnReturn=true
               validationQuery="SELECT 1"
            }
        }*/
		
		dataSource {
			dbCreate = "update"
			driverClassName = "org.postgresql.Driver"
			dialect = org.hibernate.dialect.PostgreSQLDialect
	
			uri = new URI(System.env.DATABASE_URL?:"postgres://test:test@localhost/test")
	
			url = "jdbc:postgresql://"+uri.host+uri.path
			username = uri.userInfo.split(":")[0]
			password = uri.userInfo.split(":")[1]
		}
		
		grails {
			mongo {
				host = "dharma.mongohq.com"
				port = 10081
				username = "fede0089"
				password = "jefe2013"
				databaseName = "chickenBet"
			}
		}
    }
}
