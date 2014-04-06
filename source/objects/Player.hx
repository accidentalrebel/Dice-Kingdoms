package objects;
import ai.EnemyAI;
import flixel.util.FlxRandom;
import managers.PlayerManager;
import managers.TerritoryManager;
import misc.PlayerColor;
import states.GameState;
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
	public var hasLost:Bool = false;

	public function new(playerNum : Int, territoryColor : Int ) 
	{
		this.playerNum = playerNum;
		
		this.territoryColor = territoryColor;
		this.territories = new Array<Int>();
		
		this.ai = new EnemyAI(this);
	}
	
	public function setAsHuman()
	{
		this.isHuman = true;
		
		this.ai.destroy();
		this.ai = null;
	}
	
	public function randomlyAssignArmies(maxArmyCount) 
	{
		var territoryListCopy : Array<Int> = Tools.hardCopyArray(territories);
		var increaseList : Array<Int> = new Array<Int>();
		
		while ( maxArmyCount > 0 && territoryListCopy.length > 0)
		{
			var roll : Int = FlxRandom.intRanged(0, territoryListCopy.length -1);
			var territoryNum : Int = territoryListCopy[roll];
			var territory : Territory = GameState.territoryManager.getTerritory(territoryNum);
			
			// We check if we can allocate an army to this territory
			if ( territory.canIncreaseArmyCount() )
			{
				increaseList[territoryNum]++;		// We increase the count for this territory
				maxArmyCount--;						// We reduce the max army count because we already allocated it
			}
			// If we can't, let's remove it from our list
			else
				territoryListCopy.remove(territoryNum);
		}
		
		// We then do the actual army increasing
		for ( territoryNum in 0...increaseList.length )
		{
			var increaseCount : Int = increaseList[territoryNum];
			if ( increaseCount <= 0 )
				continue;
				
			var territory : Territory = GameState.territoryManager.getTerritory(territoryNum);
			territory.increaseArmyCount(increaseCount);
		}
	}
	
	public function checkIfLost() 
	{		
		if ( territories.length <= 0 )
			hasLost = true;
	}
}