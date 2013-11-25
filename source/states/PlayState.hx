package states;
import flixel.FlxSprite;
import flixel.util.FlxPoint;
import layers.BattleLayer;
import layers.GameGUILayer;
import managers.CameraManager;
import managers.GameplayManager;
import managers.InputManager;
import managers.PlayerManager;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxMath;
import layers.PlayAreaLayer;
import managers.TerritoryManager;
import tools.Tools;

/**
 * ...
 * @author Karlo
 */
class PlayState extends FlxState
{
	override public function create():Void 
	{
		FlxG.cameras.bgColor = 0xFF000000;
		
		super.create();
		
		CameraManager.init();
		
		// We setup the input Manager
		var inputManager : InputManager = new InputManager();
		add(inputManager);
		
		// We setup the Main GUI
		Registry.gameGUI = new GameGUILayer();
		Registry.battleLayer = new BattleLayer();
		
		// We setup the territory manager
		Registry.territoryManager = new TerritoryManager();
		
		// We setup the playArea and player manager
		Registry.playArea = new PlayAreaLayer();
		Registry.playArea.init(this);
		Registry.playArea.setupTerritories();	
		PlayerManager.init();
		Registry.playArea.assignTerritories();
		PlayerManager.initializeArmies();
		
		CameraManager.focusOnRandomTerritory(PlayerManager.currentPlayerNumber);
		
		// We arrange the different layers
		add(Registry.playArea);
		add(Registry.playArea.playAreaCanvas);
		add(Registry.gameGUI);
		add(Registry.battleLayer);
		
		// We assign layers to their respective cameras
		Registry.playArea.setAll("cameras", [ CameraManager.mainCamera ]);
		Registry.battleLayer.setAll("cameras", [ CameraManager.topBarCamera ]);
		Registry.gameGUI.setAll("cameras", [ CameraManager.mainCamera ]);
	}
}