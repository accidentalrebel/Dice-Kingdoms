package managers;
import flixel.FlxG;
import objects.Player;
import states.GameState;
import ui.CustomButton;

/**
 * ...
 * @author Karlo
 */
class PreGameManager
{
	inline public static var MAX_PLAYER_COUNT : Int = 7;
	inline private static var MIN_PLAYER_COUNT : Int = 2;
	public static var currentOpponentCount : Int = MAX_PLAYER_COUNT - 1;
	public static var currentOrder : Null<Int> = null;
	
	public static function onEnter()
	{
		adjustOrderAgainstOpponentCount();
		updateListenersToOrderPosition();
	}
	
	public static function startGame()
	{
		GameState.menuLayer.hide();
		GameState.gameplayManager.startGame();
	}
	
	static public function changeMap() 
	{
		FlxG.resetState();
	}
	
	public static function adjustNumOfOpponents(numOfOpponentsButton : CustomButton) 
	{
		currentOpponentCount -= 1;
		if ( currentOpponentCount < MIN_PLAYER_COUNT - 1)
			currentOpponentCount = MAX_PLAYER_COUNT - 1;
		
		numOfOpponentsButton.text = "NUM OF OPPONENTS: " + currentOpponentCount;
		
		FlxG.resetState();
	}
	
	public static function adjustOrderPosition(turnOrderButton : CustomButton) 
	{	
		function capOrderAccordingToOpponentCount()
		{
			if ( currentOrder > currentOpponentCount + 1 )
				currentOrder = currentOpponentCount + 1;
		}
		
		function adjustCurrentOrder()
		{
			if ( currentOrder == null )
				currentOrder = 1;
			else if ( currentOrder >= currentOpponentCount + 1 )
				currentOrder = null;
			else
				currentOrder += 1;
		}
		
		capOrderAccordingToOpponentCount();
		adjustCurrentOrder();
		
		updateListenersToOrderPosition();
	}
	
	private static function adjustOrderAgainstOpponentCount()
	{
		if ( currentOrder > currentOpponentCount + 1 )
			currentOrder = currentOpponentCount + 1;
	}
	
	static private function updateListenersToOrderPosition() 
	{
		var playerManager : PlayerManager = GameState.playerManager;
		if ( currentOrder == null )
			playerManager.shufflePlayerSequence();
		else	
			playerManager.changeSequenceOrderPosition(playerManager.humanPlayer.playerNum, currentOrder-1);
		
		GameState.playerManager.setCurrentPlayer(0);
		GameState.pauseMenuLayer.updatePlayerList();
		GameState.menuLayer.updateOrderPositionButton(currentOrder);
	}	
}