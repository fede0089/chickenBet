<%@ page import="org.joda.time.DateTime" %>
<%@ page import="org.joda.time.format.DateTimeFormat" %>


<!-- SHOW WINNERS MODAL -->
<div class="modal fade"  id="showWinnersModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">Ganadores</h4>
      </div>
      <div class="modal-body">
	      	<div class="panel panel-danger">
				  <div class="panel-heading">
				    <h3 class="panel-title"><b>7 aciertos</b><i> (${history.sevenWinners.size()})</i></h3>
				  </div>
				  <div class="panel-body">
				    	<g:if test="${history.sevenWinners}">
							<g:each in="${history.sevenWinners}" var="winner">
								<span style="font-size:20px;" class="label label-success">${winner}</span>
							</g:each>
						</g:if>
						<g:else>
							<span style="font-size:20px;" class="label label-danger">VACANTE</span>
						</g:else>
				  </div>
				</div>	
			<div class="panel panel-danger">
			  <div class="panel-heading">
			    <h3 class="panel-title"><b>6 aciertos </b><i>(${history.sixWinners.size()})</i></h3>
			  </div>
			  <div class="panel-body">
			    	<g:if test="${history.sixWinners}">
						<g:each in="${history.sixWinners}" var="winner">
							<span style="font-size:20px;" class="label label-success">${winner}</span>
						</g:each>
					</g:if>
					<g:else>
						<span style="font-size:20px;" class="label label-danger">VACANTE</span>
					</g:else>
			  </div>
			</div>	
			 <div class="panel panel-danger">
			  <div class="panel-heading">
			    <h3 class="panel-title"><b>5 aciertos</b><i> (${history.fiveWinners.size()})</i></h3>
			  </div>
			  <div class="panel-body">
			    	<g:if test="${history.fiveWinners}">
						<g:each in="${history.fiveWinners}" var="winner">
							<span style="font-size:20px;" class="label label-success">${winner}</span>
						</g:each>
					</g:if>
					<g:else>
						<span style="font-size:20px;" class="label label-danger">VACANTE</span>
					</g:else>
			  </div>
			</div>			
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
	      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- SHOW RESULTS MODAL -->
<div class="modal fade"  id="showResultsModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">Sorteo</h4>
      </div>
      <div class="modal-body">
	    <div  class="row">
				<g:each in="${1..4}" var="col">
					<div class="col-md-3 text-center">
						<g:each in="${0..9}" var="fila">
							<h2><span class="label label-default">${history.results.results[(col+4*fila)-1]}</span></h2>
						</g:each>
					</div>
				</g:each>
			</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->





<h2 class="text-center" style="color:white;">Sorteo del ${DateTimeFormat.forPattern("EEEE dd/MM/yyyy").withLocale(new Locale("es", "ES")).print(new DateTime(history.lotteryDate))}</h2>
<br>
<br>

<p>
<a class="btn btn-danger btn-lg" data-toggle="modal" data-target="#showWinnersModal"><span class="glyphicon glyphicon-plus"></span> Ver ganadores</a>
<a class="btn btn-danger btn-lg" data-toggle="modal" data-target="#showResultsModal"><span class="glyphicon glyphicon-plus"></span> Ver sorteo</a>

</p>
	
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
	</thead>
	<tbody>
		<g:each in="${history.oldBets}" var="bet">
			<tr>
				<td class="text-center">${bet.playerName}</td>
				<g:each in="${0..6}">
					<td class="text-center">${bet.numbers[it]}</td>
				</g:each>
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
		</tr>
	</tfoot>
</table>
<script>
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
		                     { "bSortable": false, "aTargets": [ 1,2,3,4,5,6,7 ] }
		                    ]
		  }); 
	}
</script>