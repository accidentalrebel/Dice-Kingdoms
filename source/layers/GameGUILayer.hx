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
		
		playerIndicator = new FlxText(5, 5, 100, "Player 1", 16);
		add(playerIndicator);
		var doneButton : FlxButtonPlus = new FlxButtonPlus(5, 30, GameplayManager.nextPlayer, null, "DONE", 100, 40);		
		add(doneButton);
		
		var zoomButton : FlxButtonPlus = new FlxButtonPlus(5, 80, CameraManager.toggleZoom, null, "TOGGLE ZOOM", 100, 40);		
		add(zoomButton);
		
		var resetButton : FlxButtonPlus = new FlxButtonPlus(5, 130, GameplayManager.resetGame, null, "NEW GAME", 100, 40);		
		add(resetButton);
		
		// Everything in this group does not move from the camera
		this.setAll("scrollFactor", new FlxPoint(0, 0));
	}
}