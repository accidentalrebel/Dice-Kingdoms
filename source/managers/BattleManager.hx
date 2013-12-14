package managers;
import flixel.util.FlxRandom;
import objects.Player;
import objects.Territory;
import layers.PlayAreaLayer;
import states.PlayState;
import tools.ARTaskManager;
import tools.Tools;

/**
 * ...
 * @author Karlo
 */
class BattleManager
{
	private var taskManager : ARTaskManager;

	public function new() 
	{
		
	}
	
	public function startAttack(attackerTerritoryNum:Int, defenderTerritoryNum:Int) : Bool
	{	
		function rollAllDice(numOfDice:Int) : Array<Int>
		{
			var dieResults : Array<Int> = new Array<Int>();
			for ( die in 0...numOfDice )
			{
				var dieRoll : Int = FlxRandom.intRanged(1, 6);
				dieResults.push(dieRoll);
			}
			
			return dieResults;
		}
		
		var attacker : Territory = PlayState.territoryManager.getTerritory(attackerTerritoryNum);
		var defender : Territory = PlayState.territoryManager.getTerritory(defenderTerritoryNum);
		
		var attackerDiceResults : Array<Int> = rollAllDice(attacker.armyCount);
		var defenderDiceResults : Array<Int> = rollAllDice(defender.armyCount);
		
		var attackerColor : Int = PlayState.playerManager.getPlayer(attacker.ownerNumber).territoryColor;
		var defenderColor : Int = PlayState.playerManager.getPlayer(defender.ownerNumber).territoryColor;
		
		PlayState.battleLayer.rollAllDice(attackerDiceResults.length, attackerColor
			, defenderDiceResults.length, defenderColor);
		
		function getTotalCount(dieResults : Array<Int>) : Int
		{
			var totalCount : Int = 0;
			for ( result in dieResults )
				totalCount += result;
			
			return totalCount;
		}
		
		//TODO: Consider renaming this function
		function startBattle()
		{
			// We start rolling
			var attackerRoll : Int = getTotalCount(attackerDiceResults);
			
			var defenderPlayer : Player = PlayState.playerManager.getPlayer(defender.ownerNumber);
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
				defenderPlayer.checkIfLost();
			}
			else
			{
				winText = "DEFENDER";
				attacker.setArmyCount(1);
			}
			
			if ( taskManager != null )
				taskManager.clear();
			
			PlayState.battleLayer.updateTexts(winText + " WINS!!");
			PlayState.battleLayer.showBattleResults(attackerRoll, attackerDiceResults, defenderRoll, defenderDiceResults);
		}
		
		PlayState.battleLayer.hideBattleResults();
			
		taskManager = new ARTaskManager(false);
		taskManager.addPause(0.25);
		taskManager.addInstantTask(this, startBattle); 
		
		//TODO: Consider adding a pause after a battle
		return true;
	} 
}