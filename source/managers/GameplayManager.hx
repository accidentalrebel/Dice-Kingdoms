package managers;
import objects.HexaTile;
import objects.Territory;
import flixel.FlxG;
import playArea.PlayArea;

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
		function selectClickedTerritory(tClickedTile : HexaTile, clickedTerritory : Territory)
		{
			if (clickedTerritory.ownerNumber != PlayerManager.currentPlayerNumber 
				|| clickedTerritory.armyCount <= 1)
				return;
			
			selectedTerritory = tClickedTile.territoryNumber;
			clickedTerritory.select();
			clickedTerritory.highlightNeighbors();
		}

		function deselectSelectedTerritory()
		{
			var toDeselect : Territory = TerritoryManager.getTerritory(selectedTerritory);
			toDeselect.deselect();
			toDeselect.unhighlightNeighbors();
			selectedTerritory = -1;
		}
		
		var clickedTile : HexaTile = PlayArea.checkForClickedTiles(xPos, yPos);
		if ( clickedTile != null )
		{
			var clickedTerritory : Territory = TerritoryManager.getTerritory(clickedTile.territoryNumber);
			
			if ( selectedTerritory != -1)		// If there is a selected territory
			{
				// We check if what we clicked is a neighbor of the selected territory 
				if ( TerritoryManager.getTerritory(selectedTerritory).checkIfEnemyNeighbor(clickedTile.territoryNumber) )
				{
					BattleManager.startAttack(selectedTerritory, clickedTile.territoryNumber);
					deselectSelectedTerritory();
				}
				// We check if we clicked the same territory
				else if ( selectedTerritory == clickedTile.territoryNumber )
				{
					deselectSelectedTerritory();
				}
				else
				{
					// We deselect a selected territory
					deselectSelectedTerritory();
					
					// We select the clicked territory
					selectClickedTerritory(clickedTile, clickedTerritory);
				}
			}
			else	// If there is no selected territory
			{
				// We select the clicked territory
				selectClickedTerritory(clickedTile, clickedTerritory);
			}
		}
	}	
	
	static public function nextPlayer() 
	{
		PlayerManager.nextPlayer();
	}
}