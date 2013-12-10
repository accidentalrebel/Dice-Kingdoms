package layers;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.ui.FlxButton;
import flixel.util.FlxPoint;
import misc.PlayerRow;
import objects.Player;
import states.PlayState;

/**
 * ...
 * @author Karlo
 */
class PauseMenuLayer extends FlxSpriteGroup
{
	inline public static var PAUSE_MENU_WIDTH : Float = 200;
	inline public static var PAUSE_MENU_HEIGHT : Float = 200;
	private var playerList : Array<PlayerRow>;
	
	public function new() 
	{
		super();
		
		setupPlayerList();
		
		this.setPosition(200, 0);
		this.scrollFactor = new FlxPoint(0, 0);
		this.setAll("cameras", [ PlayState.cameraManager.mainCamera], true);
	}
	
	function setupPlayerList() : Void
	{
		playerList = new Array<PlayerRow>();
		
		var i : Int = 0;
		for ( tPlayer in PlayState.playerManager.playerList )
		{
			var player : Player = tPlayer;
			var playerName : String = "";
			var aiType : String = "";
			if ( player.isHuman )
			{
				playerName = "Human";
				aiType = "None";
			}
			else
			{
				playerName = "CPU";
				aiType = Std.string(player.ai.aiType);
			}
			
			var playerRow : PlayerRow = new PlayerRow(this, 0, i * 30, Std.string(i+1), playerName, aiType, Std.string(player.territories.length));
			i++;
		}
	}
}