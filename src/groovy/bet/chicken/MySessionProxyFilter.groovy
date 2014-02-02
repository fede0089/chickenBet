package bet.chicken

import grails.plugin.databasesession.SessionProxyFilter
import javax.servlet.http.Cookie
import javax.servlet.http.HttpServletRequest

class MySessionProxyFilter extends SessionProxyFilter{
	
	@Override
	protected Cookie newCookie(String sessionId, HttpServletRequest request) {
		Cookie cookie = new Cookie(COOKIE_NAME, sessionId);
		//TODO Workaround
		if (request.getServerName()!="localhost")
			cookie.setDomain(request.getServerName()); // TODO needs config option
		cookie.setPath("/");
		cookie.setSecure(request.isSecure());
		return cookie;
	}

}
