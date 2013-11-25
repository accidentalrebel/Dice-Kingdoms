package layers;
import flixel.addons.ui.FlxButtonPlus;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxPoint;
import managers.CameraManager;
import managers.GameplayManager;
import states.PlayState;

/**
 * ...
 * @author Karlo
 */
class GameGUILayer extends FlxGroup
{
	public var playerIndicator : FlxText;
	
	public function new() 
	{
		super();
		
		var buttonHeight : Int = 60;
		
		playerIndicator = new FlxText(5, 5, 100, "Player 1", 16);
		add(playerIndicator);
		var doneButton : FlxButtonPlus = new FlxButtonPlus(5, Std.int(playerIndicator.height + 10), GameplayManager.nextPlayer, null, "DONE", 80, buttonHeight);		
		add(doneButton);
		
		var zoomButton : FlxButtonPlus = new FlxButtonPlus(5, Std.int(playerIndicator.height + buttonHeight + 40), CameraManager.toggleZoom, null, "TOGGLE ZOOM", 80, buttonHeight);		
		add(zoomButton);
		
		//var resetButton : FlxButtonPlus = new FlxButtonPlus(5, (buttonHeight + 10) * 3, GameplayManager.resetGame, null, "NEW GAME", 80, buttonHeight);		
		//add(resetButton);
		
		// Everything in this group does not move from the camera
		this.setAll("scrollFactor", new FlxPoint(0, 0));
	}
}