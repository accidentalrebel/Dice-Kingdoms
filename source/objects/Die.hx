package objects;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import misc.PlayerColor;
import states.PlayState;

/**
 * ...
 * @author Karlo
 */
class Die extends FlxSprite
{
	inline public static var DIE_DIMENSION : Int = 30;
	
	var dieFace:FlxSprite;
	var whiteDieFace:FlxSprite;
	var blackDieFace:FlxSprite;
	var parent:FlxGroup;

	public function new(tParent : FlxGroup, xPos : Float, yPos : Float) 
	{
		parent = tParent;
		
		super(xPos, yPos);
		
		this.loadGraphic("assets/dieBG.png", false, false, DIE_DIMENSION, DIE_DIMENSION, true);
		
		whiteDieFace = new FlxSprite(xPos, yPos);
		whiteDieFace.loadGraphic("assets/dice.png", false, false, DIE_DIMENSION, DIE_DIMENSION, false);
		whiteDieFace.visible = false;
		
		blackDieFace = new FlxSprite(xPos, yPos);
		blackDieFace.loadGraphic("assets/dice.png", false, false, DIE_DIMENSION, DIE_DIMENSION, true);
		blackDieFace.color = 0x555555;
		blackDieFace.visible = false;
		
		dieFace = blackDieFace;
		
		tParent.add(this);
		parent.add(blackDieFace);
		parent.add(whiteDieFace);
		
		hide();
		
		whiteDieFace.cameras = [ PlayState.cameraManager.topBarCamera ];
		blackDieFace.cameras = [ PlayState.cameraManager.topBarCamera ];
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
	
	function updateFace(frameIndex : Int = 0) 
	{
		dieFace.animation.frameIndex = frameIndex;
	}
	
	function updateColor(colorToUse:Int) 
	{
		if ( colorToUse == PlayerColor.LIGHT_BLUE 		
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
	
	public function updateDie(attackerColor:Int, frameIndex:Int) 
	{
		updateColor(attackerColor);
		updateFace(frameIndex);
	}
}