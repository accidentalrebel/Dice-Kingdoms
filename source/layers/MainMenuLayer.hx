package layers;
import flixel.addons.ui.FlxButtonPlus;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxPoint;
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
		add(title);
		
		var numOfPlayersButton = new FlxButtonPlus
			(Std.int(MainStage.cameraWidth / 2 - BUTTON_WIDTH / 2), Std.int(LOGO_HEIGHT + BUTTON_PADDING + (BUTTON_HEIGHT + BUTTON_PADDING) * 0)
			, null, null, "NUM OF PLAYERS: 7", BUTTON_WIDTH, BUTTON_HEIGHT);		
		numOfPlayersButton.setOnClickCallback(MainMenuState.mainMenuManager.adjustNumOfPlayers, [numOfPlayersButton]);
		add(numOfPlayersButton);
		
		var turnPositionButton = new FlxButtonPlus
			(Std.int(MainStage.cameraWidth / 2 - BUTTON_WIDTH / 2), Std.int(LOGO_HEIGHT + BUTTON_PADDING + (BUTTON_HEIGHT + BUTTON_PADDING) * 1)
			, null, null, "TURN POSITION: RANDOM", BUTTON_WIDTH, BUTTON_HEIGHT);		
		turnPositionButton.setOnClickCallback(MainMenuState.mainMenuManager.adjustTurnPosition, [turnPositionButton]);
		add(turnPositionButton);
		
		var startButton : FlxButtonPlus = new FlxButtonPlus
			(Std.int(MainStage.cameraWidth / 2 - BUTTON_WIDTH / 2), Std.int(LOGO_HEIGHT + BUTTON_PADDING + (BUTTON_HEIGHT + BUTTON_PADDING) * 2.5)
			, MainMenuState.mainMenuManager.startGame, null, "START GAME", BUTTON_WIDTH, BUTTON_HEIGHT);		
		add(startButton);
		
		//var settingsButton : FlxButtonPlus = new FlxButtonPlus
			//(Std.int(MainStage.cameraWidth / 2 - BUTTON_WIDTH / 2), Std.int(LOGO_HEIGHT + BUTTON_PADDING + (BUTTON_HEIGHT + BUTTON_PADDING) * 1)
			//, MainMenuState.mainMenuManager.showSettingsMenu, null, "SETTINGS", BUTTON_WIDTH, BUTTON_HEIGHT);		
		//add(settingsButton);
		//
		//var creditsButton : FlxButtonPlus = new FlxButtonPlus
			//(Std.int(MainStage.cameraWidth / 2 - BUTTON_WIDTH / 2), Std.int(LOGO_HEIGHT + BUTTON_PADDING + (BUTTON_HEIGHT + BUTTON_PADDING) * 2)
			//, MainMenuState.mainMenuManager.showCreditsMenu, null, "CREDITS", BUTTON_WIDTH, BUTTON_HEIGHT);		
		//add(creditsButton);
		
		this.setPosition(0, MainStage.cameraHeight / 2 - (startButton.y + BUTTON_HEIGHT) / 2);
	}
}