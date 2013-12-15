package layers;
import flash.Lib;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.util.FlxPoint;
import managers.CameraManager;
import objects.Die;
import tools.ARTaskManager;

/**
 * ...
 * @author Karlo
 */
class BattleLayer extends FlxGroup
{
	inline static var DIE_PADDING : Int = Die.DIE_DIMENSION + 5;
	
	//TODO: Remove this and have battleManager pass in the dieRollDuration
	private static inline var DIE_ROLL_DURATION : Float = 0.5;
 	
	var battleBackground:FlxSprite;
	var battleResult:FlxText;
	var finalResultLeft:FlxText;
	var finalResultRight:FlxText;
	var dieResultListLeft:Array<Die>;
	var dieResultListRight:Array<Die>;
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
		dieResultListLeft = new Array<Die>();
		for ( i in 0...8 )
		{
			var die : Die = new Die(this, finalResultLeft.x + finalResultLeft.width + (i * DIE_PADDING), 15);
			dieResultListLeft.push(die);
		}
		
		dieResultListRight = new Array<Die>();
		for ( i in 0...8 )
		{
			var die : Die = new Die(this, finalResultRight.x - finalResultRight.width - (i * DIE_PADDING), 15);
			dieResultListRight.push(die);
		}
		
		//hide();
		this.setAll("scrollFactor", new FlxPoint(0, 0));
	}
	
	public function updateTexts(battleResultText : String)
	{
		battleResult.text = battleResultText;
	}
	
	public function hideBattleResults()
	{
		finalResultLeft.visible = false;
		finalResultRight.visible = false;
	}
	
	public function showBattleResults(attackerRoll:Int, attackerDiceResults:Array<Int>
		, defenderRoll:Int, defenderDiceResults:Array<Int>)
	{	
		finalResultLeft.visible = true;
		finalResultRight.visible = true;
		
		finalResultLeft.text = Std.string(attackerRoll);
		finalResultRight.text = Std.string(defenderRoll);
		
		for ( i in 0...attackerDiceResults.length )
		{
			var die : Die = dieResultListLeft[i];
			if ( attackerDiceResults[i] != 0 )
			{	
				die.updateDieFace(attackerDiceResults[i] - 1);
				die.show();
			}
		}
		
		for ( i in 0...defenderDiceResults.length )
		{
			var die : Die = dieResultListRight[i];
			if ( defenderDiceResults[i] != 0 )
			{
				die.updateDieFace(defenderDiceResults[i] - 1);
				die.show();
			}
		}
	}
	
	public function rollAllDice(diceForLeft : Int, colorForLeft : Int, diceForRight : Int, colorForRight : Int)
	{
		var i : Int = 0;
		for ( tDie in dieResultListLeft )
		{
			var die : Die = tDie;	
			if ( i < diceForLeft )
			{
				die.updateDieColor(colorForLeft);
				die.rollAnimation(DIE_ROLL_DURATION);
			}
			else
				die.hide();
				
			i++;
		}
		
		i = 0;
		for ( tDie in dieResultListRight )
		{
			var die : Die = tDie;
			if ( i < diceForRight )
			{
				die.updateDieColor(colorForRight);
				die.rollAnimation(DIE_ROLL_DURATION);
			}
			else
				die.hide();
			
			i++;
		}
	}
}