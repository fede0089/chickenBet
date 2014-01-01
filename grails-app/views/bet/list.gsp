<head>
	<meta name="layout" content="main" />
</head>
<body>
	<p class="pull-right"><g:link class="btn btn-danger btn-lg"><span class="glyphicon glyphicon-print"></span></g:link></p>
	<p><g:link class="btn btn-danger btn-lg" action="createBetForm" controller="bet"><span class="glyphicon glyphicon-plus"></span> Nueva apuesta</g:link></p>
	<table class ="table table-hover" id="betTable">
		<thead>
			<tr class="success">
				<th class="text-center">Alias</th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
		</thead>
		<tbody>
			<g:each in="${bets}" var="bet">
				<tr>
					<td class="text-center">${bet.player.alias}</td>
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
	<g:javascript>
	$(document).ready(function(){
		$("#betTable").dataTable({
			'sDom' :'<"top"f>t<"bottom"p><"bottom">',
			"sPagination": "bs_normal",
			"oLanguage": {
			    "sProcessing":     "Procesando...",
			    "sLengthMenu":     "Mostrar _MENU_ registros",
			    "sZeroRecords":    "No se encontraron resultados",
			    "sEmptyTable":     "Ningún dato disponible en esta tabla",
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
	});
	</g:javascript>
</body>