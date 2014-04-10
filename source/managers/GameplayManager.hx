package managers;
import effects.AddArmyEffect;
import tools.ARTaskManager;
import flixel.util.FlxPoint;
import objects.HexaTile;
import objects.Player;
import objects.Territory;
import flixel.FlxG;
import layers.PlayAreaLayer;
import states.MainMenuState;
import states.GameState;

/**
 * ...
 * @author Karlo
 */
class GameplayManager
{
	private var selectedTerritory : Int = -1;
	private var taskManager:ARTaskManager;
	
	public function new()
	{
		
	}
	
	public function onClick(xPos:Float, yPos:Float)
	{
		handleTerritoryClick(xPos, yPos);
	}
	
	function handleTerritoryClick(xPos:Float, yPos:Float)
	{
		if ( !GameState.playerManager.currentPlayer.isHuman )
			return;
		
		function selectTerritoryAndHighlightNeighbors(clickedTerritory : Territory) : Int
		{
			if (clickedTerritory.ownerNumber != GameState.playerManager.currentPlayerNumber 
				|| clickedTerritory.armyCount <= 1)
					return -1;
		
			GameState.playArea.selectTerritory(clickedTerritory);
			clickedTerritory.highlightNeighbors();
			return clickedTerritory.territoryNumber;
		}
		
		var clickedTile : HexaTile = GameState.playArea.checkForClickedTiles(xPos, yPos);		
		if ( clickedTile != null )
		{
			var clickedTerritory : Territory = GameState.territoryManager.getTerritory(clickedTile.territoryNumber);
			
			if ( selectedTerritory != -1)		// If there is a selected territory
			{
				// We check if what we clicked is a neighbor of the selected territory 
				if ( GameState.territoryManager.getTerritory(selectedTerritory).checkIfEnemyNeighbor(clickedTile.territoryNumber) )
				{
					GameState.battleManager.startAttack(selectedTerritory, clickedTile.territoryNumber);
					selectedTerritory = GameState.playArea.deselectTerritory(selectedTerritory);					
				}
				// We check if we clicked the same territory
				else if ( selectedTerritory == clickedTile.territoryNumber )
				{
					selectedTerritory = GameState.playArea.deselectTerritory(selectedTerritory);					
				}
				else
				{
					// We deselect a selected territory
					selectedTerritory = GameState.playArea.deselectTerritory(selectedTerritory);
					
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
		GameState.gameGUI.hideDoneButton();	
		
		// We add a short delay
		if ( taskManager != null )
			taskManager.clear();
		
		taskManager = new ARTaskManager(false);
		taskManager.addPause(0.25);
		taskManager.addInstantTask(this, GameState.playerManager.currentPlayer.randomlyAssignArmies, [GameState.playerManager.currentPlayer.territories.length], true);
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
		
		GameState.playerManager.nextPlayer();
		GameState.gameGUI.updateDoneButtonVisibility();			
	}
	
	public function checkIfGameHasEnded() 
	{
		var lostCount : Int = 0;
		var playerList : Array<Player> = GameState.playerManager.playerList;
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
		FlxG.paused = false;
		GameState.gameGUI.show();
		GameState.gameGUI.updateDoneButtonVisibility();	
		
		var currentPlayer : Player = GameState.playerManager.currentPlayer;
		if ( !currentPlayer.isHuman )
			currentPlayer.ai.startPlanning();
	}
	
	public function pauseGame()
	{
		//TODO: Create your own ARTaskManager that follows FlxG.paused
		FlxG.paused = true;
		
		GameState.gameGUI.hideButtonsOnPause();
		GameState.pauseMenuLayer.toggleStatus();
		GameState.cameraManager.zoomOut();	
	}
	
	public function resumeGame()
	{
		FlxG.paused = false;
		
		GameState.gameGUI.showButtonsOnResume();
	}
	
	public function resetGame() 
	{
		FlxG.paused = false;
		FlxG.resetState();
	}
	
	public function endGame() 
	{
		if ( taskManager != null )
			taskManager.clear();		
		
		GameState.gameGUI.hide();
		FlxG.paused = true;
		FlxG.switchState(new GameState());
	}
}