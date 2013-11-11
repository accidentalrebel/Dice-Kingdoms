package managers;
import objects.HexaTile;
import objects.Territory;
import flixel.FlxG;
import playArea.PlayArea;

//TODO: Selectable territories should be highlighted
//TODO: Have a hasAttacked variable
//TODO: Have a restock mode, after whole turn
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
					startAttack(selectedTerritory, clickedTile.territoryNumber);
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
	
	static private function startAttack(attackerTerritoryNum:Int, defenderTerritoryNum:Int) 
	{
		function rollDice(numOfDice:Int) 
		{
			var totalCount : Int = 0;
			for ( die in 0...numOfDice )
			{
				var dieRoll : Int = Std.random(5) + 1;
				trace("Die no. " + die + " rolled a " + dieRoll);
				totalCount += dieRoll;
			}
			
			return totalCount;
		}
		
		var attacker : Territory = TerritoryManager.getTerritory(attackerTerritoryNum);
		var defender : Territory = TerritoryManager.getTerritory(defenderTerritoryNum);
		
		// We start rolling
		var attackerRoll : Int = rollDice(attacker.armyCount);
		var defenderRoll : Int = rollDice(defender.armyCount);
		trace("ATTACKER: " + attackerRoll + " DEFENDER: " + defenderRoll);
		
		// We resolve the battle
		if ( attackerRoll > defenderRoll )
		{
			trace("ATTACKER WINS!");
			attacker.armyCount = attacker.armyCount - 1;
			defender.setArmyCount(attacker.armyCount);
			attacker.setArmyCount(1);
			PlayArea.assignTerritory(defender.territoryNumber, attacker.ownerNumber);
		}
		else
		{
			trace("DEFENDER WINS!");
			attacker.setArmyCount(1);
		}
	} 
}