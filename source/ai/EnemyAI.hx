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
		trace("Enemy AI Takes over for player " + this.playerScript.playerNum);
		
		var taskManager : AntTaskManager = new AntTaskManager(false, PlayerManager.nextPlayer);
		
		// We go through each territory owned by this player and see if there are any valid moves
		// TODO: Make sure that AI also goes though newly acquired territories
		for ( tTerritory in playerScript.territories )
		{
			trace("Territory count is " + playerScript.territories.length);
			var territory : Territory = TerritoryManager.getTerritory(tTerritory);
			var currentTerritoryArmyCount : Int = territory.armyCount;
			if ( currentTerritoryArmyCount <= 1 )
				continue;
			
			// We go through each neighbors
			for ( tNeighbor in territory.neighbors )
			{
				var neighborTerritory : Territory = TerritoryManager.getTerritory(tNeighbor);
				
				trace("Checking if can attack territory " + neighborTerritory.territoryNumber);
				trace(currentTerritoryArmyCount + " ? " + neighborTerritory.armyCount);
				if ( currentTerritoryArmyCount > neighborTerritory.armyCount )
				{
					//BattleManager.startAttack(territory.territoryNumber, neighborTerritory.territoryNumber);
					taskManager.addPause(0.25);
					taskManager.addTask(this, Registry.playArea.selectTerritory, [territory], true);
					taskManager.addPause(0.25);
					taskManager.addTask(this, BattleManager.startAttack, [territory.territoryNumber, neighborTerritory.territoryNumber], true);
					taskManager.addInstantTask(this, Registry.playArea.deselectTerritory, [territory.territoryNumber], true);
					break;
				}
			}
		}
		
		trace("Exhausted all options");
		//PlayerManager.nextPlayer();
	}
}