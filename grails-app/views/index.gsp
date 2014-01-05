<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>Chicken Bet v01</title>
		<style>
			.btn-custom{
				width:150px;
			}
		</style>
	</head>
	<body>
		<div class="container">
		  </br>
		  <p class="text-center"><g:link action="list" controller="bet" class="btn btn-danger btn-lg btn-custom">
		      <span class="glyphicon glyphicon-usd a-btn-symbol"></span> Ver apuestas		  
		 </g:link></p>
		  <p class="text-center"><g:link  action="loadResults" controller="bet" c class="btn btn-danger btn-lg btn-custom">
		  	<span class="glyphicon glyphicon-registration-mark"></span>  Sorteo
		  </g:link></p>
		  <p class="text-center"><g:link class="btn btn-danger btn-lg btn-custom">
		  	<span class="glyphicon glyphicon-folder-open"></span>  Historial
		  </g:link></p>
		  <g:img file="ruleta.png" style="width:90%;position:absolute;bottom:0;left:0; z-index:-99;"/>
		</div>
	</body>
</html>
