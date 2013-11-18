package managers;
import objects.Territory;
import layers.PlayAreaLayer;

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
		
		Registry.battleLayer.show("ATTACKER: " + attackerRoll + " DEFENDER: " + defenderRoll);
		
		// We resolve the battle
		if ( attackerRoll > defenderRoll )
		{
			trace("ATTACKER WINS!");
			attacker.armyCount = attacker.armyCount - 1;
			defender.setArmyCount(attacker.armyCount);
			attacker.setArmyCount(1);
			Registry.playArea.assignTerritory(defender.territoryNumber, attacker.ownerNumber);
		}
		else
		{
			trace("DEFENDER WINS!");
			attacker.setArmyCount(1);
		}
		
		return true;
	} 
}