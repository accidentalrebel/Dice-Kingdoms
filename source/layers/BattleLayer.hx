package layers;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.util.FlxPoint;
import managers.CameraManager;

/**
 * ...
 * @author Karlo
 */
class BattleLayer extends FlxGroup
{
	public function new() 
	{
		super();
		
		var battleBackground : FlxSprite = new FlxSprite();
		battleBackground = battleBackground.makeGraphic(200, 200, 0xff000000 );
		battleBackground.alpha = 0.5;
		add(battleBackground);
		
		var battleResult : FlxText = new FlxText(200, 200, 30, "Test");
		add(battleResult);
		
		this.setAll("scrollFactor", new FlxPoint(0, 0));
	}
}