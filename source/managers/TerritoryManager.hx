package managers;
import flixel.util.FlxRandom;
import layers.PlayAreaLayer;
import objects.Territory;
import flixel.FlxBasic;
import states.PlayState;

/**
 * ...
 * @author 
 */
class TerritoryManager
{
	public static inline var TERRITORIES_PER_ROW : Int		= 7;
	public static inline var TERRITORIES_PER_COLUMN : Int 	= 5;
	public static var MAX_NUM_OF_TERRITORIES : Int 			= TERRITORIES_PER_COLUMN * TERRITORIES_PER_ROW;

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
		for ( tTerritory in territoryList )
		{
			var territory : Territory = tTerritory;
			territory.setupTerritorySprite();
		}
	}
}