package managers;
import effects.AddArmyEffect;
import flixel.addons.plugin.taskManager.AntTaskManager;
import flixel.util.FlxPoint;
import objects.HexaTile;
import objects.Player;
import objects.Territory;
import flixel.FlxG;
import layers.PlayAreaLayer;
import states.MenuState;
import states.PlayState;

/**
 * ...
 * @author Karlo
 */
class GameplayManager
{
	private var selectedTerritory : Int = -1;
	private var taskManager:AntTaskManager;
	
	public function new()
	{
		
	}
	
	public function onClick(xPos:Float, yPos:Float)
	{
		function selectTerritoryAndHighlightNeighbors(clickedTerritory : Territory) : Int
		{
			if (clickedTerritory.ownerNumber != PlayState.playerManager.currentPlayerNumber 
				|| clickedTerritory.armyCount <= 1)
					return -1;
		
			PlayState.playArea.selectTerritory(clickedTerritory);
			clickedTerritory.highlightNeighbors();
			return clickedTerritory.territoryNumber;
		}
		
		var clickedTile : HexaTile = PlayState.playArea.checkForClickedTiles(xPos, yPos);		
		if ( clickedTile != null )
		{
			var clickedTerritory : Territory = PlayState.territoryManager.getTerritory(clickedTile.territoryNumber);
			
			if ( selectedTerritory != -1)		// If there is a selected territory
			{
				// We check if what we clicked is a neighbor of the selected territory 
				if ( PlayState.territoryManager.getTerritory(selectedTerritory).checkIfEnemyNeighbor(clickedTile.territoryNumber) )
				{
					BattleManager.startAttack(selectedTerritory, clickedTile.territoryNumber);
					selectedTerritory = PlayState.playArea.deselectTerritory(selectedTerritory);					
				}
				// We check if we clicked the same territory
				else if ( selectedTerritory == clickedTile.territoryNumber )
				{
					selectedTerritory = PlayState.playArea.deselectTerritory(selectedTerritory);					
				}
				else
				{
					// We deselect a selected territory
					selectedTerritory = PlayState.playArea.deselectTerritory(selectedTerritory);
					
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
	
	public function endCurrentPlayerMove() 
	{
		PlayState.gameGUI.hideDoneButton();	
		
		// We add a short delay
		if ( taskManager != null )
			taskManager.clear();
		
		taskManager = new AntTaskManager(false);
		taskManager.addPause(0.25);
		taskManager.addInstantTask(this, PlayState.playerManager.currentPlayer.randomlyAssignArmies, [PlayState.playerManager.currentPlayer.territories.length], true);
		taskManager.addPause(AddArmyEffect.EFFECT_DURATION);
		taskManager.addInstantTask(this, nextPlayer, null, true);
	}
	
	public function nextPlayer() 
	{	
		if ( checkIfGameHasEnded() )
		{
			endGame();
			return;
		}
		
		PlayState.playerManager.nextPlayer();
		PlayState.gameGUI.updateDoneButtonVisibility();			
		PlayState.pauseMenuLayer.hightlightPlayerRow(PlayState.playerManager.currentPlayerNumber-1);
	}
	
	public function checkIfGameHasEnded() 
	{
		var lostCount : Int = 0;
		var playerList : Array<Player> = PlayState.playerManager.playerList;
		for ( tPlayer in playerList )
		{
			var player : Player = tPlayer;
			if ( player.hasLost )
			{
				lostCount++;
			}
		}
		
		if ( lostCount >= playerList.length - 1 )
			return true;
		
		return false;
	}
	
	public function startGame() 
	{
		PlayState.gameGUI.updateDoneButtonVisibility();	
		
		var currentPlayer : Player = PlayState.playerManager.currentPlayer;
		if ( !currentPlayer.isHuman )
			currentPlayer.ai.startPlanning();
	}
	
	public function pauseGame()
	{
		PlayState.pauseMenuLayer.toggleStatus();
	}
	
	public function resetGame() 
	{
		FlxG.resetGame();
	}
	
	function endGame() 
	{
		taskManager.clear();		
		
		FlxG.switchState(new MenuState());
		trace("Game has ended!");
	}
}