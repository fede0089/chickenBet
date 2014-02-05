<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title><g:layoutTitle default="Grails" /></title>
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'bootstrap.min.css')}"
	type="text/css">
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'typeahead.js-bootstrap.css')}"
	type="text/css">
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'jquery.dataTables.css')}"
	type="text/css">
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'datatables.css')}" type="text/css">
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'TableTools.css')}" type="text/css">
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'datepicker.css')}" type="text/css">
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'custom_spinner.css')}" type="text/css">
<g:javascript library="jquery" plugin="jquery" />
<g:layoutHead />
<r:layoutResources />
</head>
<body style="background-color: rgba(76, 11, 214, 0.5)">
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation"
		style="background-color: #101010;">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-ex1-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<!-- You'll want to use a responsive image option so this logo looks good on devices - I recommend using something like retina.js (do a quick Google search for it and you'll find it) -->
				<a class="navbar-brand logo-nav" href="/ChickenBet"><g:img
						file="logo2.png" /></a>
			</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse navbar-ex1-collapse">
				<ul class="nav navbar-nav navbar-right">
					<li><g:link action="list" controller="bet">
							<h4>Ver apuestas</h4>
						</g:link></li>
					<li><g:link action="loadResults" controller="bet">
							<h4>Sorteo</h4>
						</g:link></li>
					<li><g:link action="history" controller="bet">
							<h4>Historial</h4>
						</g:link></li>
					<sec:ifLoggedIn>
						<li>
							<h4
								style="margin-top: 10px; margin-bottom: 10px; padding: 10px 15px; color: grey; line-height: 20px; padding-top: 15px; padding-bottom: 15px;">
								Bienvenido,
								<sec:username />
								<g:remoteLink controller='logout'
									onSuccess="window.location.reload(true)"> (Salir) </g:remoteLink>
							</h4>
						</li>
					</sec:ifLoggedIn>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</nav>
	<g:img file="balls.png"
		style="height:80%;position:absolute;top:110;right:0;z-index:-99" />
	<div class="container" style="margin-top: 115px;">
		</br>
		<div id="messages"></div>
		<center>
			<div id="floatingCirclesG">
				<div class="f_circleG" id="frotateG_01"></div>
				<div class="f_circleG" id="frotateG_02"></div>
				<div class="f_circleG" id="frotateG_03"></div>
				<div class="f_circleG" id="frotateG_04"></div>
				<div class="f_circleG" id="frotateG_05"></div>
				<div class="f_circleG" id="frotateG_06"></div>
				<div class="f_circleG" id="frotateG_07"></div>
				<div class="f_circleG" id="frotateG_08"></div>
			</div>
		</center>
		<div id="bodyContainer"  style="display: none;">
			<g:layoutBody />
		</div>
	</div>
	<div class="footer"></div>
	<div id="spinner" class="spinner" style="display: none;">
		<g:message code="spinner.alt" default="Loading&hellip;" />
	</div>
	<script>
	function hideSpinner(){
	  $("#floatingCirclesG").hide();
	  $("#bodyContainer").show();
	}
	</script>
	<g:javascript src="bootstrap.min.js" />
	<g:javascript src="validator.js" />
	<g:javascript src="typeahead.min.js" />
	<g:javascript src="jquery.dataTables.min.js" />
	<g:javascript src="datatables.js" />
	<g:javascript src="ZeroClipboard.js" />
	<g:javascript src="TableTools.js" />
	<g:javascript src="bootstrap-datepicker.js" />
	<r:layoutResources />
</body>
</html>
