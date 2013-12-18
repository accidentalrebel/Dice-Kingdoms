package layers;
import flash.display.Sprite;
import flixel.FlxG;
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
	//TODO: Add column labels
	inline public static var PAUSE_MENU_WIDTH : Float = 400;
	inline public static var PAUSE_MENU_HEIGHT : Float = 400;
	
	private var playerList : Array<PlayerRow>;
	var background:FlxSprite;
	var highlighterSprite:FlxSprite;
	
	public function new() 
	{
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
				playerList.push(playerRow);
				i++;
			}
			
			hightlightPlayerRow(0);
		}
		
		function setupHighlighter()
		{
			highlighterSprite = new FlxSprite(0, 0);
			highlighterSprite.makeGraphic(PAUSE_MENU_WIDTH, Std.int(PlayerRow.FONT_SIZE * 1.5), 0x55FFFFFF);
			
			this.add(highlighterSprite);
		}
		
		super();
		
		setupBackground();
		setupHighlighter();
		setupPlayerList();
		
		this.setPosition(FlxG.width / 2 - PAUSE_MENU_WIDTH / 2, 0);
		this.scrollFactor = new FlxPoint(0, 0);
		this.setAll("cameras", [ PlayState.cameraManager.mainCamera], true);
		
		hide();
	}
	
	function hightlightPlayerRow(rowNumber : Int)
	{
		highlighterSprite.y = playerList[rowNumber].positionLabel.y;
		//TODO: Mark those who are dead as dead
		//TODO: Only do the updating when the pause menu is shown
	}
	
	public function show()
	{
		function setTerritoryCount(playerNumber : Int, territoryCount : Int)
		{
			playerList[playerNumber-1].setTerritoryCountTo(Std.string(territoryCount));
		}
		
		this.visible = true;
		
		// We go through each player and update its territory count
		var i : Int = 1;
		for ( tPlayerRow in playerList )
		{
			var playerRow : PlayerRow = tPlayerRow;
			var player : Player = PlayState.playerManager.getPlayer(i);
			setTerritoryCount(i, player.territories.length);
			i++;
		}
		
		// We then highlight the current player
		hightlightPlayerRow(PlayState.playerManager.currentPlayerNumber - 1);
	}
	
	public function hide()
	{	
		this.visible = false;
		PlayState.gameplayManager.resumeGame();
	}
	
	public function toggleStatus() 
	{
		if ( this.visible )
			hide();
		else
			show();
	}
}