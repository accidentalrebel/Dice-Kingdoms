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
	var dieResultList:Array<FlxText>;
	var finalResult:FlxText;
	
	public function new() 
	{
		var bottomPadding : Float = 5;
		
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
		
		// We setup the final result
		var finalResultHeight : Int = 50;
		finalResult = new FlxText(10
			, battleBackground.y + battleBackground.height / 2 - finalResultHeight / 2 - bottomPadding
			, 90, "88", finalResultHeight);
		add(finalResult);
		
		// We setup the dieResults
		var dieResultHeight : Int = 20;
		dieResultList = new Array<FlxText>();
		for ( i in 0...10 )
		{
			var dieResult : FlxText = new FlxText(finalResult.x + finalResult.width + (i * 25)
				, battleBackground.y + battleBackground.height / 2 - dieResultHeight / 2 - bottomPadding + 5
				, 100, "8", dieResultHeight);
			add(dieResult);
			dieResultList.push(dieResult);
		}
		
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