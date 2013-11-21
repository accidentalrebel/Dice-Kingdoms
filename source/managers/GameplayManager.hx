package managers;
import objects.HexaTile;
import objects.Territory;
import flixel.FlxG;
import layers.PlayAreaLayer;
import states.PlayState;

//TODO: Have basic battle visuals

/**
 * ...
 * @author Karlo
 */
class GameplayManager
{
	static private var selectedTerritory : Int = -1;
	
	public static function init()
	{
		
	}
	
	public static function onClick(xPos:Float, yPos:Float)
	{
		function selectTerritoryAndHighlightNeighbors(clickedTerritory : Territory) : Int
		{
			if (clickedTerritory.ownerNumber != PlayerManager.currentPlayerNumber 
				|| clickedTerritory.armyCount <= 1)
					return -1;
		
			Registry.playArea.selectTerritory(clickedTerritory);
			clickedTerritory.highlightNeighbors();
			return clickedTerritory.territoryNumber;
		}
		
		var clickedTile : HexaTile = Registry.playArea.checkForClickedTiles(xPos, yPos);
		if ( clickedTile != null )
		{
			var clickedTerritory : Territory = TerritoryManager.getTerritory(clickedTile.territoryNumber);
			
			if ( selectedTerritory != -1)		// If there is a selected territory
			{
				// We check if what we clicked is a neighbor of the selected territory 
				if ( TerritoryManager.getTerritory(selectedTerritory).checkIfEnemyNeighbor(clickedTile.territoryNumber) )
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
	
	static public function nextPlayer() 
	{
		PlayerManager.nextPlayer();
	}
	
	static public function resetGame() 
	{
		FlxG.resetGame();
	}
}