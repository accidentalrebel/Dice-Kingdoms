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
	
	public static function startGame()
	{
		GameState.menuLayer.hide();
		GameState.gameplayManager.startGame();
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
		if ( currentOrder > currentOpponentCount + 1 )
			currentOrder = currentOpponentCount + 1;
		
		if ( currentOrder == null )
			currentOrder = 1;
		else if ( currentOrder >= currentOpponentCount + 1 )
			currentOrder = null;
		else
			currentOrder += 1;
		
		GameState.menuLayer.updateOrderPositionButton(currentOrder);
		
		GameState.playerManager.clearAllHumans();
		
		var playerToSetAsHuman : Player;
		if ( currentOrder == null )
			playerToSetAsHuman = GameState.playerManager.getRandomPlayer();
		else
			playerToSetAsHuman = GameState.playerManager.getPlayer(currentOrder);
		
		playerToSetAsHuman.setAsHuman();
		
		GameState.pauseMenuLayer.updatePlayerList();
	}
	
	public static function adjustOrderAgainstOpponentCount()
	{
		if ( currentOrder > currentOpponentCount + 1 )
			currentOrder = currentOpponentCount + 1;
	}
}