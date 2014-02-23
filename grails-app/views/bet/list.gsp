<head>
	<meta name="layout" content="main" />
	<style>
	/* Header cells */
		table.pretty thead th {
		    text-align: center;
		    background-color: #d9534f !important;
		    color:white;
		    
		}
		
		#betTable_filter {
			color:white;
		}
		
	</style>
</head>
<body>
	<div class="modal fade" id="newBet">
	  <div class="modal-dialog" style="width: 1100px;">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	        <h4 class="modal-title">Nueva apuesta</h4>
	      </div>
	      <div class="modal-body">
	      	  <div id="modalMsgs"></div>
		      <g:formRemote id="form" name="newbet" role="form" url='[action:"createBet"]' onSuccess="newBetSuccess();">
					<div class="form-group col-md-12">
						<label for="alias">Apodo</label>
						<g:textField id="alias" name="alias" class="form-control validateable" placeholder="Ingrese el apodo"
							nonempty data-label="Apodo"  
							data-provide="typeahead"  autocomplete="off"/>
					</div>
					<label class="col-md-12" for="">Numeros elegidos</label>
					<div class ="form-inline clearfix">
					<g:each in="${0..6}" var="i">
						<div class="form-group col-md-1">		
							<g:textField name="numbers[${i}]" class="form-control number validateable"
								autocomplete="off" nonempty numeric data-range="0..99" data-integer="yes"/>
						</div>
					</g:each>
					</div>
					</br>
					<div class="modal-footer">
					  <div class="form-group">
						    <button type="button" class="btn btn-danger pull-right btn-lg" data-dismiss="modal">Cerrar</button>
							<button id="submitButton" class="btn btn-primary btn-lg pull-right">Crear</button>
						</div>
					</div>
			</g:formRemote >
	      </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->			
	
	
	<p><a class="btn btn-danger btn-lg" data-toggle="modal" data-target="#newBet"><span class="glyphicon glyphicon-plus"></span> Nueva apuesta</a>
	<a class="btn btn-danger pull-right" onClick="printList()"><span class="glyphicon glyphicon-print"></span></a></p>

	<div id="betTableWrapper">
		<table class ="table table-hover pretty" id="betTable">
			<thead>
				<tr class="success">
					<th class="text-center">Apodo</th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th class="text-center hiddenCol">Eliminar</th>
			</thead>
			<tbody>
				<g:each in="${bets}" var="bet">
					<tr>
						<td class="text-center">${bet.player.alias}</td>
						<g:each in="${0..6}">
							<td class="text-center">${bet.numbers[it]}</td>
						</g:each>
						<td class="text-center hiddenCol"><g:remoteLink action="removeBet" controller="bet" params="[playerId:bet.player.id,betId:bet.id]" update="betTableWrapper" onSuccess="refreshDataTable()" onFailure="showRemoveError(XMLHttpRequest)" ><span class="glyphicon glyphicon-remove"></span></g:remoteLink></td>
					</tr>	
				</g:each>
			</tbody>
			<tfoot>
				<tr>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th class="hiddenCol"></th>
				</tr>
			</tfoot>
		</table>
		
		<div id="printableTable" class="hidden" >
			<table style="max-width:18cm;font-size:10px;" class="table table-bordered">
				<tbody>
					<g:each in="${bets}" var="bet">
						<tr>
							<td class="text-center" style="padding:0;">${bet.player.alias}</td>
							<g:each in="${0..6}">
								<td class="text-center" style="padding:0;">${bet.numbers[it]}</td>
							</g:each>
						</tr>	
					</g:each>
				</tbody>
			</table>
		</div>
		
		
	</div>
	
	<iframe id="printableIframe" class="hidden">	
	</iframe>
	
	<div id="iframeCss">		
		<style tyle="text/css">
			@page {   size: auto; margin: 2cm }
		</style>
		<link rel="stylesheet"	href="${resource(dir: 'css', file: 'bootstrap.min.css')}"/>
	</div>	
		
	<g:javascript>
	$(document).ready(function(){
		
		initDataTable();
		  
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
			var validatedOk = $('form').validate($("#modalMsgs"),'top');
			var data = {alias: $('#alias').val()};
			if (validatedOk)
				<g:remoteFunction action="verifyPlayerExistance" params="data" onSuccess ="doSubmit()" onFailure="XMLHttpRequest.status==404?askForNewPlayer():null" controller="player"/>;
		
			return false;
			
		});
		
		
		$('#newBet').on('hidden.bs.modal', function (e) {
			location.reload();	 
		})
		  
	});

	function askForNewPlayer(){
		var alias = $('#alias').val();
		var msg = '<h4>El apodo para "'+alias+'" no existe.</h4><p>¿Desea crearlo?</p><button type="button" onclick="doSubmit()"  data-dismiss="alert" class="btn btn-danger">Si</button><button type="button"  data-dismiss="alert" class="btn btn-default">No</button>'
		addMessage('warning ask',msg,$('#modalMsgs'),'top');
	}

	
	function newBetSuccess(){
		$(".number").val('');
		addMessage('success', "Creacion de apuesta exitosa.", $("#modalMsgs"), 'top');	
	}
	
	function doSubmit(){
		$('#form').submit();
	}
	
	function initDataTable(){
		$("#betTable").dataTable({
		  	"sDom": '<""f>rtp',
			"sPagination": "bs_normal",
			"oLanguage": {
			    "sProcessing":     "Procesando...",
			    "sLengthMenu":     "Mostrar _MENU_ registros",
			    "sZeroRecords":    "No se encontraron resultados",
			    "sEmptyTable":     "No hay apuestas cargadas.",
			    "sInfo":           "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
			    "sInfoEmpty":      "Mostrando registros del 0 al 0 de un total de 0 registros",
			    "sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
			    "sInfoPostFix":    "",
			    "sSearch":         "Buscar:",
			    "sUrl":            "",
			    "sInfoThousands":  ",",
			    "sLoadingRecords": "Cargando...",
			    "oPaginate": {
			        "sFirst":    "Primero",
			        "sLast":     "Último",
			        "sNext":     "Siguiente",
			        "sPrevious": "Anterior"
			    },
			    "oAria": {
			        "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
			        "sSortDescending": ": Activar para ordenar la columna de manera descendente"
			    }
			},
		    "aoColumnDefs": [
		                     { "bSortable": false, "aTargets": [ 1,2,3,4,5,6,7,8 ] }
		                    ]
		  });
		  
		hideSpinner();
	}
	
	function refreshDataTable(){
		initDataTable();
		addMessage('success', "Apuesta eliminada en forma exitosa.", $("#messages"), 'top');	
	}
	
	function showRemoveError(xhr){
	if (xhr.status==404)
		addMessage('danger', "Error. La apuesta ya fue eliminada", $("#messages"), 'top');
	else
		addMessage('danger', "Error al eliminar la apuesta", $("#messages"), 'top');
				
	}
	
	function printList(){
		iframeHtml=$("#printableTable").html();
		iframeCss = $("#iframeCss").html();
		$("#printableIframe").contents().find('head').html(iframeCss)	;	
		$("#printableIframe").contents().find('body').html(iframeHtml)	;		
		window.frames["printableIframe"].focus();
		window.frames["printableIframe"].print();
				
	}
	
	

	</g:javascript>
</body>