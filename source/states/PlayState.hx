package states;
import layers.GameGUILayer;
import managers.GameplayManager;
import managers.InputManager;
import managers.PlayerManager;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxMath;
import layers.PlayAreaLayer;

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
		
		// We setup the input Manager
		var inputManager : InputManager = new InputManager();
		add(inputManager);
		
		// We setup the Main GUI
		Registry.gameGUI = new GameGUILayer();
		
		// We setup the playArea and player manager
		add(Registry.playArea = new PlayAreaLayer());
		Registry.playArea.init(this);
		Registry.playArea.setupTerritories();	
		PlayerManager.init();
		Registry.playArea.assignTerritories();
		PlayerManager.initializeArmies();
		
		// We then add the GUI to the stage
		add(Registry.gameGUI);		
	}
}