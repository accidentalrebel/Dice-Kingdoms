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
		startButton.setPosition(0, 0);
	}
}