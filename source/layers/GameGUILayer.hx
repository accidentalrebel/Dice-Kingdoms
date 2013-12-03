package layers;
import effects.AddArmyEffect;
import flixel.addons.ui.FlxButtonPlus;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxPoint;
import managers.CameraManager;
import managers.GameplayManager;
import objects.Player;
import states.PlayState;
import tools.ARFade;

/**
 * ...
 * @author Karlo
 */
class GameGUILayer extends FlxGroup
{
	private var playerIndicator : FlxText;
	
	public function new() 
	{
		super();
		
		var buttonHeight : Int = 60;
		
		playerIndicator = new FlxText(5, 5, 300, "Player 1", 16);
		add(playerIndicator);
		
		//TODO: Do not allow to be clicked multiple times
		
		var zoomButton : FlxButtonPlus = new FlxButtonPlus(5, Std.int(playerIndicator.height + 10), PlayState.cameraManager.toggleZoom, null, "TOGGLE ZOOM", 80, buttonHeight);		
		add(zoomButton);
		
		var doneButton : FlxButtonPlus = new FlxButtonPlus(5, Std.int(playerIndicator.height + buttonHeight + 40), PlayState.gameplayManager.endCurrentPlayerMove, null, "DONE", 80, buttonHeight);		
		add(doneButton);
		
		// Everything in this group does not move from the camera
		this.setAll("scrollFactor", new FlxPoint(0, 0));
	}
	
	public function spawnAddArmyEffect(xPos : Float = 0, yPos : Float = 0, amount : Int = 0 )
	{	
		var addEffect : AddArmyEffect = cast(this.recycle(AddArmyEffect), AddArmyEffect);
		addEffect.init(xPos, yPos, Std.string(amount));
	}
	
	public function updatePlayerIndicator(isHuman:Bool, colorToUse:Int) 
	{
		playerIndicator.color = colorToUse;
		
		if ( isHuman )
			playerIndicator.text = "Player's Turn";
		else
			playerIndicator.text = "CPU's Turn";
	}
}