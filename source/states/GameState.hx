package states;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.system.FlxSound;
import layers.BattleLayer;
import layers.GameGUILayer;
import layers.GameObjectsLayer;
import layers.MainMenuLayer;
import layers.PauseMenuLayer;
import layers.PlayAreaLayer;
import managers.BattleManager;
import managers.CameraManager;
import managers.GameplayManager;
import managers.InputManager;
import managers.PreGameManager;
import managers.PlayerManager;
import managers.TerritoryManager;
import misc.StampsHolder;

/**
 * ...
 * @author Karlo
 */
enum FontList {
	BlackCastle;
	Primitive;
}
 
class GameState extends FlxState
{	
	public static var DEFAULT_FONT : String	= Std.string(FontList.BlackCastle);
	
	static public var territoryPerPlayer		: Int;	
	static public var initialArmyCount			: Int = 3;	
	static public var maxArmyCountPerTerritory 	: Int = 8;
	static public var instance 			: GameState;
	
	static public var gameGUI			:GameGUILayer;
	static public var playArea			:PlayAreaLayer;
	static public var battleManager		:BattleManager;
	static public var battleLayer		:BattleLayer;
	static public var territoryManager	:TerritoryManager;
	static public var gameplayManager	:GameplayManager;
	static public var cameraManager 	:CameraManager;
	static public var playerManager		:PlayerManager;
	static public var inputManager		:InputManager;
	static public var gameObjectsLayer	:GameObjectsLayer;
	static public var pauseMenuLayer	:PauseMenuLayer;
	static public var stampsHolder		:StampsHolder;
	
	public static var mainMenuManager	:PreGameManager;
	public static var menuLayer 		:MainMenuLayer;
	
	override public function create():Void 
	{
		//TODO: Create a sound manager
		var bgm : FlxSound = new FlxSound();
		bgm.loadEmbedded("BGM", true);
		bgm.play();
		add(bgm);
		
		FlxG.cameras.bgColor = 0xFF111111;
		#if !FLX_NO_MOUSE
		FlxG.mouse.show();
		#end
		
		super.create();
		
		PreGameManager.adjustOrderAgainstOpponentCount();
		
		GameState.instance 				= this;
		
		GameState.cameraManager 		= new CameraManager();
		GameState.gameplayManager		= new GameplayManager();
		GameState.battleManager			= new BattleManager();
		GameState.stampsHolder 			= new StampsHolder();
		
		// We setup the input Manager
		GameState.inputManager 			= new InputManager();
		add(GameState.inputManager);
		
		// We setup the layers
		GameState.gameGUI 				= new GameGUILayer();
		GameState.battleLayer 			= new BattleLayer();
		GameState.gameObjectsLayer		= new GameObjectsLayer();
		GameState.territoryManager 		= new TerritoryManager();
		
		// We setup the playArea and player manager
		GameState.playArea 				= new PlayAreaLayer();
		GameState.playArea.init(GameState.instance);
		GameState.playArea.setupTerritories();	
		GameState.playerManager = new PlayerManager(PreGameManager.currentOpponentCount + 1);
		GameState.playArea.assignTerritories();
		GameState.playerManager.initializeArmies();
		GameState.playArea.setupFinished = true;
		GameState.pauseMenuLayer 		= new PauseMenuLayer(this);
		
		// We arrange the different layers
		add(GameState.playArea);
		add(GameState.gameObjectsLayer);
		add(GameState.gameGUI);
		add(GameState.battleLayer);
		add(GameState.pauseMenuLayer);
		add(GameState.pauseMenuLayer.playerListGroup);
		
		// We assign layers to their respective cameras
		GameState.playArea.setAll("cameras", [ GameState.cameraManager.mainCamera ]);
		GameState.battleLayer.setAll("cameras", [ GameState.cameraManager.topBarCamera ], true);
		GameState.gameGUI.setAll("cameras", [ GameState.cameraManager.mainCamera ]);
		
		menuLayer 		= new MainMenuLayer();
		
		this.add(menuLayer);
	}
	
	override public function destroy():Void 
	{
		super.destroy();
		
		GameState.battleManager.reset();
		GameState.playerManager.reset();
		GameState.territoryManager.reset();
		GameState.playArea.reset();
		GameState.battleLayer.destroy();
	}
}