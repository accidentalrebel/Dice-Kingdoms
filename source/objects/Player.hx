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
		
		while ( maxArmyCount > 0 && territoryListCopy.length > 0)
		{
			var roll : Int = Std.random(territoryListCopy.length);
			var territoryNum : Int = territoryListCopy[roll];
			var territory : Territory = TerritoryManager.getTerritory(territoryNum);
			
			//trace("Assigning a unit to territory num " + territory.territoryNumber);
			if ( territory.increaseArmyCount() )
			{	
				maxArmyCount--;
				//trace("Success! Reducing army count!");
			}
			else
			{
				territoryListCopy.remove(territoryNum);
				//trace("Unsuccessful adding to " + territoryNum + ". Removing form list");
			}
		}
	}
}