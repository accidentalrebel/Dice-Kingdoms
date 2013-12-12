package layers;
import effects.AddArmyEffect;
import flixel.addons.ui.FlxButtonPlus;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxPoint;
import managers.CameraManager;
import managers.GameplayManager;
import objects.Player;
import states.PlayState;
import tools.ARFade;

/**
 * ...
 * @author Karlo
 */
class GameGUILayer extends FlxGroup
{
	private var playerIndicator : FlxText;
	private var doneButton:FlxButtonPlus;
	private static inline var BUTTON_HEIGHT:Int = 60;
	private static inline var BUTTON_WIDTH : Int = 80;
	
	public function new() 
	{
		super();
		
		playerIndicator = new FlxText(5, 5, 300, "Player 1", 16);
		add(playerIndicator);
		
		var zoomButton : FlxButtonPlus = new FlxButtonPlus(5, Std.int(playerIndicator.height + 10)
			, PlayState.cameraManager.toggleZoom, null
			, "TOGGLE ZOOM", BUTTON_WIDTH, BUTTON_HEIGHT);		
		add(zoomButton);
		
		doneButton = new FlxButtonPlus(5, Std.int(playerIndicator.height + BUTTON_HEIGHT + 40)
			, PlayState.gameplayManager.endCurrentPlayerMove, null
			, "DONE", BUTTON_WIDTH, BUTTON_HEIGHT);		
		add(doneButton);
		
		// Everything in this group does not move from the camera
		this.setAll("scrollFactor", new FlxPoint(0, 0));
	}
	
	public function setupPauseButton()
	{
		//TODO: Consider having a MainStage.width height instead of second guessing all the time
		var pauseButton : FlxButtonPlus = new FlxButtonPlus(Std.int(PlayState.cameraManager.mainCamera.width - BUTTON_WIDTH)
			, Std.int(playerIndicator.height + 10), PlayState.pauseMenuLayer.toggleStatus, null
			, "PAUSE", BUTTON_WIDTH, BUTTON_HEIGHT);
		pauseButton.scrollFactor = new FlxPoint();
		add(pauseButton);
	}
	
	public function spawnAddArmyEffect(xPos : Float = 0, yPos : Float = 0, amount : Int = 0 )
	{	
		var addEffect : AddArmyEffect = cast(this.recycle(AddArmyEffect), AddArmyEffect);
		addEffect.init(xPos, yPos, Std.string(amount));
	}
	
	public function updatePlayerIndicator(isHuman:Bool, colorToUse:Int) 
	{
		playerIndicator.color = colorToUse;
		
		if ( isHuman )
			playerIndicator.text = "Player's Turn";		
		else
			playerIndicator.text = "CPU's Turn";
	}
	
	public function updateDoneButtonVisibility() 
	{
		if ( PlayState.playerManager.currentPlayer.isHuman )
			showDoneButton();	
		else
			hideDoneButton();	
	}
	
	public function hideDoneButton()
	{
		doneButton.active = false;
		doneButton.visible = false;
	}
	
	public function showDoneButton()
	{
		doneButton.active = true;
		doneButton.visible = true;
	}
}