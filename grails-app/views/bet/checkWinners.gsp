<head>
</head>
<body>
		<h1 class="text-center" style="color:white;"><b>RESULTADOS</b></h1>
		</br>
		<ul>	
		<g:each in="${7..5}" var="quantity">
		
				<div class="panel panel-danger">
				  <div class="panel-heading">
				    <h3 class="panel-title"><b>${quantity} aciertos</b></h3>
				  </div>
				  <div class="panel-body">
				    	<g:if test="${winners[quantity]}">
							<g:each in="${winners[quantity]}" var="winner">
								<span style="font-size:20px;" class="label label-success winnerPopover" data-title="Jugada" data-trigger="hover" data-html=true
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
		<script>
			$('.winnerPopover').popover();
		</script>
</body>