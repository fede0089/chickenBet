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
	<!-- Static Modal -->
	<div class="modal modal-static fade" id="processing-modal" role="dialog" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-body">
	                <div class="text-center">
	                    <g:img file="loading.gif" class="icon" />
	                    <h4>Procesando... </h4>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
	
	<div id="results">
		<g:formRemote name="checkWinners" url="['action':'checkWinners']" update="results" before="\$('#processing-modal').modal('show')" onComplete ="\$('#processing-modal').modal('hide')" onFailure="showError(XMLHttpRequest)">
			<div class="row">
				<div class="col-md-3 ">
					<span style="font-size:20px;color:white;">Fecha del sorteo</span>
					<div class="input-group date" 
						data-date-format="dd/mm/yyyy" id="datepicker" data-date="12-02-2012">
						<g:textField name="date" class="form-control text-center validateable" nonempty readonly="true" />
						<span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>		
					</div>
				</div>
			</div>
			
			<br>
			
			<div  class="row">
				<g:each in="${1..4}" var="col">
					<div class="col-md-3">
						<g:each in="${0..9}" var="fila">
							<div class="form-control-mock">
								<g:textField class="form-control text-center validateable"  
								value="${(col+4*fila)-1}" name="numbers[${(col+4*fila)-1}]" autocomplete="off"
								nonempty="true" numeric data-range="0..99"/>
								</br>
							</div>
						</g:each>
					</div>
				</g:each>
			</div>
			<div class="text-center">
				<g:submitButton name="submitButton" value="Sortear" onClick="return \$('form').validate();"class="btn btn-danger btn-lg"/>
			</div>
		</g:formRemote>
		
		<g:javascript>
			$(document).ready(function(){
				$("#datepicker").datepicker();
				hideSpinner();
			})
			
			function showError(xhr){
			if (xhr.status==409)
				addMessage('danger', "Error. Ya existe un sorte para la fecha indicada", $("#messages"), 'top');
			else
				addMessage('danger', "Error.", $("#messages"), 'top');				
			}
		</g:javascript>
		
	</div>
</body>