<head>
	<meta name="layout" content="main" />
</head>
<body>
	<g:formRemote id="form" name="newbet" role="form" url='[action:"createBet"]' onSuccess="newBetSuccess();">
		<div class="form-group col-md-12">
			<label for="alias">Apodo</label>
			<g:textField id="alias" name="alias" class="form-control validateable" placeholder="Ingrese el apodo"
				nonempty data-label="Apado"  
				data-provide="typeahead"  autocomplete="off"/>
		</div>
		<label class="col-md-12" for="">Numeros elegidos</label>
		<div class ="form-inline clearfix">
		<g:each in="${0..6}" var="i">
			<div class="form-group col-md-1">		
				<g:textField name="numbers[${i}]" class="form-control number validateable"
					placeholder="Nro. ${i+1}"  nonempty numeric data-range="0..99" data-integer="yes"/>
			</div>
		</g:each>
		</div>
		</br>
	  <div class="form-group">
			<div class="col-md-offset-5 col-md-2">
				<button id="submitButton" class="btn btn-primary btn-lg">Crear</button>
			</div>
		</div>
	</g:formRemote >
	
	<g:javascript>

	function askForNewPlayer(){
		var alias = $('#alias').val();
		var msg = '<h4>El apodo para "'+alias+'" no existe.</h4><p>¿Desea crearlo?</p><button type="button" onclick="doSubmit()"  data-dismiss="alert" class="btn btn-danger">Si</button><button type="button"  data-dismiss="alert" class="btn btn-default">No</button>'
		addMessage('warning ask',msg,$('#messages'),'top');
	}

	
	function newBetSuccess(){
		$(".number").val('');
		addMessage('success', "Creacion de apuesta exitosa.", $("#messages"), 'top');	
	}
	
	function doSubmit(){
		$('#form').submit();
	}

	$(document).ready(function(){
		$("#alias").typeahead([
		  {
		  	limit:15,
		    remote:{
		    	url:'<g:createLink controller="player" action="query"/>/%QUERY',
		    	cache:false}    
		  }
		]);
		
		$("#submitButton").click(function(){
		
			$('.alert').alert('close');		
			var validatedOk = $('form').validate();
			var data = {alias: $('#alias').val()};
			if (validatedOk)
				<g:remoteFunction action="verifyPlayerExistance" params="data" onSuccess ="doSubmit()" onFailure="XMLHttpRequest.status==404?askForNewPlayer():null" controller="player"/>;
		
			return false;
			
		});
	});

	</g:javascript>
</body>