package managers;
import flixel.FlxG;
import states.GameState;
import ui.CustomButton;

/**
 * ...
 * @author Karlo
 */
class MainMenuManager
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
		if ( currentOrder == null )
			currentOrder = 1;
		else if ( currentOrder >= MAX_PLAYER_COUNT )
			currentOrder = null;
		else
			currentOrder += 1;
		
		GameState.menuLayer.updateOrderPositionButton(currentOrder);
	}
}