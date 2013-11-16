package gui;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxPoint;
import managers.CameraManager;
import managers.GameplayManager;

/**
 * ...
 * @author Karlo
 */
class GameGUI extends FlxGroup
{
	public var playerIndicator : FlxText;
	
	public function new() 
	{
		super();
		
		playerIndicator = new FlxText(5, 5, 100, "Player 1", 16);
		add(playerIndicator);
		var doneButton : FlxButton = new FlxButton(5, 26, "DONE", GameplayManager.nextPlayer);		
		add(doneButton);
		
		// Everything in this group does not move from the camera
		this.setAll("scrollFactor", new FlxPoint(0, 0));
	}
}