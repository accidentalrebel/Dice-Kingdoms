package managers;
import effects.AddArmyEffect;
import flixel.addons.plugin.taskManager.AntTaskManager;
import flixel.util.FlxPoint;
import objects.HexaTile;
import objects.Territory;
import flixel.FlxG;
import layers.PlayAreaLayer;
import states.PlayState;

/**
 * ...
 * @author Karlo
 */
class GameplayManager
{
	private var selectedTerritory : Int = -1;
	private var taskManager:AntTaskManager;
	
	public function new()
	{
		
	}
	
	public function onClick(xPos:Float, yPos:Float)
	{
		function selectTerritoryAndHighlightNeighbors(clickedTerritory : Territory) : Int
		{
			if (clickedTerritory.ownerNumber != Registry.playerManager.currentPlayerNumber 
				|| clickedTerritory.armyCount <= 1)
					return -1;
		
			Registry.playArea.selectTerritory(clickedTerritory);
			clickedTerritory.highlightNeighbors();
			return clickedTerritory.territoryNumber;
		}
		
		var clickedTile : HexaTile = Registry.playArea.checkForClickedTiles(xPos, yPos);
		if ( clickedTile != null )
		{
			var clickedTerritory : Territory = Registry.territoryManager.getTerritory(clickedTile.territoryNumber);
			
			if ( selectedTerritory != -1)		// If there is a selected territory
			{
				// We check if what we clicked is a neighbor of the selected territory 
				if ( Registry.territoryManager.getTerritory(selectedTerritory).checkIfEnemyNeighbor(clickedTile.territoryNumber) )
				{
					BattleManager.startAttack(selectedTerritory, clickedTile.territoryNumber);
					selectedTerritory = Registry.playArea.deselectTerritory(selectedTerritory);					
				}
				// We check if we clicked the same territory
				else if ( selectedTerritory == clickedTile.territoryNumber )
				{
					selectedTerritory = Registry.playArea.deselectTerritory(selectedTerritory);					
				}
				else
				{
					// We deselect a selected territory
					selectedTerritory = Registry.playArea.deselectTerritory(selectedTerritory);
					
					// We select the clicked territory
					selectedTerritory = selectTerritoryAndHighlightNeighbors(clickedTerritory);
				}
			}
			else	// If there is no selected territory
			{
				// We select the clicked territory
				selectedTerritory = selectTerritoryAndHighlightNeighbors(clickedTerritory);
			}
		}
	}
	
	public function endCurrentPlayerMove() 
	{
		// We add a short delay
		if ( taskManager != null )
			taskManager.clear();
		
		taskManager = new AntTaskManager(false);
		taskManager.addPause(0.5);
		taskManager.addInstantTask(this, Registry.playerManager.currentPlayer.randomlyAssignArmies, [Registry.playerManager.currentPlayer.territories.length], true);
		taskManager.addPause(AddArmyEffect.EFFECT_DURATION);
		taskManager.addInstantTask(this, nextPlayer, null, true);
	}
	
	public function nextPlayer() 
	{
		Registry.playerManager.nextPlayer();
	}
	
	public function resetGame() 
	{
		FlxG.resetGame();
	}
}