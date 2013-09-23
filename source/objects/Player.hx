package objects;
import managers.PlayerManager;
import managers.TerritoryManager;

/**
 * ...
 * @author 
 */
class Player
{
	public var territories:Array<Int>;
	public var territoryColor:Int;
	var playerNum:Int;

	public function new(playerNum : Int) 
	{
		this.playerNum = playerNum;
		this.territoryColor = Registry.colorList[playerNum-1];
		this.territories = new Array<Int>();
	}
	
	public function randomlyAssignArmies(maxArmyCount) 
	{
		for ( i in 0...maxArmyCount-1 )
		{
			var roll : Int = Std.random(territories.length);
			var territoryNum : Int = territories[roll];
			var territory : Territory = TerritoryManager.getTerritory(territoryNum);
			territory.increaseArmyCount();
		}
	}
}