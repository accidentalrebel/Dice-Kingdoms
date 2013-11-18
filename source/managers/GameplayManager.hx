package managers;
import objects.HexaTile;
import objects.Territory;
import flixel.FlxG;
import layers.PlayAreaLayer;

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
					selectedTerritory = Registry.playArea.selectTerritory(clickedTile, clickedTerritory);
				}
			}
			else	// If there is no selected territory
			{
				// We select the clicked territory
				selectedTerritory = Registry.playArea.selectTerritory(clickedTile, clickedTerritory);
			}
		}
	}	
	
	static public function nextPlayer() 
	{
		PlayerManager.nextPlayer();
	}
}