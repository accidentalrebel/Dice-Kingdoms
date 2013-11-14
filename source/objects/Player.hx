package objects;
import ai.EnemyAI;
import managers.PlayerManager;
import managers.TerritoryManager;
import tools.Tools;

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
	public var playerNum:Int;

	public function new(playerNum : Int, isHuman : Bool ) 
	{
		this.playerNum = playerNum;
		this.isHuman = isHuman;
		
		if ( !this.isHuman )
			this.ai = new EnemyAI(this);
		
		this.territoryColor = Registry.colorList[playerNum-1];
		this.territories = new Array<Int>();
	}
	
	public function randomlyAssignArmies(maxArmyCount) 
	{
		var territoryListCopy : Array<Int> = Tools.hardCopyArray(territories);
		
		// TODO: Change this so that only territories that are valid are left
		for ( i in 0...maxArmyCount-1 )
		{
			var roll : Int = Std.random(territoryListCopy.length);
			var territoryNum : Int = territories[roll];
			var territory : Territory = TerritoryManager.getTerritory(territoryNum);
			
			//if ( territory.increaseArmyCount() )
				//i--;		// Increase army was not successful
		}
	}
}