<head>
	<meta name="layout" content="main" />
</head>
<body>
		<h1 class="text-center">Resultados</h1>
		<ul>	
		<g:each in="${7..5}" var="quantity">
		
				<div class="panel panel-default">
				  <div class="panel-heading">
				    <h3 class="panel-title">${quantity} aciertos</h3>
				  </div>
				  <div class="panel-body">
				    	<g:if test="${winners[quantity]}">
							<g:each in="${winners[quantity]}" var="winner">
								<span class="label label-success winnerPopover" data-title="Jugada" data-trigger="hover" data-html=true
								data-content="<b>${winner.matched.join(',')}${quantity<7?',':''}<span style='color:red;'>${winner.missing.join(',')}</span></b>" >${winner.player.alias}</span>
							</g:each>
						</g:if>
						<g:else>
							<span class="label label-danger">VACANTE</span>
						</g:else>
				  </div>
				</div>			
		</g:each>
		</ul>
		<g:link class="btn btn-danger btn-lg btn pull-right"  >Volver</g:link>
		
		<g:javascript>
		$(document).ready(function(){
			$('.winnerPopover').popover();
		});
		</g:javascript>
</body>