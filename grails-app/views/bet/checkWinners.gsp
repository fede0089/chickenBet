<head>
	<meta name="layout" content="main" />
</head>
<body>
	<g:each in="${winners}" var="winner">
		<h2>${winner.keySet()}${winner.values()*.alias}</h2>
	</g:each>
</body>