package layers;
import flixel.addons.ui.FlxButtonPlus;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.util.FlxPoint;
import states.MenuState;

/**
 * ...
 * @author Karlo
 */
class MenuLayer extends FlxGroup
{
	inline private static var BUTTON_DIMENSIONS_X = 140;
	inline private static var BUTTON_DIMENSIONS_Y = 80;
	
	public function new() 
	{
		super();
		
		var startButton : FlxButtonPlus = new FlxButtonPlus
			(Std.int(FlxG.width / 2 - BUTTON_DIMENSIONS_X / 2), Std.int(FlxG.height / 2 - BUTTON_DIMENSIONS_Y)
			, MenuState.mainMenuManager.startGame, null, "START GAME", BUTTON_DIMENSIONS_X, BUTTON_DIMENSIONS_Y);		
		add(startButton);
	}
}