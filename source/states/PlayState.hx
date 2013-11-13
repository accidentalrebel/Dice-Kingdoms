package states;
import managers.GameplayManager;
import managers.InputManager;
import managers.PlayerManager;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxMath;
import playArea.PlayArea;

/**
 * ...
 * @author Karlo
 */
class PlayState extends FlxState
{
	override public function create():Void 
	{
		FlxG.cameras.bgColor = 0xFF435169;
		//FlxG.camera.zoom = 2;
		
		super.create();
		
		var inputManager : InputManager = new InputManager();
		add(inputManager);
		
		//TODO: Add Done and Player indicator as UI elements
		Registry.playerIndicator = new FlxText(5, 5, 100, "Player 1", 16);
		add(Registry.playerIndicator);
		var doneButton : FlxButton = new FlxButton(5, 26, "DONE",GameplayManager.nextPlayer);		
		add(doneButton);
		
		PlayArea.init(this);
		PlayArea.setupTerritories();	
		PlayerManager.init(8);
		PlayArea.assignTerritories();
		PlayerManager.initializeArmies();
	}
}