package managers;
import flash.Lib;
import flixel.util.FlxArrayUtil;
import flixel.util.FlxMath;
import flixel.util.FlxRandom;
import haxe.Log;
import misc.PlayerColor;
import objects.Player;
import states.GameState;

/**
 * ...
 * @author 
 */
class PlayerManager
{
	var humanPlayer:Player;
	public static inline var MAX_NUM_OF_PLAYERS : Int = 7;
	
	public var numOfPlayers:Int = MAX_NUM_OF_PLAYERS;
	public var numOfHumans:Int = 1;
	public var playerSequence : Array<Int>;
	public var playerList:Array<Player>;
	public var currentPlayer : Player;
	
	private var currentPlayerIndex : Int = 0;
	
	public function new(tNumOfPlayers : Int = 8, tNumOfHumans : Int = 1) 
	{
		tNumOfPlayers = Std.int(FlxMath.bound(tNumOfPlayers, 1, MAX_NUM_OF_PLAYERS));
		tNumOfHumans = Std.int(FlxMath.bound(tNumOfHumans, 0, MAX_NUM_OF_PLAYERS));
		
		numOfPlayers = tNumOfPlayers;
		numOfHumans = tNumOfHumans;
		playerList = new Array<Player>();
		
		for ( i in 1...(numOfPlayers+1) )
		{
			var player : Player = new Player(i, PlayerColor.colorList[i - 1]);
			playerList.push(player);
		}
		
		humanPlayer = getPlayer(1);
		humanPlayer.setAsHuman();
		
		setupPlayerSequence();
		moveHumanPlayerAtPosition(null);
		GameState.playerManager = this;
		setCurrentPlayer(0);
	}
	
	function setupPlayerSequence() 
	{
		playerSequence = new Array<Int>();
		for ( i in 1...numOfPlayers+1 )
			playerSequence.push(i);
	}
	
	public function moveHumanPlayerAtPosition(index : Null<Int>)
	{
		//playerList.remove(humanPlayer);
		//FlxArrayUtil.shuffle(playerList, 2);
		//
		//if ( index == null ) 
			//index = FlxRandom.intRanged(0, playerList.length - 1);
		//
		//playerList.insert(index, humanPlayer);
	}
	
	public function getPlayer(playerNum : Int) : Player
	{
		return playerList[playerNum-1];
	}
	
	public function getRandomPlayer() : Player
	{
		return FlxArrayUtil.getRandom(playerList);
	}
	
	public function initializeArmies() 
	{
		for ( tPlayer in playerList )
		{
			var player : Player = tPlayer;
			player.randomlyAssignArmies(GameState.initialArmyCount * GameState.territoryPerPlayer);			
		}
	}
	
	public function nextPlayer() 
	{
		currentPlayerIndex += 1;
		
		if ( currentPlayerIndex > numOfPlayers )
			currentPlayerIndex = 1;			
		
		setCurrentPlayer(currentPlayerIndex);
		
		if ( currentPlayer.hasLost )
			nextPlayer();
		
		if ( !currentPlayer.isHuman )
			currentPlayer.ai.startPlanning();
	}
	
	public function setCurrentPlayer(playerIndex:Int) 
	{
		currentPlayer = getPlayer(playerSequence[playerIndex]);
		trace("currentPlayer is " + currentPlayer.playerNum + " " + Std.string(currentPlayer.territoryColor));
		GameState.gameGUI.updatePlayerIndicator();
	}
	
	public function reset()
	{
		for ( tPlayer in playerList )
		{
			var player : Player = tPlayer;
			player.destroy();
			playerList.remove(player);
		}
		
		playerList = [];
	}
}