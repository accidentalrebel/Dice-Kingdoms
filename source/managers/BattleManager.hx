package managers;
import flixel.util.FlxRandom;
import objects.Player;
import objects.Territory;
import layers.PlayAreaLayer;
import states.GameState;
import tools.ARTaskManager;
import tools.Tools;

/**
 * ...
 * @author Karlo
 */
class BattleManager
{
	private var taskManager : ARTaskManager;
	var attackHasStarted : Bool = false;

	public function new() 
	{
		taskManager = new ARTaskManager(false);
	}
	
	//TODO: Check out why sometimes "ZERO" appears as the final result
	public function startAttack(attackerTerritoryNum:Int, defenderTerritoryNum:Int) : Bool
	{	
		if ( attackHasStarted )
			return false;
			
		attackHasStarted = true;
		
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
		
		var attacker : Territory = GameState.territoryManager.getTerritory(attackerTerritoryNum);
		var defender : Territory = GameState.territoryManager.getTerritory(defenderTerritoryNum);
		
		var attackerDiceResults : Array<Int> = rollAllDice(attacker.armyCount);
		var defenderDiceResults : Array<Int> = rollAllDice(defender.armyCount);
		
		var attackerColor : Int = GameState.playerManager.getPlayer(attacker.ownerNumber).territoryColor;
		var defenderColor : Int = GameState.playerManager.getPlayer(defender.ownerNumber).territoryColor;
		
		var attackerRoll : Int = getTotalCount(attackerDiceResults);
		var defenderRoll : Int = getTotalCount(defenderDiceResults);
			
		GameState.battleLayer.rollAllDice(attackerDiceResults.length, attackerColor
			, defenderDiceResults.length, defenderColor);
		
		//TODO: Consider renaming this function
		function startBattle()
		{			
			GameState.gameGUI.attackerBattleResult.showLabel();
			GameState.gameGUI.defenderBattleResult.showLabel();
			
			var defenderPlayer : Player = GameState.playerManager.getPlayer(defender.ownerNumber);
			var winText : String = "";
			
			// We resolve the battle
			if ( attackerRoll > defenderRoll )
			{
				winText = "ATTACKER";
				attacker.armyCount = attacker.armyCount - 1;
				defender.setArmyCount(attacker.armyCount);
				attacker.setArmyCount(1);
				GameState.playArea.assignTerritory(defender.territoryNumber, attacker.ownerNumber);
				defenderPlayer.checkIfLost();
				
				GameState.gameGUI.attackerBattleResult.setAsWinner();
				GameState.gameGUI.defenderBattleResult.setAsLoser();
			}
			else
			{
				winText = "DEFENDER";
				attacker.setArmyCount(1);
				
				GameState.gameGUI.attackerBattleResult.setAsLoser();
				GameState.gameGUI.defenderBattleResult.setAsWinner();
			}
			
			taskManager.clear();
			
			GameState.battleLayer.updateTexts(winText + " WINS!");
			GameState.battleLayer.showBattleResults(attackerRoll, attackerDiceResults, defenderRoll, defenderDiceResults);
			
			attackHasStarted = false;
		}
		
		GameState.battleLayer.hideBattleResults();
		
		GameState.gameGUI.attackerBattleResult.hideLabel();
		GameState.gameGUI.defenderBattleResult.hideLabel();
		
		GameState.gameGUI.attackerBattleResult.attachToTerritory(attackerTerritoryNum);
		GameState.gameGUI.defenderBattleResult.attachToTerritory(defenderTerritoryNum);	
		
		taskManager.clear();
		taskManager.addPause(0.5);
		taskManager.addInstantTask(this, startBattle);
		return true;
	} 
	
	public function reset()
	{
		taskManager.clear();
		taskManager.destroy();
	}
}