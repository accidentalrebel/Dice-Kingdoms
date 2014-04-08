package objects;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxRandom;
import misc.PlayerColor;
import states.GameState;
import tools.ARTaskManager;

/**
 * ...
 * @author Karlo
 */
class Die extends FlxSprite
{
	inline public static var DIE_DIMENSION : Int = 30;
	private static inline var DIE_ROLL_SPEED : Int = 15;
	
	var dieFace:FlxSprite;
	var whiteDieFace:FlxSprite;
	var blackDieFace:FlxSprite;
	var parent:FlxGroup;
	var taskManager:ARTaskManager;
	var currentFaceIndex:Int;

	public function new(tParent : FlxGroup, xPos : Float, yPos : Float) 
	{
		parent = tParent;
		
		super(xPos, yPos);
		
		this.loadGraphic("assets/dieBG.png", false, false, DIE_DIMENSION, DIE_DIMENSION, true);
		
		whiteDieFace = new FlxSprite(xPos, yPos);
		whiteDieFace.loadGraphic("assets/dice-white.png", true, false, DIE_DIMENSION, DIE_DIMENSION, false);
		whiteDieFace.animation.add("roll", [0, 1, 2, 3, 4, 5], DIE_ROLL_SPEED, true);
		whiteDieFace.visible = false;
		
		blackDieFace = new FlxSprite(xPos, yPos);
		blackDieFace.loadGraphic("assets/dice-black.png", true, false, DIE_DIMENSION, DIE_DIMENSION, false);
		blackDieFace.animation.add("roll", [0, 1, 2, 3, 4, 5], DIE_ROLL_SPEED, true);
		blackDieFace.visible = false;
		
		dieFace = blackDieFace;
		
		tParent.add(this);
		parent.add(blackDieFace);
		parent.add(whiteDieFace);
		
		hide();
		
		whiteDieFace.cameras = [ GameState.cameraManager.topBarCamera ];
		blackDieFace.cameras = [ GameState.cameraManager.topBarCamera ];
	}
	
	public function show() 
	{
		this.visible = true;
		dieFace.visible = true;
	}
	
	public function hide()
	{
		this.visible = false;
		dieFace.visible = false;
	}
	
	public function updateDieFace(frameIndex : Int = 0) 
	{
		dieFace.animation.frameIndex = frameIndex;
		currentFaceIndex = frameIndex;
	}
	
	public function updateDieColor(colorToUse:Int) 
	{
		if ( colorToUse == PlayerColor.AQUA 		
			|| colorToUse == PlayerColor.YELLOW
			|| colorToUse == PlayerColor.WHITE ) 
		{
			whiteDieFace.visible = false;
			blackDieFace.visible = true;
			dieFace = blackDieFace;
		}
		else
		{
			whiteDieFace.visible = true;
			blackDieFace.visible = false;
			dieFace = whiteDieFace;
		}
		
		this.color = colorToUse;
	}
	
	/**
	 * Stats the rolling animation
	 * @param	tDuration		The duration of the rollAnimation
	 */
	public function rollAnimation(tDuration : Float) 
	{
		if ( taskManager != null || dieFace.animation == null)
			taskManager.clear();
		
		show();
		
		if ( dieFace != null && dieFace.animation != null )
			dieFace.animation.play("roll", true, FlxRandom.intRanged(0, 5));
			
		taskManager = new ARTaskManager(false);
		taskManager.addPause(tDuration);
		taskManager.addInstantTask(this, revealRoll);
	}
	
	/**
	 * Reveals the actual roll value
	 */
	function revealRoll() 
	{
		if ( dieFace.animation == null )
			return;
		
		dieFace.animation.pause();
		updateDieFace(currentFaceIndex);
	}
	
	override function destroy()
	{
		super.destroy();
		
		if ( taskManager != null )
			taskManager.destroy();
		
		if ( dieFace != null )
			dieFace.destroy();
	}
}