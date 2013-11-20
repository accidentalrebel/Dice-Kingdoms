package managers;
import objects.Territory;
import layers.PlayAreaLayer;
import tools.Tools;

/**
 * ...
 * @author Karlo
 */
class BattleManager
{

	public function new() 
	{
		
	}
	
	static public function startAttack(attackerTerritoryNum:Int, defenderTerritoryNum:Int) : Bool
	{
		function rollAllDice(numOfDice:Int) : Array<Int>
		{
			var dieResults : Array<Int> = new Array<Int>();
			for ( die in 0...numOfDice )
			{
				var dieRoll : Int = Tools.randomMinMax(1, 6);
				dieResults.push(dieRoll);
			}
			
			return dieResults;
		}
		
		function getTotalCount(dieResults : Array<Int>) : Int
		{
			var totalCount : Int = 0;
			for ( result in dieResults )
			{
				totalCount += result;
			}
			
			return totalCount;
		}
		
		var attacker : Territory = TerritoryManager.getTerritory(attackerTerritoryNum);
		var defender : Territory = TerritoryManager.getTerritory(defenderTerritoryNum);
		
		// We start rolling
		var attackerRoll : Int = getTotalCount(rollAllDice(attacker.armyCount));
		var defenderRoll : Int = getTotalCount(rollAllDice(defender.armyCount));
		var winText : String = "";
		
		// We resolve the battle
		if ( attackerRoll > defenderRoll )
		{
			winText = "ATTACKER";
			attacker.armyCount = attacker.armyCount - 1;
			defender.setArmyCount(attacker.armyCount);
			attacker.setArmyCount(1);
			Registry.playArea.assignTerritory(defender.territoryNumber, attacker.ownerNumber);
		}
		else
		{
			winText = "DEFENDER";
			attacker.setArmyCount(1);
		}
		
		Registry.battleLayer.updateTexts("ATTACKER: " + attackerRoll + " DEFENDER: " + defenderRoll
			+ "\n" + winText + " WINS!!");
		
		return true;
	} 
}