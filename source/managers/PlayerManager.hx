package managers;
import flash.Lib;
import haxe.Log;
import objects.Player;

/**
 * ...
 * @author 
 */
class PlayerManager
{
	static public var numOfPlayers:Int = 8;
	static public var numOfHumans:Int = 1;
	static public var playerList:Array<Player>;
	static public var currentPlayerNumber : Int = 1;
	
	static public function init(tNumOfPlayers : Int, tNumOfHumans : Int) 
	{
		numOfPlayers = tNumOfPlayers;
		numOfHumans = tNumOfHumans;
		playerList = new Array<Player>();
		
		var isHuman : Bool = true;
		for ( i in 1...(numOfPlayers+1) )
		{
			tNumOfHumans--;
			if ( tNumOfHumans <= 0 )
				isHuman = false;
			else
				isHuman = true;
			
			var player : Player = new Player(i, isHuman);
			playerList.push(player);
		}
		
		setCurrentPlayer(1);
	}
	
	static public function getPlayer(playerNum : Int) 
	{
		return playerList[playerNum-1];
	}
	
	static public function initializeArmies() 
	{
		for ( tPlayer in playerList )
		{
			var player : Player = tPlayer;
			player.randomlyAssignArmies(Registry.initialArmyCount - Registry.territoryPerPlayer);			
		}
	}
	
	static public function nextPlayer() 
	{
		// We add armies according to the number of territories		
		var currentPlayer : Player = getPlayer(currentPlayerNumber);
		currentPlayer.randomlyAssignArmies(currentPlayer.territories.length);
		
		// We then increase our playerNumber
		currentPlayerNumber += 1;
		if ( currentPlayerNumber >= numOfPlayers )
			currentPlayerNumber = 1;			
		
		// We then set the current player
		setCurrentPlayer(currentPlayerNumber);
		
		// We then determine if AI would take over
		if ( !currentPlayer.isHuman )
			trace("AI Takes over");
	}
	
	static private function setCurrentPlayer(playerNumber:Int) 
	{
		currentPlayerNumber = playerNumber;
		Registry.playerIndicator.color = getPlayer(currentPlayerNumber).territoryColor;
	}
}