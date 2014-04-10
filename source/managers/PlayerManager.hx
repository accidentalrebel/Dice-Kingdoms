package managers;
import flash.Lib;
import flixel.util.FlxArrayUtil;
import flixel.util.FlxMath;
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
	public static inline var MAX_NUM_OF_PLAYERS : Int = 7;
	
	public var numOfPlayers:Int = MAX_NUM_OF_PLAYERS;
	public var numOfHumans:Int = 1;
	public var playerList:Array<Player>;
	public var currentPlayerNumber : Int = 1;
	public var currentPlayer : Player;
	
	public function new(tNumOfPlayers : Int = 8, tNumOfHumans : Int = 1) 
	{
		tNumOfPlayers = Std.int(FlxMath.bound(tNumOfPlayers, 1, MAX_NUM_OF_PLAYERS));
		tNumOfHumans = Std.int(FlxMath.bound(tNumOfHumans, 0, MAX_NUM_OF_PLAYERS));
		
		PlayerColor.shuffle();
		
		numOfPlayers = tNumOfPlayers;
		numOfHumans = tNumOfHumans;
		playerList = new Array<Player>();
		
		// We create the players first
		for ( i in 1...(numOfPlayers+1) )
		{
			var player : Player = new Player(i, PlayerColor.colorList[i-1]);
			playerList.push(player);
		}
		
		if ( PreGameManager.currentOrder != null )
		{
			var currentOrder = PreGameManager.currentOrder;
			var humanPlayer : Player = playerList[currentOrder - 1];
			humanPlayer.setAsHuman();
		}
		else
		{
			// We then randomly assign which of the players is human
			var maxRetries : Int = 0;
			while ( tNumOfHumans > 0 || maxRetries > 100 )
			{
				var randomPlayer : Player = FlxArrayUtil.getRandom(playerList);
				if ( randomPlayer == null )
					break;
					
				if ( !randomPlayer.isHuman )
				{
					randomPlayer.setAsHuman();
					maxRetries = 0;
					tNumOfHumans--;
				}
				
				maxRetries++;
			}
		}
			
		
		setCurrentPlayer(1);
	}
	
	public function getPlayer(playerNum : Int) : Player
	{
		return playerList[playerNum-1];
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
		// We then increase our playerNumber
		currentPlayerNumber += 1;
		
		// We go back to th first player
		if ( currentPlayerNumber > numOfPlayers )
			currentPlayerNumber = 1;			
		
		// We then set the current player
		setCurrentPlayer(currentPlayerNumber);
		
		// If this player has lost, we go to the next player
		if ( currentPlayer.hasLost )
			nextPlayer();
		
		// We then determine if AI would take over
		if ( !currentPlayer.isHuman )
			currentPlayer.ai.startPlanning();
	}
	
	private function setCurrentPlayer(playerNumber:Int) 
	{
		currentPlayerNumber = playerNumber;
		currentPlayer = getPlayer(currentPlayerNumber);
		GameState.gameGUI.updatePlayerIndicator(currentPlayer.isHuman, getPlayer(currentPlayerNumber).territoryColor);
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