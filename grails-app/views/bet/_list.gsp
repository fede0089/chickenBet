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
			<th class="text-center">Eliminar</th>
	</thead>
	<tbody>
		<g:each in="${bets}" var="bet">
			<tr>
				<td class="text-center">${bet.player.alias}</td>
				<g:each in="${0..6}">
					<td class="text-center">${bet.numbers[it]}</td>
				</g:each>
				<td class="text-center"><g:remoteLink action="removeBet" controller="bet" params="[playerId:bet.player.id,betId:bet.id]" update="betTableWrapper" onSuccess="refreshDataTable()" onFailure="showRemoveError(XMLHttpRequest)" ><span class="glyphicon glyphicon-remove"></span></g:remoteLink></td>
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
			<th></th>
		</tr>
	</tfoot>
</table>