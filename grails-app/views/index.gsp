<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>Chicken Bet v01</title>
		
	</head>
	<body>
		<div class="container">
		  <h1 class="text-center">¿Que desea hacer?</h1>
		  </br>
		  </br>
		  <p class="text-center"><g:link action="list" controller="bet" class="btn btn-danger btn-lg">
		      <span class="glyphicon glyphicon-usd a-btn-symbol"></span> Ver apuestas		  
		 </g:link></p>
		  <p class="text-center"><g:link  action="loadResults" controller="bet" c class="btn btn-danger btn-lg">
		  	<span class="glyphicon glyphicon-registration-mark"></span>  Sorteo
		  </g:link></p>
		  <p class="text-center"><g:link class="btn btn-danger btn-lg">
		  	<span class="glyphicon glyphicon-folder-open"></span>  Historial
		  </g:link></p>
		  <g:img file="balls.png" class="pull-right"/>
		</div>
	</body>
</html>
