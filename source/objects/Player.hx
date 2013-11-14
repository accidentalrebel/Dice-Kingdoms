package objects;
import ai.EnemyAI;
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
	public var isHuman:Bool = false;
	public var ai:EnemyAI;
	
	var playerNum:Int;

	public function new(playerNum : Int, isHuman : Bool ) 
	{
		this.playerNum = playerNum;
		this.isHuman = isHuman;
		
		if ( !this.isHuman )
			this.ai = new EnemyAI();
		
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