package layers;
import flixel.addons.plugin.taskManager.AntTaskManager;
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
		var bgHeight : Int = 60;
		
		battleBackground = new FlxSprite(0, FlxG.camera.height - bgHeight);
		battleBackground = battleBackground.makeGraphic(bgWidth, bgHeight, 0xff000000 );
		battleBackground.alpha = 0.5;
		add(battleBackground);
		
		var padding : Float = 100;
		battleResult = new FlxText(padding, battleBackground.y + battleBackground.height / 2 - 10
			, Std.int(battleBackground.width - padding * 2), "");
		battleResult.alignment = "center";
		battleResult.scale = new FlxPoint(2, 2);
		add(battleResult);
		
		//hide();
		this.setAll("scrollFactor", new FlxPoint(0, 0));
	}
	
	public function updateTexts(battleResultText : String)
	{
		battleResult.text = battleResultText;
	}
	
	//public function show(battleResultText : String)
	//{
		//var taskManager : AntTaskManager = new AntTaskManager(false, hide);
		//
		//battleBackground.visible = true;
		//battleResult.visible = true;
		//battleResult.text = battleResultText;
		//
		//taskManager.addPause(1);
	//}
	//
	//public function hide()
	//{
		//battleBackground.visible = false;
		//battleResult.visible = false;
	//}
}