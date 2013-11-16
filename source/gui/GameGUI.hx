package gui;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
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
		
		//TODO: Add Done and Player indicator as UI elements
		playerIndicator = new FlxText(5, 5, 100, "Player 1", 16);
		add(playerIndicator);
		var doneButton : FlxButton = new FlxButton(5, 26, "DONE", GameplayManager.nextPlayer);		
		add(doneButton);
	}
	
}