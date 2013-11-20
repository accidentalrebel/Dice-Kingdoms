package layers;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.util.FlxPoint;

/**
 * ...
 * @author Karlo
 */
class BattleLayer extends FlxGroup
{
	var battleBackground:FlxSprite;
	var battleResult:FlxText;
	var finalResultLeft:FlxText;
	var finalResultRight:FlxText;
	var dieResultListLeft:Array<FlxText>;
	var dieResultListRight:Array<FlxText>;
	
	public function new() 
	{
		var bottomPadding : Float = 5;
		var dieResultHeight : Int = 20;
		var padding : Float = 100;
		var finalResultHeight : Int = 50;
		var finalResultWidth : Int = 90;
		
		super();

		var bgWidth : Int = Std.int(FlxG.camera.width);
		var bgHeight : Int = 60;
		
		battleBackground = new FlxSprite(0, FlxG.camera.height - bgHeight);
		battleBackground = battleBackground.makeGraphic(bgWidth, bgHeight, 0xff000000 );
		battleBackground.alpha = 0.5;
		add(battleBackground);
		
		battleResult = new FlxText(padding, battleBackground.y + battleBackground.height / 2 - 10
			, Std.int(battleBackground.width - padding * 2), "");
		battleResult.alignment = "center";
		battleResult.scale = new FlxPoint(2, 2);
		add(battleResult);
		
		// We setup the final result FlxTexts
		finalResultLeft = new FlxText(10
			, battleBackground.y + battleBackground.height / 2 - finalResultHeight / 2 - bottomPadding
			, finalResultWidth, "88", finalResultHeight);
		add(finalResultLeft);
		
		finalResultRight = new FlxText(FlxG.width - finalResultWidth
			, battleBackground.y + battleBackground.height / 2 - finalResultHeight / 2 - bottomPadding
			, finalResultWidth, "88", finalResultHeight);
		add(finalResultRight);
		
		// We setup the dieResults
		dieResultListLeft = new Array<FlxText>();
		for ( i in 0...10 )
		{
			var dieResult : FlxText = new FlxText(finalResultLeft.x + finalResultLeft.width + (i * 25)
				, battleBackground.y + battleBackground.height / 2 - dieResultHeight / 2 - bottomPadding + 5
				, 100, "6", dieResultHeight);
			add(dieResult);
			dieResultListLeft.push(dieResult);
		}
		
		dieResultListRight = new Array<FlxText>();
		for ( i in 0...10 )
		{
			var dieResult : FlxText = new FlxText(finalResultRight.x - finalResultRight.width / 2 + 10 - (i * 25)
				, battleBackground.y + battleBackground.height / 2 - dieResultHeight / 2 - bottomPadding + 5
				, 100, "6", dieResultHeight);
			add(dieResult);
			dieResultListRight.push(dieResult);
		}
		
		//hide();
		this.setAll("scrollFactor", new FlxPoint(0, 0));
	}
	
	public function updateTexts(battleResultText : String)
	{
		battleResult.text = battleResultText;
	}
	
	public function updateElements()
	{
		
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