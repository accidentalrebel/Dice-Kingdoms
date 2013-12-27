package ai;
import flixel.FlxG;
import flixel.util.FlxArrayUtil;
import flixel.util.FlxRandom;
import managers.BattleManager;
import managers.CameraManager;
import managers.GameplayManager;
import managers.PlayerManager;
import managers.TerritoryManager;
import objects.Player;
import objects.Territory;
import states.PlayState;
import tools.ARTaskManager;
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
	public var aiType:AIType;
	var taskManager:ARTaskManager;
	
	public function new(playerScript : Player) 
	{
		this.playerScript = playerScript;
		
		// We roll for the AI type
		aiType = Type.createEnumIndex(AIType, FlxRandom.intRanged(0, Type.allEnums(AIType).length-1));
	}
	
	public function destroy()
	{
		this.playerScript = null;
	}
	
	public function startPlanning()
	{
		function getAvailableTerritories() : Null<Territory>
		{
			// We loop through each territory
			for ( tTerritory in playerScript.territories )
			{ 
				var territory : Territory = PlayState.territoryManager.getTerritory(tTerritory);
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
				var territory : Territory = PlayState.territoryManager.getTerritory(tTerritory);
				territory.markAsChecked = false;
			}
			
			
			taskManager.clear();
			
			// We then go to the next player
			PlayState.gameplayManager.endCurrentPlayerMove();			
		}
		
		function getNextMove()
		{
			if ( taskManager != null )
				taskManager.clear();
			
			taskManager = new ARTaskManager(false);
			var territory : Null<Territory> = getAvailableTerritories();
			
			// If no territory is availble, we now end our turn
			if ( territory == null )
			{
				endMove();
				return;
			}
			
			// We shuffle the neighbors of this territory for randomness
			territory.neighbors = FlxArrayUtil.shuffle(territory.neighbors, Std.int(territory.neighbors.length * 2));
			
			// We go through each neighbors
			for ( tNeighbor in territory.neighbors )
			{
				var neighborTerritory : Territory = PlayState.territoryManager.getTerritory(tNeighbor);
				
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
					if ( PlayState.cameraManager.isZoomedIn )
					{
						PlayState.cameraManager.focusOnTerritory(territory.territoryNumber);
						taskManager.addPause(0.35);
					}
					
					taskManager.addPause(0.15);
					
					// We highlight the attacker and the one being attacked
					function selectInvolvedTerritories()
					{
						PlayState.playArea.selectTerritory(territory);
						PlayState.playArea.selectTerritory(neighborTerritory);
					}
					taskManager.addInstantTask(this, selectInvolvedTerritories, [territory], true);
					taskManager.addPause(0.5);
					
					// We then start the battle and unhighlight territories
					taskManager.addInstantTask(this, PlayState.battleManager.startAttack, [territory.territoryNumber, neighborTerritory.territoryNumber], true);
					taskManager.addInstantTask(this, PlayState.playArea.deselectTerritory, [territory.territoryNumber], true);
					taskManager.addInstantTask(this, PlayState.playArea.deselectTerritory, [neighborTerritory.territoryNumber], true);
					
					// We add a short delay when the camera is zoomed in to show the result of the attack
					if ( PlayState.cameraManager.isZoomedIn )
						taskManager.addPause(0.25);
					
					taskManager.addPause(1.5);
					taskManager.addInstantTask(this, getNextMove, null, true);
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