package layers;
import flash.display.Sprite;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.ui.FlxButton;
import flixel.util.FlxPoint;
import misc.PlayerRow;
import objects.Player;
import states.GameState;
import ui.CustomButton;

/**
 * ...
 * @author Karlo
 */
class PauseMenuLayer extends FlxSpriteGroup
{	
	//TODO: Add column labels
	inline public static var PAUSE_MENU_WIDTH : Float = 400;
	inline public static var PAUSE_MENU_HEIGHT : Float = 400;
	
	public var playerListGroup : FlxSpriteGroup;
	
	private var playerList : Array<PlayerRow>;
	var background:FlxSprite;
	var highlighterSprite:FlxSprite;
	
	public function new(parentToAddTo : FlxState) 
	{
		//TODO: Override the back function for Android
		playerListGroup = new FlxSpriteGroup(MainStage.cameraWidth / 2 - PAUSE_MENU_WIDTH / 2, 0);
		
		function setupBackground() 
		{
			background = new FlxSprite(0, 0);
			background.makeGraphic(PAUSE_MENU_WIDTH, PAUSE_MENU_HEIGHT, 0xCC000000);
			
			playerListGroup.add(background);
		}
		
		function setupHighlighter()
		{
			highlighterSprite = new FlxSprite(0, 0);
			highlighterSprite.makeGraphic(PAUSE_MENU_WIDTH, Std.int(PlayerRow.FONT_SIZE * 1.5), 0x55FFFFFF);
			
			playerListGroup.add(highlighterSprite);
		}
		
		function setupButtons()
		{	
			var mainMenuButton : CustomButton = new CustomButton(0, 0
				, GameState.gameplayManager.endGame, null, "MainMenu", 200, 70);
			mainMenuButton.setPosition(MainStage.cameraWidth / 2 + 10, MainStage.cameraHeight - 130);
			mainMenuButton.pauseProof = true;
			this.add(mainMenuButton);
		}
		
		super();
		
		setupBackground();
		setupHighlighter();
		setupPlayerList();
		setupButtons();
		
		this.scrollFactor = new FlxPoint();
		playerListGroup.scrollFactor = new FlxPoint();
		
		this.setAll("cameras", [ GameState.cameraManager.mainCamera], true);
		playerListGroup.setAll("cameras", [ GameState.cameraManager.mainCamera], true);
		
		hide();
	}
	
	public function updatePlayerList()
	{
		destroyPlayerList();
		setupPlayerList();
	}
	
	function setupPlayerList() : Void
	{
		playerList = new Array<PlayerRow>();
		
		var i : Int = 0;
		for ( tPlayer in GameState.playerManager.playerList )
		{
			var player : Player = tPlayer;
			var playerType : String = "";
			if ( player.isHuman )
				playerType = "HUMAN";
			else
				playerType = Std.string(player.ai.aiType);
			
			var playerRow : PlayerRow = new PlayerRow(playerListGroup, 40, i * 30 + 30, Std.string(i+1), player.territoryColor, playerType, Std.string(player.territories.length));
			playerList.push(playerRow);
			i++;
		}
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
		playerListGroup.visible = true;
		
		// We go through each player and update its territory count
		var i : Int = 1;
		for ( tPlayerRow in playerList )
		{
			var playerRow : PlayerRow = tPlayerRow;
			var player : Player = GameState.playerManager.getPlayer(i);
			setTerritoryCount(i, player.territories.length);
			i++;
		}
		
		// We then highlight the current player
		hightlightPlayerRow(GameState.playerManager.currentPlayerNumber - 1);
	}
	
	public function hide()
	{	
		this.visible = false;
		playerListGroup.visible = false;
		GameState.gameplayManager.resumeGame();
	}
	
	public function toggleStatus() 
	{
		if ( this.visible )
			hide();
		else
			show();
	}
	
	override public function destroy():Void 
	{
		destroyPlayerList();
		super.destroy();
	}
	
	private function destroyPlayerList()
	{
		for ( tPlayerRow in playerList )
		{
			var playerRow : PlayerRow = tPlayerRow;
			playerRow.destroy();
		}
	}
}