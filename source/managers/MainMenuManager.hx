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
	
}