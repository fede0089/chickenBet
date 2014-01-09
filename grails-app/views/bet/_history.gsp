<%@ page import="org.joda.time.DateTime" %>
<%@ page import="org.joda.time.format.DateTimeFormat" %>

<h2 class="text-center" style="color:white;">Sorteo del ${DateTimeFormat.forPattern("EEEE dd/MM/yyyy").print(new DateTime(history.lotteryDate))}</h2>
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
		  	    "sDom": 'T<"row"><""f>rtp',
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
		                    ],
		    "oTableTools": {   
					"sSwfPath": "../swf/copy_csv_xls_pdf.swf"		           
		   }
		  }); 
	}
</script>