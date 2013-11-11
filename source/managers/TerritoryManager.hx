package managers;
import objects.Territory;
import flixel.FlxBasic;

/**
 * ...
 * @author 
 */
class TerritoryManager
{
	public static var territoryList : Array<Territory> = new Array<Territory>();

	public static function getTerritory(territoryNumber : Int) : Territory
	{
		return territoryList[territoryNumber];
	}	
}