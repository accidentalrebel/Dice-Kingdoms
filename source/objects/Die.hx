package objects;
import flixel.FlxSprite;
import flixel.group.FlxGroup;

/**
 * ...
 * @author Karlo
 */
class Die extends FlxSprite
{
	var dieFace:FlxSprite;

	public function new(tParent : FlxGroup, xPos : Float, yPos : Float) 
	{
		super(xPos, yPos);
		
		this.loadGraphic("assets/dieBG.png", false, false, 40, 40, true);
		
		dieFace = new FlxSprite(xPos, yPos);
		dieFace.loadGraphic("assets/dice.png", false, false, 40, 40, false);
		
		tParent.add(this);
		tParent.add(dieFace);
		
		//hide();
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
		this.color = colorToUse;
	}
}