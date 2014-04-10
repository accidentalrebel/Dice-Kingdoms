package layers;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxPoint;
import managers.PreGameManager;
import states.GameState;
import states.MainMenuState;
import ui.CustomButton;

/**
 * ...
 * @author Karlo
 */
class MainMenuLayer extends FlxSpriteGroup
{
	inline private static var BUTTON_WIDTH = 300;
	inline private static var BUTTON_HEIGHT = 50;
	inline private static var BUTTON_PADDING = 20;
	
	private static inline var LOGO_WIDTH = 300;
	private static inline var LOGO_HEIGHT = 200;
	var orderPositionButton:ui.CustomButton;
	
	public function new() 
	{
		super();
		
		var title : FlxText = new FlxText(0, 30
			, Std.int(MainStage.cameraWidth), "Dice Kingdoms", 64);
		title.font = GameState.DEFAULT_FONT;
		title.alignment = "center";
		title.setBorderStyle(FlxText.BORDER_OUTLINE_FAST, 0, 2, 1);
		add(title);
		
		var changeMapButton = new CustomButton
			(Std.int(MainStage.cameraWidth / 2 - BUTTON_WIDTH / 2), Std.int(LOGO_HEIGHT + BUTTON_PADDING + (BUTTON_HEIGHT + BUTTON_PADDING) * 0)
			, null, null, "CHANGE MAP", BUTTON_WIDTH, BUTTON_HEIGHT);		
		changeMapButton.setOnClickCallback(PreGameManager.changeMap);
		add(changeMapButton);
		
		var numOfOpponentsButton = new CustomButton
			(Std.int(MainStage.cameraWidth / 2 - BUTTON_WIDTH / 2), Std.int(LOGO_HEIGHT + BUTTON_PADDING + (BUTTON_HEIGHT + BUTTON_PADDING) * 1)
			, null, null, "NUM OF OPPONENTS: " + PreGameManager.currentOpponentCount, BUTTON_WIDTH, BUTTON_HEIGHT);		
		numOfOpponentsButton.setOnClickCallback(PreGameManager.adjustNumOfOpponents, [numOfOpponentsButton]);
		add(numOfOpponentsButton);
		
		orderPositionButton = new CustomButton
			(Std.int(MainStage.cameraWidth / 2 - BUTTON_WIDTH / 2), Std.int(LOGO_HEIGHT + BUTTON_PADDING + (BUTTON_HEIGHT + BUTTON_PADDING) * 2)
			, null, null, "TURN POSITION: ", BUTTON_WIDTH, BUTTON_HEIGHT);		
		orderPositionButton.setOnClickCallback(PreGameManager.adjustOrderPosition, [orderPositionButton]);
		add(orderPositionButton);
		updateOrderPositionButton(PreGameManager.currentOrder);
		
		var startButton : CustomButton = new CustomButton
			(Std.int(MainStage.cameraWidth / 2 - BUTTON_WIDTH / 2), Std.int(LOGO_HEIGHT + BUTTON_PADDING + (BUTTON_HEIGHT + BUTTON_PADDING) * 3.5)
			, PreGameManager.startGame, null, "START GAME", BUTTON_WIDTH, BUTTON_HEIGHT);		
		add(startButton);
		
		this.setAll("scrollFactor", new FlxPoint(0, 0));
	}
	
	public function updateOrderPositionButton(currentOrder:Null<Int>)
	{
		function getPostfix(currentOrder) {			
			switch(currentOrder)
			{
				case 1: 	return "st";
				case 2: 	return "nd";
				case 3: 	return "rd";
				default: 	return "th";
			}
		}
		
		if ( currentOrder != null ) 
			orderPositionButton.text = "TURN POSITION: " + currentOrder + getPostfix(currentOrder);
		else
			orderPositionButton.text = "TURN POSITION: RANDOM";
	}
	
	public function show()
	{
		this.visible = true;
	}
	
	public function hide()
	{
		this.visible = false;
	}
}