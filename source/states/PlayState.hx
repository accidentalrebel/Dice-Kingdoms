package states;
import gui.GameGUI;
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
		
		// We setup the Main GUI
		add(Registry.gameGUI = new GameGUI());
		
		// We setup the input Manager
		var inputManager : InputManager = new InputManager();
		add(inputManager);
		
		PlayArea.init(this);
		PlayArea.setupTerritories();	
		PlayerManager.init();
		PlayArea.assignTerritories();
		PlayerManager.initializeArmies();
	}
}