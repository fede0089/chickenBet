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
		