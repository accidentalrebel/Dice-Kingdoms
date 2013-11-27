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
		var increaseList : Array<Int> = new Array<Int>();
		
		while ( maxArmyCount > 0 && territoryListCopy.length > 0)
		{
			var roll : Int = Std.random(territoryListCopy.length);
			var territoryNum : Int = territoryListCopy[roll];
			var territory : Territory = Registry.territoryManager.getTerritory(territoryNum);
			
			// We check if we can allocate an army to this territory
			if ( territory.canIncreaseArmyCount() )
			{
				increaseList[territoryNum]++;		// We increase the count for this territory
				maxArmyCount--;						// We reduce the max army count because we already allocated it
			}
			// If we can't, let's remove it from our list
			else
				//TODO: Check if the orinal territories array is being edited as well
				territoryListCopy.remove(territoryNum);
		}
		
		// We then do the actual army increasing
		for ( territoryNum in 0...increaseList.length )
		{
			var increaseCount : Int = increaseList[territoryNum];
			if ( increaseCount <= 0 )
				continue;
				
			var territory : Territory = Registry.territoryManager.getTerritory(territoryNum);
			territory.increaseArmyCount(increaseCount);
		}
	}
}