package states;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import layers.BattleLayer;
import layers.GameGUILayer;
import layers.GameObjectsLayer;
import layers.PauseMenuLayer;
import layers.PlayAreaLayer;
import managers.BattleManager;
import managers.CameraManager;
import managers.GameplayManager;
import managers.InputManager;
import managers.PlayerManager;
import managers.TerritoryManager;

/**
 * ...
 * @author Karlo
 */
class PlayState extends FlxState
{
	public static var maxTerritories : Int = Math.floor(PlayAreaLayer.PLAY_AREA_ROWS / 5) * Math.floor(PlayAreaLayer.PLAY_AREA_COLUMNS / 5);	
	
	static public var territoryPerPlayer		: Int;	
	static public var initialArmyCount			: Int = 20;	
	static public var maxArmyCountPerTerritory 	: Int = 8;	
	
	static public var gameGUI			:GameGUILayer;
	static public var playArea			:PlayAreaLayer;
	static public var battleManager		:BattleManager;
	static public var battleLayer		:BattleLayer;
	static public var territoryManager	:TerritoryManager;
	static public var gameplayManager	:GameplayManager;
	static public var cameraManager 	:CameraManager;
	static public var playerManager		:PlayerManager;
	static public var inputManager		:InputManager;
	static public var gameObjectsLayer	:FlxGroup;
	static public var pauseMenuLayer	:PauseMenuLayer;
	
	override public function create():Void 
	{
		//TODO: Work on the menu
		
		FlxG.cameras.bgColor = 0xFF000000;
		
		super.create();
		
		PlayState.cameraManager 		= new CameraManager();
		PlayState.gameplayManager		= new GameplayManager();
		PlayState.battleManager			= new BattleManager();
		
		// We setup the input Manager
		PlayState.inputManager 			= new InputManager();
		add(PlayState.inputManager);
		
		// We setup the layers
		PlayState.gameGUI 				= new GameGUILayer();
		PlayState.battleLayer 			= new BattleLayer();
		PlayState.gameObjectsLayer		= new GameObjectsLayer();
		
		// We setup the territory manager
		PlayState.territoryManager 		= new TerritoryManager();
		
		// We setup the playArea and player manager
		PlayState.playArea 				= new PlayAreaLayer();
		PlayState.playArea.init(this);
		PlayState.playArea.setupTerritories();	
		
		PlayState.playerManager 		= new PlayerManager();
		PlayState.playArea.assignTerritories();
		PlayState.playerManager.initializeArmies();
		PlayState.playArea.setupFinished = true;
		PlayState.pauseMenuLayer 		= new PauseMenuLayer();
		
		// We arrange the different layers
		add(PlayState.playArea);
		add(PlayState.playArea.playAreaCanvas);
		add(PlayState.gameObjectsLayer);
		add(PlayState.gameGUI);
		add(PlayState.battleLayer);
		add(PlayState.pauseMenuLayer);
		
		// We assign layers to their respective cameras
		PlayState.playArea.setAll("cameras", [ PlayState.cameraManager.mainCamera ]);
		PlayState.battleLayer.setAll("cameras", [ PlayState.cameraManager.topBarCamera ], true);
		PlayState.gameGUI.setAll("cameras", [ PlayState.cameraManager.mainCamera ]);
		
		// We start the game
		PlayState.gameplayManager.startGame();
		
		PlayState.gameGUI.attackerBattleResult.attachToTerritory(1);
		PlayState.gameGUI.defenderBattleResult.attachToTerritory(5);
	}
}