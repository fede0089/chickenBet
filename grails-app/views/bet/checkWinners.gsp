<head>
	<meta name="layout" content="main" />
</head>
<body>
	<h2>7 aciertos:</h2>
	<g:each in="${winners[7]}" var="winner">
		<h4>${winner.player.alias}</h4>
	</g:each>
	<h2>6 aciertos:</h2>
	<g:each in="${winners[6]}" var="winner">
		<h4>${winner.player.alias}</h4>
	</g:each>
	<h2>5 aciertos:</h2>
	<g:each in="${winners[5]}" var="winner">
		<h4>${winner.player.alias}</h4>
	</g:each>
</body>