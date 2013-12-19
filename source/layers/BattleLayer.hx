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
	private static inline var PADDING_TOP : Float = 15;
	private static inline var PADDING_SIDES : Float = 5;
	
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

		//TODO: Really consider creating a MainStage.resizedWidth
		bgWidth = Std.int(MainStage.cameraWidth);
		bgHeight = 60;
		
		battleBackground = new FlxSprite(0, 0);
		battleBackground = battleBackground.makeGraphic(bgWidth, bgHeight, 0xff000000 );
		battleBackground.alpha = 0.5;
		add(battleBackground);
		
		battleResult = new FlxText(0, PADDING_TOP, Std.int(battleBackground.width), "");
		battleResult.alignment = "center";
		battleResult.scale = new FlxPoint(2, 2);
		add(battleResult);
		
		// We setup the final result FlxTexts
		finalResultLeft = new FlxText(PADDING_SIDES, battleBackground.y + battleBackground.height / 2 - finalResultHeight / 2 - bottomPadding
			, finalResultWidth, "88", finalResultHeight);
		finalResultLeft.alignment = "center";
		add(finalResultLeft);
		
		finalResultRight = new FlxText(bgWidth - finalResultWidth
			, battleBackground.y + battleBackground.height / 2 - finalResultHeight / 2 - bottomPadding
			, finalResultWidth, "88", finalResultHeight);
		finalResultRight.alignment = "center";
		add(finalResultRight);
		
		// We setup the dieResults
		dieResultListLeft = new Array<Die>();
		for ( i in 0...8 )
		{
			var die : Die = new Die(this, finalResultLeft.x + finalResultLeft.width + (i * DIE_PADDING), PADDING_TOP);
			dieResultListLeft.push(die);
		}
		
		dieResultListRight = new Array<Die>();
		for ( i in 0...8 )
		{
			var die : Die = new Die(this, finalResultRight.x - PADDING_SIDES - Die.DIE_DIMENSION - (i * DIE_PADDING), PADDING_TOP);
			dieResultListRight.push(die);
		}
		
		//hide();
		this.setAll("scrollFactor", new FlxPoint(0, 0));
	}
	
	/**
	 * Updates the battle result text
	 * @param	battleResultText	The text to display
	 */
	public function updateTexts(battleResultText : String)
	{
		battleResult.text = battleResultText;
	}
	
	/**
	 * Hides the battle results
	 */
	public function hideBattleResults()
	{
		finalResultLeft.visible = false;
		finalResultRight.visible = false;
	}
	
	/**
	 * Shows the battle results. Intended to be called after the roll animation of the dice.
	 * @param	attackerRoll			The attacker's total roll count
	 * @param	attackerDiceResults		The dice result list for the attacker
	 * @param	defenderRoll			The defender's total roll count
	 * @param	defenderDiceResults		The dice result list for the defender
	 */
	public function showBattleResults(attackerRoll:Int, attackerDiceResults:Array<Int>
		, defenderRoll:Int, defenderDiceResults:Array<Int>)
	{	
		//TODO: Consider having the computation for the attacker Roll here
		
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
	
	/**
	 * Runs a visual animation of the dice. 
	 * @param	diceForLeft		The number of dice to roll for the left dice list
	 * @param	colorForLeft	The color of the dice for the left dice list
	 * @param	diceForRight	The number of dice to roll for the right dice list
	 * @param	colorForRight	The color of the dice for the right dice list
	 */
	public function rollAllDice(diceForLeft : Int, colorForLeft : Int, diceForRight : Int, colorForRight : Int)
	{
		function rollDiceList(dieArray : Array<Die>, numToShow : Int, dieColor : Int)
		{
			var i : Int = 0;
			for ( tDie in dieArray )
			{
				var die : Die = tDie;	
				if ( i < numToShow )
				{
					die.updateDieColor(dieColor);
					die.rollAnimation(DIE_ROLL_DURATION);
				}
				else
					die.hide();
					
				i++;
			}
		}
		
		rollDiceList(dieResultListLeft, diceForLeft, colorForLeft);
		rollDiceList(dieResultListRight, diceForRight, colorForRight);
	}
}