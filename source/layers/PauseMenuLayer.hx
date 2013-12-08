package layers;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.ui.FlxButton;
import misc.PlayerRow;
import objects.Player;
import states.PlayState;

/**
 * ...
 * @author Karlo
 */
class PauseMenuLayer extends FlxGroup
{
	inline public static var PAUSE_MENU_WIDTH : Float = 200;
	inline public static var PAUSE_MENU_HEIGHT : Float = 200;
	private var playerList : Array<PlayerRow>;
	
	public function new() 
	{
		super();
		
		setupPlayerList();
	}
	
	function setupPlayerList() : Void
	{
		playerList = new Array<PlayerRow>();
		
		var i : Int = 0;
		for ( tPlayer in PlayState.playerManager.playerList )
		{
			var player : Player = tPlayer;
			var playerRow : PlayerRow = new PlayerRow(100, i * 30);
			add(playerRow);
			i++;
		}
	}
}