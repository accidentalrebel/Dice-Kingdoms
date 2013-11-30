package objects;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import states.PlayState;

/**
 * ...
 * @author Karlo
 */
class Die extends FlxSprite
{
	var dieFace:FlxSprite;
	var whiteDieFace:FlxSprite;
	var blackDieFace:FlxSprite;
	var parent:FlxGroup;

	public function new(tParent : FlxGroup, xPos : Float, yPos : Float) 
	{
		parent = tParent;
		
		super(xPos, yPos);
		
		this.loadGraphic("assets/dieBG.png", false, false, 40, 40, true);
		
		whiteDieFace = new FlxSprite(xPos, yPos);
		blackDieFace = new FlxSprite(xPos, yPos);
		whiteDieFace.loadGraphic("assets/dice.png", false, false, 40, 40, false);
		blackDieFace.loadGraphic("assets/dice.png", false, false, 40, 40, true);
		blackDieFace.color = 0x555555;
		dieFace = blackDieFace;
		
		tParent.add(this);
		
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
	
	public function updateFace(frameIndex : Int = 0) 
	{
		dieFace.animation.frameIndex = frameIndex;
	}
	
	public function updateColor(colorToUse:Int) 
	{
		if ( colorToUse == 0x33FFFF 		// If light blue
			|| colorToUse == 0xFFFF33 		// If yellow
			|| colorToUse == 0xFFFFFF ) 	// If white
		{
			dieFace = blackDieFace;
			parent.remove(whiteDieFace);
		}
		else
		{
			dieFace = whiteDieFace;
			parent.remove(blackDieFace);
		}
		
		parent.add(dieFace);
		this.color = colorToUse;
	}
}