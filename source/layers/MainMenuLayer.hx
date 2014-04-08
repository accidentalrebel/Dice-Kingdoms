package layers;
import flixel.addons.ui.FlxButtonPlus;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxPoint;
import managers.MainMenuManager;
import states.MainMenuState;

/**
 * ...
 * @author Karlo
 */
class MainMenuLayer extends FlxSpriteGroup
{
	inline private static var BUTTON_WIDTH = 140;
	inline private static var BUTTON_HEIGHT = 50;
	inline private static var BUTTON_PADDING = 20;
	
	private static inline var LOGO_WIDTH = 300;
	private static inline var LOGO_HEIGHT = 200;
	
	public function new() 
	{
		super();
		
		//var logo : FlxSprite = new FlxSprite();
		//logo.makeGraphic(LOGO_WIDTH, LOGO_HEIGHT);
		//logo.setPosition(Std.int(MainStage.cameraWidth / 2 - LOGO_WIDTH / 2), 0);
		//add(logo);
		
		var title : FlxText = new FlxText(Std.int(MainStage.cameraWidth / 2 - LOGO_WIDTH / 2), 0
			, LOGO_WIDTH, "Dice Kingdoms", 32);
		title.font = "BlackCastle";
		add(title);
		
		var numOfOpponentsButton = new FlxButtonPlus
			(Std.int(MainStage.cameraWidth / 2 - BUTTON_WIDTH / 2), Std.int(LOGO_HEIGHT + BUTTON_PADDING + (BUTTON_HEIGHT + BUTTON_PADDING) * 0)
			, null, null, "NUM OF OPPONENTS: " + Std.string(MainMenuManager.MAX_PLAYER_COUNT - 1), BUTTON_WIDTH, BUTTON_HEIGHT);		
		numOfOpponentsButton.setOnClickCallback(MainMenuState.mainMenuManager.adjustNumOfOpponents, [numOfOpponentsButton]);
		add(numOfOpponentsButton);
		
		var orderPositionButton = new FlxButtonPlus
			(Std.int(MainStage.cameraWidth / 2 - BUTTON_WIDTH / 2), Std.int(LOGO_HEIGHT + BUTTON_PADDING + (BUTTON_HEIGHT + BUTTON_PADDING) * 1)
			, null, null, "TURN POSITION: RANDOM", BUTTON_WIDTH, BUTTON_HEIGHT);		
		orderPositionButton.setOnClickCallback(MainMenuState.mainMenuManager.adjustOrderPosition, [orderPositionButton]);
		add(orderPositionButton);
		
		var startButton : FlxButtonPlus = new FlxButtonPlus
			(Std.int(MainStage.cameraWidth / 2 - BUTTON_WIDTH / 2), Std.int(LOGO_HEIGHT + BUTTON_PADDING + (BUTTON_HEIGHT + BUTTON_PADDING) * 2.5)
			, MainMenuState.mainMenuManager.startGame, null, "START GAME", BUTTON_WIDTH, BUTTON_HEIGHT);		
		add(startButton);
		
		this.setPosition(0, MainStage.cameraHeight / 2 - (startButton.y + BUTTON_HEIGHT) / 2);
	}
}