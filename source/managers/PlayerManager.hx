package managers;
import flash.Lib;
import flixel.util.FlxArrayUtil;
import haxe.Log;
import misc.PlayerColor;
import objects.Player;
import states.PlayState;

/**
 * ...
 * @author 
 */
class PlayerManager
{
	public var numOfPlayers:Int = 8;
	public var numOfHumans:Int = 1;
	public var playerList:Array<Player>;
	public var currentPlayerNumber : Int = 1;
	public var currentPlayer : Player;
	
	public function new(tNumOfPlayers : Int = 8, tNumOfHumans : Int = 1) 
	{
		PlayerColor.shuffle();
		
		numOfPlayers = tNumOfPlayers;
		numOfHumans = tNumOfHumans;
		playerList = new Array<Player>();
		
		var isHuman : Bool = true;
		for ( i in 1...(numOfPlayers+1) )
		{
			if ( tNumOfHumans <= 0 )
				isHuman = false;
			else
				isHuman = true;
			
			var player : Player = new Player(i, isHuman);
			playerList.push(player);
			
			tNumOfHumans--;
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
			player.randomlyAssignArmies(PlayState.initialArmyCount - PlayState.territoryPerPlayer);			
		}
	}
	
	public function nextPlayer() 
	{
		//TODO: End game if only one player remains
		
		// We then increase our playerNumber
		currentPlayerNumber += 1;
		
		// We go back to th first player
		if ( currentPlayerNumber >= numOfPlayers )
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
		PlayState.gameGUI.playerIndicator.color = getPlayer(currentPlayerNumber).territoryColor;
	}
}