package layers;
import flixel.addons.ui.FlxButtonPlus;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxPoint;
import states.MenuState;

/**
 * ...
 * @author Karlo
 */
class MenuLayer extends FlxSpriteGroup
{
	inline private static var BUTTON_WIDTH = 140;
	inline private static var BUTTON_HEIGHT = 50;
	inline private static var BUTTON_PADDING = 20;
	
	private static inline var LOGO_WIDTH = 300;
	private static inline var LOGO_HEIGHT = 200;
	
	public function new() 
	{
		super();
		
		var logo : FlxSprite = new FlxSprite();
		logo.makeGraphic(LOGO_WIDTH, LOGO_HEIGHT);
		logo.setPosition(Std.int(MainStage.cameraWidth / 2 - LOGO_WIDTH / 2), 0);
		add(logo);
		
		var startButton : FlxButtonPlus = new FlxButtonPlus
			(Std.int(MainStage.cameraWidth / 2 - BUTTON_WIDTH / 2), Std.int(LOGO_HEIGHT + BUTTON_PADDING + (BUTTON_HEIGHT + BUTTON_PADDING) * 0)
			, MenuState.mainMenuManager.startGame, null, "START GAME", BUTTON_WIDTH, BUTTON_HEIGHT);		
		add(startButton);
		
		var settingsButton : FlxButtonPlus = new FlxButtonPlus
			(Std.int(MainStage.cameraWidth / 2 - BUTTON_WIDTH / 2), Std.int(LOGO_HEIGHT + BUTTON_PADDING + (BUTTON_HEIGHT + BUTTON_PADDING) * 1)
			, MenuState.mainMenuManager.showSettingsMenu, null, "SETTINGS", BUTTON_WIDTH, BUTTON_HEIGHT);		
		add(settingsButton);
		
		var creditsButton : FlxButtonPlus = new FlxButtonPlus
			(Std.int(MainStage.cameraWidth / 2 - BUTTON_WIDTH / 2), Std.int(LOGO_HEIGHT + BUTTON_PADDING + (BUTTON_HEIGHT + BUTTON_PADDING) * 2)
			, MenuState.mainMenuManager.showCreditsMenu, null, "CREDITS", BUTTON_WIDTH, BUTTON_HEIGHT);		
		add(creditsButton);
		
		this.setPosition(0, MainStage.cameraHeight / 2 - (creditsButton.y + BUTTON_HEIGHT) / 2);
	}
}