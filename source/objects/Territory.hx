package objects;
import managers.GameplayManager;
import managers.TerritoryManager;
import flixel.FlxBasic;
import states.PlayState;

/**
 * ...
 * @author 
 */
class Territory extends FlxBasic
{
	public var neighbors : Array<Int>;
	public var armyCount : Int = 0;
	public var centerTile : HexaTile = null;
	public var members : Array<HexaTile>;
	public var ownerNumber : Int = 0;
	public var territoryNumber : Int;
	public var markAsChecked : Bool = false;

	public function new(territoryNumber : Int) 
	{
		super();
		this.territoryNumber = territoryNumber;
		neighbors = new Array<Int>();
		members = new Array<HexaTile>();
	}
	
	public function setArmyCount(count:Int) 
	{
		if ( centerTile == null )
			return;
		
		armyCount = count;
		centerTile.updateLabel(Std.string(count));
	}
	
	public function canIncreaseArmyCount(amount : Int = 1) : Bool 
	{
		if ( armyCount + amount > PlayState.maxArmyCountPerTerritory )
			return false;
			
		return true;
	}
	
	public function increaseArmyCount(amount : Int = 1) : Bool
	{
		if ( armyCount + amount > PlayState.maxArmyCountPerTerritory )
			return false;
		
		armyCount += amount;
		setArmyCount(armyCount);
		
		if ( PlayState.playArea.setupFinished )
			PlayState.gameGUI.spawnAddArmyEffect(centerTile.x, centerTile.y, amount);
		
		return true;
	}
	
	public function select(isNeighborSelect : Bool = false) 
	{
		for ( tHexaTile in members )
		{
			var hexaTile : HexaTile = tHexaTile;
			
			if ( isNeighborSelect )
				hexaTile.scale.x = 0.5;
			else
			{
				hexaTile.angle = 90;
				hexaTile.scale.x = 0.5;
			}
		}
	}
	
	public function deselect(isNeighborDeselect : Bool = false)
	{
		for ( tHexaTile in members )
		{
			var hexaTile : HexaTile = tHexaTile;
			
			if ( isNeighborDeselect )
				hexaTile.scale.x = 1;
			else
			{
				hexaTile.angle = 0;
				hexaTile.scale.x = 1;
			}
		}
	}
	
	public function highlightNeighbors() 
	{
		for ( tNeighborNum in neighbors )
		{
			var neighborNum : Int = tNeighborNum;
			if ( PlayState.territoryManager.getTerritory(neighborNum).ownerNumber == ownerNumber )
				continue;
			
			PlayState.territoryManager.getTerritory(neighborNum).select(true);
		}
	}
	
	public function unhighlightNeighbors() 
	{
		for ( tNeighborNum in neighbors )
		{
			var neighborNum : Int = tNeighborNum;
			PlayState.territoryManager.getTerritory(neighborNum).deselect(true);
		}
	}
	
	public function checkIfEnemyNeighbor(territoryNumber:Int) 
	{
		if ( PlayState.territoryManager.getTerritory(territoryNumber).ownerNumber == ownerNumber )
			return false;
			
		return Lambda.has(neighbors, territoryNumber);
	}
}