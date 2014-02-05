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

<style>
#floatingCirclesG {
    position: relative;
    width: 128px;
    height: 128px;
    -moz-transform: scale(0.6);
    -webkit-transform: scale(0.6);
    -o-transform: scale(0.6);
    -ms-transform: scale(0.6);
    transform: scale(0.6);
}

.f_circleG {
    position: absolute;
    background-color: #FFFFFF;
    height: 23px;
    width: 23px;
    -moz-border-radius: 12px;
    -moz-animation-name: f_fadeG;
    -moz-animation-duration: 1.04s;
    -moz-animation-iteration-count: infinite;
    -moz-animation-direction: linear;
    -webkit-border-radius: 12px;
    -webkit-animation-name: f_fadeG;
    -webkit-animation-duration: 1.04s;
    -webkit-animation-iteration-count: infinite;
    -webkit-animation-direction: linear;
    -o-border-radius: 12px;
    -o-animation-name: f_fadeG;
    -o-animation-duration: 1.04s;
    -o-animation-iteration-count: infinite;
    -o-animation-direction: linear;
    -ms-border-radius: 12px;
    -ms-animation-name: f_fadeG;
    -ms-animation-duration: 1.04s;
    -ms-animation-iteration-count: infinite;
    -ms-animation-direction: linear;
    border-radius: 12px;
    animation-name: f_fadeG;
    animation-duration: 1.04s;
    animation-iteration-count: infinite;
    animation-direction: linear;
}

#frotateG_01 {
    left: 0;
    top: 52px;
    -moz-animation-delay: 0.39s;
    -webkit-animation-delay: 0.39s;
    -o-animation-delay: 0.39s;
    -ms-animation-delay: 0.39s;
    animation-delay: 0.39s;
}

#frotateG_02 {
    left: 15px;
    top: 15px;
    -moz-animation-delay: 0.52s;
    -webkit-animation-delay: 0.52s;
    -o-animation-delay: 0.52s;
    -ms-animation-delay: 0.52s;
    animation-delay: 0.52s;
}

#frotateG_03 {
    left: 52px;
    top: 0;
    -moz-animation-delay: 0.65s;
    -webkit-animation-delay: 0.65s;
    -o-animation-delay: 0.65s;
    -ms-animation-delay: 0.65s;
    animation-delay: 0.65s;
}

#frotateG_04 {
    right: 15px;
    top: 15px;
    -moz-animation-delay: 0.78s;
    -webkit-animation-delay: 0.78s;
    -o-animation-delay: 0.78s;
    -ms-animation-delay: 0.78s;
    animation-delay: 0.78s;
}

#frotateG_05 {
    right: 0;
    top: 52px;
    -moz-animation-delay: 0.91s;
    -webkit-animation-delay: 0.91s;
    -o-animation-delay: 0.91s;
    -ms-animation-delay: 0.91s;
    animation-delay: 0.91s;
}

#frotateG_06 {
    right: 15px;
    bottom: 15px;
    -moz-animation-delay: 1.04s;
    -webkit-animation-delay: 1.04s;
    -o-animation-delay: 1.04s;
    -ms-animation-delay: 1.04s;
    animation-delay: 1.04s;
}

#frotateG_07 {
    left: 52px;
    bottom: 0;
    -moz-animation-delay: 1.17s;
    -webkit-animation-delay: 1.17s;
    -o-animation-delay: 1.17s;
    -ms-animation-delay: 1.17s;
    animation-delay: 1.17s;
}

#frotateG_08 {
    left: 15px;
    bottom: 15px;
    -moz-animation-delay: 1.3s;
    -webkit-animation-delay: 1.3s;
    -o-animation-delay: 1.3s;
    -ms-animation-delay: 1.3s;
    animation-delay: 1.3s;
}

@-moz-keyframes f_fadeG {
    0% {
        background-color: #000000;
    }

    100% {
        background-color: #FFFFFF;
    }
}

@-webkit-keyframes f_fadeG {
    0% {
        background-color: #000000;
    }

    100% {
        background-color: #FFFFFF;
    }
}

@-o-keyframes f_fadeG {
    0% {
        background-color: #000000;
    }

    100% {
        background-color: #FFFFFF;
    }
}

@-ms-keyframes f_fadeG {
    0% {
        background-color: #000000;
    }

    100% {
        background-color: #FFFFFF;
    }
}

@keyframes f_fadeG {
    0% {
        background-color: #000000;
    }

    100% {
        background-color: #FFFFFF;
    }
}

</style> 

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
