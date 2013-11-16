package layers;
import flixel.FlxG;
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

		var bgWidth : Int = Std.int(FlxG.camera.width);
		var bgHeight : Int = 200;
		
		var battleBackground : FlxSprite = new FlxSprite(0, FlxG.camera.height / 2 - bgHeight / 2);
		battleBackground = battleBackground.makeGraphic(bgWidth, bgHeight, 0xff000000 );
		battleBackground.alpha = 0.5;
		add(battleBackground);
		
		var battleResult : FlxText = new FlxText(200, 200, 30, "Test");
		add(battleResult);
		
		this.setAll("scrollFactor", new FlxPoint(0, 0));
	}
}