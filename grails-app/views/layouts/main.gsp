<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="Grails"/></title>
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.min.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'typeahead.js-bootstrap.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.dataTables.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'datatables.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'TableTools.css')}" type="text/css">
		<g:javascript library="jquery" plugin="jquery"/>		
		<g:layoutHead/>
		<r:layoutResources />
	</head>
	<body>
		<div id="grailsLogo" role="banner"><a href="http://grails.org"><img src="${resource(dir: 'images', file: 'grails_logo.png')}" alt="Grails"/></a></div>
		<div class="container">
			<div id="messages"></div>
			<g:layoutBody/>
		</div>
		<div class="footer" role="contentinfo"></div>
		<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
		<g:javascript src="bootstrap.min.js" />
		<g:javascript src="validator.js"/>
		<g:javascript src="typeahead.min.js" />
		<g:javascript src="jquery.dataTables.min.js" />
		<g:javascript src="datatables.js" />
		<g:javascript src="ZeroClipboard.js" />
		<g:javascript src="TableTools.js" />
		<r:layoutResources />
	</body>
</html>
