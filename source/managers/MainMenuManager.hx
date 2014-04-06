package managers;
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
	
}