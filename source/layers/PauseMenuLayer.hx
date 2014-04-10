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
	inline private static var VERTICAL_SPACING : Float = 20;
	
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
			background.makeGraphic(Std.int(MainStage.cameraWidth), Std.int(MainStage.cameraHeight), 0xCC000000);
			
			this.add(background);
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
				, GameState.gameplayManager.endGame, null, "End Game", 200, 50);
			mainMenuButton.setPosition(MainStage.cameraWidth / 2 - mainMenuButton.width / 2
				, MainStage.adjustedHeight - mainMenuButton.height * 2 - 50);
			this.add(mainMenuButton);
			
			var resumeGameButton : CustomButton = new CustomButton(0, 0
				, GameState.gameplayManager.resumeGame, null, "Resume Game", 200, 50);
			resumeGameButton.setPosition(MainStage.cameraWidth / 2 - resumeGameButton.width / 2
				, mainMenuButton.y - resumeGameButton.height / 2 - 50);
			this.add(resumeGameButton);
		}
		
		super();
		
		setupBackground();
		setupHighlighter();
		setupPlayerList();
		setupButtons();

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
			
			var playerRow : PlayerRow = new PlayerRow(playerListGroup, 0, i * (30 + VERTICAL_SPACING), Std.string(i+1), player.territoryColor, playerType, Std.string(player.territories.length));
			playerList.push(playerRow);
			i++;
		}
		
		this.scrollFactor = new FlxPoint();
		playerListGroup.scrollFactor = new FlxPoint();
		
		this.setAll("cameras", [ GameState.cameraManager.mainCamera], true);
		playerListGroup.setAll("cameras", [ GameState.cameraManager.mainCamera], true);
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