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
	public var numOfPlayers:Int = 8;
	public var numOfHumans:Int = 1;
	public var playerList:Array<Player>;
	public var currentPlayerNumber : Int = 1;
	public var currentPlayer : Player;
	
	public function new(tNumOfPlayers : Int = 8, tNumOfHumans : Int = 1) 
	{
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
	
	public function getPlayer(playerNum : Int) 
	{
		return playerList[playerNum-1];
	}
	
	public function initializeArmies() 
	{
		for ( tPlayer in playerList )
		{
			var player : Player = tPlayer;
			player.randomlyAssignArmies(Registry.initialArmyCount - Registry.territoryPerPlayer);			
		}
	}
	
	public function nextPlayer() 
	{
		//TODO: Skip current player if he has no more army
		//TODO: End game if only one player remains
		
		// We then increase our playerNumber
		currentPlayerNumber += 1;
		if ( currentPlayerNumber >= numOfPlayers )
			currentPlayerNumber = 1;			
		
		// We then set the current player
		setCurrentPlayer(currentPlayerNumber);
		
		// We then determine if AI would take over
		if ( !currentPlayer.isHuman )
			currentPlayer.ai.startPlanning();
	}
	
	private function setCurrentPlayer(playerNumber:Int) 
	{
		currentPlayerNumber = playerNumber;
		currentPlayer = getPlayer(currentPlayerNumber);
		Registry.gameGUI.playerIndicator.color = getPlayer(currentPlayerNumber).territoryColor;
	}
}