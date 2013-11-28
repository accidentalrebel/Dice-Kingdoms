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
	//TODO: Make an enum for the colors
												// RED		GREEN	   BLUE		 YELLOW   L.BLUE	PINK	   ORANGE	WHITE   
	public static var colorList : Array<Int> = [ 0xFF3333, 0x33FF33, 0x3333FF, 0xFFFF33, 0x33FFFF, 0xFF33FF, 0xFF6600, 0xFFFFFF ];		
	public static var maxTerritories : Int = Math.floor(PlayAreaLayer.PLAY_AREA_ROWS / 5) * Math.floor(PlayAreaLayer.PLAY_AREA_COLUMNS / 5);	
	public static var playAreaPadding : FlxPoint = new FlxPoint(15, 15);
	
	static public var territoryPerPlayer:Int;	
	static public var initialArmyCount:Int = 20;	
	static public var maxArmyCountPerTerritory : Int = 8;	
	
	static public var gameGUI:GameGUILayer;
	static public var playArea:PlayAreaLayer;
	static public var battleLayer: BattleLayer;
	static public var territoryManager:TerritoryManager;
	static public var gameplayManager:GameplayManager;
	static public var cameraManager : CameraManager;
	static public var playerManager:PlayerManager;
	static public var inputManager:InputManager;
	
	override public function create():Void 
	{
		//TODO: Work on the menu
		
		FlxG.cameras.bgColor = 0xFF000000;
		
		super.create();
		
		PlayState.cameraManager 		= new CameraManager();
		PlayState.gameplayManager	= new GameplayManager();
		
		// We setup the input Manager
		PlayState.inputManager 		= new InputManager();
		add(PlayState.inputManager);
		
		// We setup the Main GUI
		PlayState.gameGUI 			= new GameGUILayer();
		PlayState.battleLayer 		= new BattleLayer();
		
		// We setup the territory manager
		PlayState.territoryManager 	= new TerritoryManager();
		
		// We setup the playArea and player manager
		PlayState.playArea 			= new PlayAreaLayer();
		PlayState.playArea.init(this);
		PlayState.playArea.setupTerritories();	
		
		//TODO: Player arrangement should be randomized
		PlayState.playerManager = new PlayerManager();
		PlayState.playArea.assignTerritories();
		PlayState.playerManager.initializeArmies();
		PlayState.playArea.setupFinished = true;
		
		//PlayState.cameraManager.focusOnRandomTerritory(PlayState.playerManager.currentPlayerNumber);
		
		// We arrange the different layers
		add(PlayState.playArea);
		add(PlayState.playArea.playAreaCanvas);
		add(PlayState.gameGUI);
		add(PlayState.battleLayer);
		
		// We assign layers to their respective cameras
		PlayState.playArea.setAll("cameras", [ PlayState.cameraManager.mainCamera ]);
		PlayState.battleLayer.setAll("cameras", [ PlayState.cameraManager.topBarCamera ]);
		PlayState.gameGUI.setAll("cameras", [ PlayState.cameraManager.mainCamera ]);
	}
}