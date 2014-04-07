package managers;
import flixel.addons.ui.FlxButtonPlus;
import flixel.FlxG;
import states.GameState;

/**
 * ...
 * @author Karlo
 */
class MainMenuManager
{
	inline private static var MAX_PLAYER_COUNT = 7;
	inline private static var MIN_PLAYER_COUNT = 2;
	public static var currentPlayerCount = 7;

	public function new() 
	{
		
	}
	
	public function startGame()
	{
		FlxG.switchState(new GameState());
	}
	
	public function showStartGameMenu() 
	{
		
	}
	
	public function showSettingsMenu() 
	{
		
	}
	
	public function showCreditsMenu() 
	{
		
	}
	
	public function adjustNumOfPlayers(startButton : FlxButtonPlus) 
	{
		currentPlayerCount -= 1;
		if ( currentPlayerCount < MIN_PLAYER_COUNT )
			currentPlayerCount = MAX_PLAYER_COUNT;
		
		startButton.text = "NUM OF PLAYERS: " + currentPlayerCount;
	}
	
	public function adjustTurnPosition(turnPositionButton : FlxButtonPlus) 
	{
		turnPositionButton.setPosition(0, 0);
	}
}