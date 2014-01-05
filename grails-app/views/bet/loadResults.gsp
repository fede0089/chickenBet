<head>
	<meta name="layout" content="main" />
	<style>
		input[type=text] {
		font-weight: bolder;
		font-size: 20px;
		}
	</style>
</head>
<body>
<div class="row">
	<g:form action="checkWinners">
		<g:each in="${1..4}" var="col">
			<div class="col-md-3">
				<g:each in="${0..9}" var="fila">
					<div class="form-control-mock">
						<g:textField class="form-control text-center validateable" placeholder="Nro ${col+4*fila}" 
						value="${(col+4*fila)-1}" name="numbers[${(col+4*fila)-1}]" autocomplete="off"
						nonempty="true" numeric data-range="0..99"/>
						</br>
					</div>
				</g:each>
			</div>
		</g:each>
		<div class="text-center">
			<g:submitButton name="submitButton" value="Sortear" onClick="return \$('form').validate();"class="btn btn-danger btn-lg"/>
		</div>
	</g:form>
</div>
</body>