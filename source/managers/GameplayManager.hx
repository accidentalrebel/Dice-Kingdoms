package managers;
import effects.AddArmyEffect;
import flixel.system.FlxSound;
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
	private var hasGameStarted : Bool = false;
	
	public function new()
	{
		taskManager = new ARTaskManager();
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
			if (clickedTerritory.ownerNumber != GameState.playerManager.currentPlayer.playerNum 
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
		
		taskManager.clear();
		
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
				trace(player.playerNum + " has lost!");
				lostCount++;
			}
		}
		
		if ( lostCount >= playerList.length - 1 )
			return true;
		
		return false;
	}
	
	public function startGame() 
	{
		//if ( hasGameStarted )
			//return;
		
		var bgm : FlxSound = new FlxSound();
		bgm.loadEmbedded("BGM", true);
		bgm.play();
		GameState.instance.add(bgm);
		
		FlxG.paused = false;
		GameState.gameGUI.show();
		GameState.gameGUI.updateDoneButtonVisibility();
		GameState.inputManager.enableDragging();
		
		var currentPlayer : Player = GameState.playerManager.currentPlayer;
		if ( !currentPlayer.isHuman )
			currentPlayer.ai.startPlanning();
	}
	
	public function pauseGame()
	{
		FlxG.paused = true;
		
		GameState.gameGUI.hideButtonsOnPause();
		GameState.battleLayer.hide();
		GameState.pauseMenuLayer.show();
		GameState.cameraManager.zoomOut();	
		GameState.inputManager.disableDragging();
	}
	
	public function resumeGame()
	{
		FlxG.paused = false;
		
		GameState.battleLayer.show();
		GameState.pauseMenuLayer.hide();
		GameState.inputManager.enableDragging();
		GameState.gameGUI.showButtonsOnResume();
	}
	
	public function resetGame() 
	{
		FlxG.paused = false;
		FlxG.resetState();
	}
	
	public function endGame() 
	{
		hasGameStarted = false;
		
		taskManager.clear();
		taskManager.destroy();
		
		GameState.gameGUI.hide();
		FlxG.paused = true;
		
		GameState.inputManager.disableDragging();
		FlxG.switchState(new GameState());
	}
}