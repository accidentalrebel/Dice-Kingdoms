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
	inline private static var MAX_PLAYER_COUNT : Int = 7;
	inline private static var MIN_PLAYER_COUNT : Int = 2;
	public static var currentPlayerCount : Int = 7;
	public static var currentOrder : Null<Int> = null;

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
	
	public function adjustOrderPosition(turnOrderButton : FlxButtonPlus) 
	{
		function getPostfix(currentOrder) {			
			switch(currentOrder)
			{
				case 1: 	return "st";
				case 2: 	return "nd";
				case 3: 	return "rd";
				default: 	return "th";
			}
		}
		
		if ( currentOrder == null )
			currentOrder = 1;
		else if ( currentOrder >= MAX_PLAYER_COUNT )
			currentOrder = null;
		else
			currentOrder += 1;
		
		if ( currentOrder != null ) 
			turnOrderButton.text = "TURN POSITION: " + currentOrder + getPostfix(currentOrder);
		else
			turnOrderButton.text = "TURN POSITION: RANDOM";
	}
}