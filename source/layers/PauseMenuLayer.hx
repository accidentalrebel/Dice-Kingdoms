package layers;
import flixel.FlxSprite;
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
	inline public static var PAUSE_MENU_WIDTH : Float = 400;
	inline public static var PAUSE_MENU_HEIGHT : Float = 400;
	
	private var playerList : Array<PlayerRow>;
	var background:FlxSprite;
	
	public function new() 
	{
		super();
		
		setupBackground();
		setupPlayerList();
		
		this.setPosition(200, 0);
		this.scrollFactor = new FlxPoint(0, 0);
		this.setAll("cameras", [ PlayState.cameraManager.mainCamera], true);
	}
	
	function setupBackground() 
	{
		background = new FlxSprite(0, 0);
		background.makeGraphic(PAUSE_MENU_WIDTH, PAUSE_MENU_HEIGHT, 0xCC000000);
		
		this.add(background);
	}
	
	function setupPlayerList() : Void
	{
		playerList = new Array<PlayerRow>();
		
		var i : Int = 0;
		for ( tPlayer in PlayState.playerManager.playerList )
		{
			var player : Player = tPlayer;
			var playerType : String = "";
			if ( player.isHuman )
				playerType = "HUMAN";
			else
				playerType = Std.string(player.ai.aiType);
			
			var playerRow : PlayerRow = new PlayerRow(this, 40, i * 30 + 30, Std.string(i+1), player.territoryColor, playerType, Std.string(player.territories.length));
			i++;
		}
	}
}