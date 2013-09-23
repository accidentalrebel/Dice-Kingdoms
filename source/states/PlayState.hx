package states;
import managers.GameplayManager;
import managers.InputManager;
import managers.PlayerManager;
import org.flixel.FlxButton;
import org.flixel.FlxG;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.util.FlxMath;
import playArea.PlayArea;

/**
 * ...
 * @author Karlo
 */
class PlayState extends FlxState
{
	override public function create():Void 
	{
		FlxG.bgColor = 0xFF435169;
		
		super.create();
		
		var inputManager : InputManager = new InputManager();
		add(inputManager);
		
		Registry.playerIndicator = new FlxText(5, 5, 100, "Player 1", 16);
		add(Registry.playerIndicator);
		var doneButton : FlxButton = new FlxButton(5, 26, "DONE",GameplayManager.nextPlayer);		
		add(doneButton);
		
		//TODO: Add to a playArea FlxGroup
		PlayArea.init(this);
		PlayArea.setupTerritories();	
		PlayerManager.init(8);
		PlayArea.assignTerritories();
		PlayerManager.initializeArmies();
	}
}