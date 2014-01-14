package managers;
import flixel.FlxG;
import states.PlayState;

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
		FlxG.switchState(new PlayState());
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