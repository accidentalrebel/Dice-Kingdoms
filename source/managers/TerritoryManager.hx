package managers;
import flixel.util.FlxRandom;
import objects.Territory;
import flixel.FlxBasic;
import states.PlayState;

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
		var playersTerritories : Array<Int> = PlayState.playerManager.getPlayer(playerNum).territories;
		return getTerritory(playersTerritories[FlxRandom.intRanged(0, playersTerritories.length-1)]);
	}
	
	public function setupTerritorySprites() 
	{
		territoryList[0].setupTerritorySprite();
		return;
		
		for ( tTerritory in territoryList )
		{
			var territory : Territory = tTerritory;
			territory.setupTerritorySprite();
		}
	}
}