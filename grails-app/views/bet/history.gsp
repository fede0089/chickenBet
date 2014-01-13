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
	<div id="history">
		<h2 style="color:white;" class="text-center">Buscar sorteo anterior</h2>
		</br>
		<g:formRemote name="getHistoryForm" url="['action':'getHistoryByDate']" update="history" class="form-inline" onComplete="initDataTable()">
		
			<div class="form-group col-md-4 col-md-offset-4">
					<div class="input-group date " 
						data-date-format="dd/mm/yyyy" id="datepicker" data-date="12-02-2012">
						<g:textField name="date" class="form-control text-center validateable" placeholder="Fecha del sorteo" nonempty readonly="true" />
						<span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>		
					</div>
			</div>
			 <button type="submit" class="btn btn-danger"><span class="glyphicon glyphicon-search"></span></button>
		</g:formRemote>
	</div>
	
	
	<g:javascript>
		$(document).ready(function(){
			$("#datepicker").datepicker();
		})
	</g:javascript>
</body>