package layers;
import effects.AddArmyEffect;
import flixel.addons.ui.FlxButtonPlus;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
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
class GameGUILayer extends FlxSpriteGroup
{
	private var playerIndicator : FlxText;
	private var doneButton:FlxButtonPlus;
	private var zoomButton:FlxButtonPlus;
	private var pauseButton:FlxButtonPlus;
	
	private static inline var BUTTON_HEIGHT:Int = 60;
	private static inline var BUTTON_WIDTH : Int = 80;
	private static inline var PADDING : Int = 5;
	
	public function new() 
	{
		super();
		
		playerIndicator = new FlxText(PADDING, PADDING, 300, "Player 1", 16);
		add(playerIndicator);
		
		zoomButton = new FlxButtonPlus(PADDING, Std.int(playerIndicator.height + PADDING)
			, PlayState.cameraManager.toggleZoom, null
			, "TOGGLE ZOOM", BUTTON_WIDTH, BUTTON_HEIGHT);		
		add(zoomButton);
		
		doneButton = new FlxButtonPlus(PADDING, Std.int(playerIndicator.height + BUTTON_HEIGHT + PADDING * 2)
			, PlayState.gameplayManager.endCurrentPlayerMove, null
			, "DONE", BUTTON_WIDTH, BUTTON_HEIGHT);		
		add(doneButton);
		
		//TODO: Consider having a MainStage.width height instead of second guessing all the time
		pauseButton = new FlxButtonPlus(Std.int(PlayState.cameraManager.mainCamera.width - BUTTON_WIDTH - PADDING)
			, Std.int(playerIndicator.height + PADDING), PlayState.gameplayManager.pauseGame, null
			, "PAUSE", BUTTON_WIDTH, BUTTON_HEIGHT);
		add(pauseButton);
		
		// Everything in this group does not move from the camera
		this.setAll("scrollFactor", new FlxPoint(0, 0));
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
	
	public function onCameraScale(newScale : Float) 
	{
		this.origin = new FlxPoint();
		this.scale = new FlxPoint(1 / newScale, 1 / newScale);
		
		playerIndicator.x = playerIndicator.y = PADDING / newScale;
		
		zoomButton.x = PADDING / newScale;
		zoomButton.y = (playerIndicator.height + PADDING) / newScale;
		
		doneButton.x = PADDING / newScale; 
		doneButton.y = (playerIndicator.height + BUTTON_HEIGHT + PADDING * 2) / newScale;
		
		pauseButton.x = (FlxG.width - BUTTON_WIDTH - PADDING) / newScale ;
		pauseButton.y = (playerIndicator.height +  PADDING) / newScale;
	}
}