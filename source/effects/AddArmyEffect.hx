package effects;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author Karlo
 */
class AddArmyEffect extends FlxText
{

	public function new(xPos : Float = 0, yPos : Float = 0) 
	{
		super(xPos, yPos, 50, "X", 10);
		
		FlxTween.linearMotion(this, xPos, yPos, xPos, yPos - 20, 1, true);
	}
	
}