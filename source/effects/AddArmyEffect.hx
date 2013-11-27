package effects;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author Karlo
 */
class AddArmyEffect extends FlxText
{
	public function new(xPos : Float = 0, yPos : Float = 0, str : String) 
	{
		super(xPos, yPos, 40, "+" + str, 14);
		this.alignment = "center";
		
		FlxTween.linearMotion(this, xPos, yPos, xPos, yPos - 20, 1, true);
	}	
}