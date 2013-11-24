package ai;
import flixel.addons.plugin.taskManager.AntTaskManager;
import flixel.FlxG;
import managers.BattleManager;
import managers.CameraManager;
import managers.GameplayManager;
import managers.PlayerManager;
import managers.TerritoryManager;
import objects.Player;
import objects.Territory;
import tools.Tools;

/**
 * ...
 * @author Karlo
 */
enum AIType {
	NORMAL;			// Attacks only at equal armies or more
	AGGRESSIVE;		// Attacks even though enemy is one army bigger
	DEFENSIVE;		// Only attacks if army is 7 or 8 in count
	CAUTIOUS;		// Only attacks if they have more than one army
}  
 
class EnemyAI
{
	var playerScript:Player;
	var aiType:AIType;
	
	//TODO: Have different kinds of AI
	
	public function new(playerScript : Player) 
	{
		this.playerScript = playerScript;
		
		// We roll for the AI type
		aiType = Type.createEnumIndex(AIType, Std.int(Math.floor(Math.random() * Type.allEnums(AIType).length)));
		//trace(Std.string(aiType));
	}
	
	public function startPlanning()
	{
		function getAvailableTerritories() : Null<Territory>
		{
			// We loop through each territory
			for ( tTerritory in playerScript.territories )
			{ 
				var territory : Territory = Registry.territoryManager.getTerritory(tTerritory);
				if ( territory.armyCount > 1
					&& territory.ownerNumber == playerScript.playerNum 
					&& territory.neighbors.length >= 1
					&& territory.markAsChecked == false )
					{
						if ( aiType == AIType.DEFENSIVE 		// If the AI is defensive
							&& territory.armyCount < 7 )		// And the territory does not meet the army requirement
							continue;
							
						return territory;
					}
			}
			
			// We did not get any territories
			return null;
		}
		
		function endMove()
		{
			// We loop through each territory and mark each territory as unchecked
			for ( tTerritory in playerScript.territories )
			{ 
				var territory : Territory = Registry.territoryManager.getTerritory(tTerritory);
				territory.markAsChecked = false;
			}
			
			// We then go to the next player
			GameplayManager.nextPlayer();
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
			//TODO: Pick a random neighbor instead of picking the first one on the list
			for ( tNeighbor in territory.neighbors )
			{
				var neighborTerritory : Territory = Registry.territoryManager.getTerritory(tNeighbor);
				
				// If I own this territory
				if ( neighborTerritory.ownerNumber == territory.ownerNumber )
					continue;
				
				if ( ( (aiType == AIType.NORMAL || aiType == AIType.DEFENSIVE )
						&& territory.armyCount >= neighborTerritory.armyCount )			// If we have equal or more than enemy
					|| (aiType == AIType.CAUTIOUS 
						&& territory.armyCount > neighborTerritory.armyCount)			// If we have more army count than enemy
					|| (aiType == AIType.AGGRESSIVE
						&& territory.armyCount >= neighborTerritory.armyCount - 1 ))	// If even the enemy has one army more than mine
				{
					taskManager.addPause(0.75);
					
					// We highlight the attacker and the one being attacked
					taskManager.addInstantTask(this, Registry.playArea.selectTerritory, [territory], true);
					taskManager.addInstantTask(this, Registry.playArea.selectTerritory, [neighborTerritory, true], true);
					taskManager.addPause(1);
					
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