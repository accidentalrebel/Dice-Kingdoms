package layers;
import flash.Lib;
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
	var finalResultLeft:FlxText;
	var finalResultRight:FlxText;
	var dieResultListLeft:Array<FlxText>;
	var dieResultListRight:Array<FlxText>;
	var bgWidth:Int;
	var bgHeight:Int;
	
	var padding:Float = 100;	
	var bottomPadding : Float = 5;
	var dieResultHeight : Int = 15;
	var finalResultHeight : Int = 30;
	var finalResultWidth : Int = 50;
	
	public function new() 
	{
		super();

		bgWidth = Lib.current.stage.stageWidth;
		bgHeight = 60;
		
		battleBackground = new FlxSprite(0, 0);
		battleBackground = battleBackground.makeGraphic(bgWidth, bgHeight, 0xff000000 );
		battleBackground.alpha = 0.5;
		add(battleBackground);
		
		battleResult = new FlxText(0, 0, Std.int(battleBackground.width), "");
		battleResult.alignment = "center";
		battleResult.scale = new FlxPoint(2, 2);
		add(battleResult);
		
		// We setup the final result FlxTexts
		finalResultLeft = new FlxText(0, battleBackground.y + battleBackground.height / 2 - finalResultHeight / 2 - bottomPadding
			, finalResultWidth, "88", finalResultHeight);
		add(finalResultLeft);
		
		finalResultRight = new FlxText(bgWidth - finalResultWidth
			, battleBackground.y + battleBackground.height / 2 - finalResultHeight / 2 - bottomPadding
			, finalResultWidth, "88", finalResultHeight);
		add(finalResultRight);
		
		// We setup the dieResults
		dieResultListLeft = new Array<FlxText>();
		for ( i in 0...10 )
		{
			var dieResult : FlxText = new FlxText(finalResultLeft.x + finalResultLeft.width + (i * 25)
				, battleBackground.y + battleBackground.height / 2 - dieResultHeight / 2 - bottomPadding + 5
				, 100, "0", dieResultHeight);
			dieResult.visible = false;
			add(dieResult);
			dieResultListLeft.push(dieResult);
		}
		
		dieResultListRight = new Array<FlxText>();
		for ( i in 0...10 )
		{
			var dieResult : FlxText = new FlxText(finalResultRight.x - finalResultRight.width / 2 - (i * 25)
				, battleBackground.y + battleBackground.height / 2 - dieResultHeight / 2 - bottomPadding + 5
				, 100, "0", dieResultHeight);
			dieResult.visible = false;
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
	
	function resetDieResultTexts()
	{
		function reset(dieResultList : Array<FlxText>)
		{
			for ( tDieResult in dieResultList )
			{
				var dieResult : FlxText = tDieResult;
				dieResult.visible = false;
			}
		}
		
		reset(dieResultListLeft);
		reset(dieResultListRight);
	}
	
	public function updateElements(attackerRoll:Int, attackerDiceResults:Array<Int>, defenderRoll:Int, defenderDiceResults:Array<Int>)
	{
		resetDieResultTexts();
		
		finalResultLeft.text = Std.string(attackerRoll);
		finalResultRight.text = Std.string(defenderRoll);
		
		for ( i in 0...attackerDiceResults.length )
		{
			var dieResultText : FlxText = dieResultListLeft[i];
			if ( attackerDiceResults[i] != 0 )
			{
				dieResultText.text = Std.string(attackerDiceResults[i]);
				dieResultText.visible = true;
			}
		}
		
		for ( i in 0...defenderDiceResults.length )
		{
			var dieResultText : FlxText = dieResultListRight[i];
			if ( defenderDiceResults[i] != 0 )
			{
				dieResultText.text = Std.string(defenderDiceResults[i]);
				dieResultText.visible = true;
			}
		}
	}
}