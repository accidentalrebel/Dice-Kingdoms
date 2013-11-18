package ai;
import flixel.addons.plugin.taskManager.AntTaskManager;
import managers.BattleManager;
import managers.GameplayManager;
import managers.PlayerManager;
import managers.TerritoryManager;
import objects.Player;
import objects.Territory;

/**
 * ...
 * @author Karlo
 */
 
class EnemyAI
{
	var playerScript:Player;
	
	public function new(playerScript : Player) 
	{
		this.playerScript = playerScript;
	}
	
	public function startMakingMoves()
	{
		function getAvailableTerritories() : Null<Territory>
		{
			// We loop through each territory
			for ( tTerritory in playerScript.territories )
			{ 
				var territory : Territory = TerritoryManager.getTerritory(tTerritory);
				if ( territory.armyCount > 1
					&& territory.ownerNumber == playerScript.playerNum 
					&& territory.neighbors.length >= 1
					&& territory.markAsChecked == false )
					return territory;
			}
			
			// We did not get any territories
			return null;
		}
		
		function endMove()
		{
			// We loop through each territory and mark each territory as unchecked
			for ( tTerritory in playerScript.territories )
			{ 
				var territory : Territory = TerritoryManager.getTerritory(tTerritory);
				territory.markAsChecked = false;
			}
			
			// We then go to the next player
			PlayerManager.nextPlayer();
		}
		
		function getNextMove()
		{
			var taskManager : AntTaskManager = new AntTaskManager(false, getNextMove);
			var territory : Null<Territory> = getAvailableTerritories();
			
			// If no territory is availble, we now end our turn
			if ( territory == null )
			{
				trace("Did not get any territories, going to the next player");
				endMove();
				return;
			}
				
			// We go through each neighbors
			for ( tNeighbor in territory.neighbors )
			{
				var neighborTerritory : Territory = TerritoryManager.getTerritory(tNeighbor);
				
				// If I own this territory
				if ( neighborTerritory.ownerNumber == territory.ownerNumber )
					continue;
				
				if ( territory.armyCount > neighborTerritory.armyCount )
				{
					taskManager.addPause(0.25);
					
					// We highlight the attacker and the one being attacked
					taskManager.addInstantTask(this, Registry.playArea.selectTerritory, [territory], true);
					taskManager.addInstantTask(this, Registry.playArea.selectTerritory, [neighborTerritory, true], true);
					taskManager.addPause(0.25);
					
					// We then start the battle and unhighlight territories
					taskManager.addInstantTask(this, BattleManager.startAttack, [territory.territoryNumber, neighborTerritory.territoryNumber], true);
					taskManager.addInstantTask(this, Registry.playArea.deselectTerritory, [territory.territoryNumber], true);
					taskManager.addInstantTask(this, Registry.playArea.deselectTerritory, [neighborTerritory.territoryNumber], true);
					break;
				}
			}
			
			// If there are no neighbors to attack
			if ( taskManager.length <= 0 )
			{
				territory.markAsChecked = true;
				getNextMove();
			}
		}
		
		getNextMove();
	}
}