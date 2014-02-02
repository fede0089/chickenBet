package bet.chicken

import grails.plugin.databasesession.SessionProxyFilter
import javax.servlet.http.Cookie
import javax.servlet.http.HttpServletRequest

class MySessionProxyFilter extends SessionProxyFilter{
	
	@Override
	protected Cookie newCookie(String sessionId, HttpServletRequest request) {
		Cookie cookie = new Cookie(COOKIE_NAME, sessionId);
		cookie.setDomain(request.getServerName()); // TODO needs config option
		cookie.setPath(COOKIE_PATH);
		cookie.setSecure(request.isSecure());
		return cookie;
	}

}
