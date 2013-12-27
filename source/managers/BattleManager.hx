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
	
	//TODO: Check out why sometimes "ZERO" appears as the final result
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
		
		function getTotalCount(dieResults : Array<Int>) : Int
		{
			var totalCount : Int = 0;
			for ( result in dieResults )
				totalCount += result;
			
			return totalCount;
		}
		
		var attacker : Territory = PlayState.territoryManager.getTerritory(attackerTerritoryNum);
		var defender : Territory = PlayState.territoryManager.getTerritory(defenderTerritoryNum);
		
		var attackerDiceResults : Array<Int> = rollAllDice(attacker.armyCount);
		var defenderDiceResults : Array<Int> = rollAllDice(defender.armyCount);
		
		var attackerColor : Int = PlayState.playerManager.getPlayer(attacker.ownerNumber).territoryColor;
		var defenderColor : Int = PlayState.playerManager.getPlayer(defender.ownerNumber).territoryColor;
		
		var attackerRoll : Int = getTotalCount(attackerDiceResults);
		var defenderRoll : Int = getTotalCount(defenderDiceResults);
			
		PlayState.battleLayer.rollAllDice(attackerDiceResults.length, attackerColor
			, defenderDiceResults.length, defenderColor);
		
		//TODO: Consider renaming this function
		function startBattle()
		{
			// We start rolling
			PlayState.gameGUI.attackerBattleResult.showLabel();
			PlayState.gameGUI.attackerBattleResult.changeLabelText(Std.string(attackerRoll));
			PlayState.gameGUI.defenderBattleResult.showLabel();
			PlayState.gameGUI.defenderBattleResult.changeLabelText(Std.string(defenderRoll));
		}
		
		function resolveBattle()
		{
			var defenderPlayer : Player = PlayState.playerManager.getPlayer(defender.ownerNumber);
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
		
		PlayState.gameGUI.attackerBattleResult.attachToTerritory(attackerTerritoryNum);
		PlayState.gameGUI.defenderBattleResult.attachToTerritory(defenderTerritoryNum);	
		
		taskManager = new ARTaskManager(false);
		taskManager.addPause(0.5);
		taskManager.addInstantTask(this, startBattle);
		taskManager.addPause(0.5);
		taskManager.addInstantTask(this, resolveBattle);
		return true;
	} 
}