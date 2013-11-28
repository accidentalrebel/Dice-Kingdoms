package managers;
import objects.Territory;
import layers.PlayAreaLayer;
import states.PlayState;
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
	
	//TODO: Investigate attacking slowdown
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
		
		var attacker : Territory = PlayState.territoryManager.getTerritory(attackerTerritoryNum);
		var defender : Territory = PlayState.territoryManager.getTerritory(defenderTerritoryNum);
		
		// We start rolling
		var attackerDiceResults : Array<Int> = rollAllDice(attacker.armyCount);
		var attackerRoll : Int = getTotalCount(attackerDiceResults);
		var defenderDiceResults : Array<Int> = rollAllDice(defender.armyCount);
		var defenderRoll : Int = getTotalCount(defenderDiceResults);
		var winText : String = "";
		
		// We resolve the battle
		if ( attackerRoll > defenderRoll )
		{
			winText = "ATTACKER";
			attacker.armyCount = attacker.armyCount - 1;
			defender.setArmyCount(attacker.armyCount);
			attacker.setArmyCount(1);
			PlayState.playArea.assignTerritory(defender.territoryNumber, attacker.ownerNumber);
		}
		else
		{
			winText = "DEFENDER";
			attacker.setArmyCount(1);
		}
		
		PlayState.battleLayer.updateTexts(winText + " WINS!!");
		PlayState.battleLayer.updateElements(attackerRoll, attackerDiceResults, defenderRoll, defenderDiceResults);
		
		return true;
	} 
}