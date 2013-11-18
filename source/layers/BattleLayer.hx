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
	var battleBackground:FlxSprite;
	var battleResult:FlxText;
	
	public function new() 
	{
		super();

		var bgWidth : Int = Std.int(FlxG.camera.width);
		var bgHeight : Int = 200;
		
		battleBackground = new FlxSprite(0, FlxG.camera.height / 2 - bgHeight / 2);
		battleBackground = battleBackground.makeGraphic(bgWidth, bgHeight, 0xff000000 );
		battleBackground.alpha = 0.5;
		add(battleBackground);
		
		battleResult = new FlxText(100, battleBackground.y + battleBackground.height / 2
			, Std.int(battleBackground.width - 200), "Test");
		battleResult.alignment = "center";
		battleResult.scale = new FlxPoint(2, 2);
		add(battleResult);
		
		//hide();
		this.setAll("scrollFactor", new FlxPoint(0, 0));
	}
	
	public function show(battleResultText : String)
	{
		battleBackground.visible = true;
		battleResult.visible = true;
		battleResult.text = battleResultText;
	}
	
	public function hide()
	{
		battleBackground.visible = false;
		battleResult.visible = false;
	}
}