package managers;
import objects.Territory;
import flixel.FlxBasic;

/**
 * ...
 * @author 
 */
class TerritoryManager
{
	public var territoryList : Array<Territory>;

	public function new()
	{	
		territoryList = new Array<Territory>();
	}
	
	public function getTerritory(territoryNumber : Int) : Territory
	{
		return territoryList[territoryNumber];
	}	
	
	public function getRandomTerritory(playerNum:Int) : Territory
	{
		var playersTerritories : Array<Int> = PlayerManager.getPlayer(playerNum).territories;
		return getTerritory(playersTerritories[Std.random(playersTerritories.length)]);
	}
}