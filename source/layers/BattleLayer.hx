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
	//TODO: Use dice instead of just numbers
	//TODO: Add a main base graphic on the main base
	//TODO: Add an army refill section with animations
	inline static var DIE_PADDING : Int = 50;
 	
	var battleBackground:FlxSprite;
	var battleResult:FlxText;
	var finalResultLeft:FlxText;
	var finalResultRight:FlxText;
	var dieResultListLeft:Array<FlxSprite>;
	var dieResultListRight:Array<FlxSprite>;
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
		finalResultLeft = new FlxText(5, battleBackground.y + battleBackground.height / 2 - finalResultHeight / 2 - bottomPadding
			, finalResultWidth, "88", finalResultHeight);
		add(finalResultLeft);
		
		finalResultRight = new FlxText(bgWidth - finalResultWidth
			, battleBackground.y + battleBackground.height / 2 - finalResultHeight / 2 - bottomPadding
			, finalResultWidth, "88", finalResultHeight);
		add(finalResultRight);
		
		// We setup the dieResults
		dieResultListLeft = new Array<FlxSprite>();
		for ( i in 0...10 )
		{
			var die : FlxSprite = new FlxSprite(finalResultLeft.x + finalResultLeft.width + (i * DIE_PADDING), 10);
			die.loadGraphic("assets/dice.png", false, false, 40, 40, true);
			die.visible = false;
			add(die);
		
			dieResultListLeft.push(die);
		}
		
		dieResultListRight = new Array<FlxSprite>();
		for ( i in 0...10 )
		{
			var die : FlxSprite = new FlxSprite(finalResultRight.x - finalResultRight.width - (i * DIE_PADDING), 10);
			die.loadGraphic("assets/dice.png", false, false, 40, 40, true);
			die.visible = false;
			add(die);
			
			dieResultListRight.push(die);
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
		function reset(dieResultList : Array<FlxSprite>)
		{
			for ( tDie in dieResultList )
			{
				var die : FlxSprite = tDie;
				die.visible = false;
			}
		}
		
		reset(dieResultListLeft);
		reset(dieResultListRight);
	}
	
	public function updateElements(attackerRoll:Int, attackerDiceResults:Array<Int>
		, defenderRoll:Int, defenderDiceResults:Array<Int>, attackerColor : Int, defenderColor : Int)
	{
		resetDieResultTexts();
		
		finalResultLeft.text = Std.string(attackerRoll);
		finalResultRight.text = Std.string(defenderRoll);
		
		for ( i in 0...attackerDiceResults.length )
		{
			var dieResult : FlxSprite = dieResultListLeft[i];
			if ( attackerDiceResults[i] != 0 )
			{
				dieResult.animation.frameIndex = attackerDiceResults[i] - 1;
				dieResult.replaceColor(0xFFFF00FF, attackerColor + 0xFF000000);
				//dieResult.color = attackerColor;
				dieResult.visible = true;
			}
		}
		
		for ( i in 0...defenderDiceResults.length )
		{
			var dieResult : FlxSprite = dieResultListRight[i];
			if ( defenderDiceResults[i] != 0 )
			{
				dieResult.animation.frameIndex = defenderDiceResults[i] - 1;
				dieResult.replaceColor(0xFFFF00FF, defenderColor + 0xFF000000);
				//dieResult.color = defenderColor;
				dieResult.visible = true;
			}
		}
	}
}