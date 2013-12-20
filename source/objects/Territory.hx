package objects;
import flixel.FlxSprite;
import flixel.system.replay.FlxReplay;
import flixel.util.FlxRect;
import managers.GameplayManager;
import managers.TerritoryManager;
import flixel.FlxBasic;
import states.PlayState;
import tools.Tools;

/**
 * ...
 * @author 
 */
class Territory extends FlxSprite
{
	public var neighbors : Array<Int>;
	public var armyCount : Int = 0;
	public var centerTile : HexaTile = null;
	public var members : Array<HexaTile>;
	public var ownerNumber : Int = 0;
	public var territoryNumber : Int;
	public var markAsChecked : Bool = false;
	
	public var coverSprite : FlxSprite;

	public function new(territoryNumber : Int) 
	{
		super();

		this.territoryNumber = territoryNumber;
		neighbors = new Array<Int>();
		members = new Array<HexaTile>();
	}
	
	public function setupTerritorySprite() 
	{
		var boundingBox : FlxRect = Tools.getBoundingBox(members);
		this.makeGraphic(Std.int(boundingBox.width), Std.int(boundingBox.height), 0, true);
		this.setPosition(boundingBox.x, boundingBox.y);
		
		for ( tHexaTile in members )
		{
			var hexaTile : HexaTile = tHexaTile;
			this.stamp(PlayState.stampsHolder.randomizeFrame(PlayState.stampsHolder.landStamp), Std.int(hexaTile.x-boundingBox.x), Std.int(hexaTile.y-boundingBox.y));
		}
		
		setupCoverGraphic();
	}
	
	public function setupCoverGraphic()
	{
		coverSprite = new FlxSprite();
		coverSprite.makeGraphic(Std.int(this.width), Std.int(this.height), 0, true);	
		coverSprite.setPosition(this.x, this.y);
		PlayState.playArea.add(coverSprite);
	}
		
	public function setupBorders(boundaryGraphic:FlxSprite, xPos:Float, yPos:Float) 
	{
		coverSprite.stamp(boundaryGraphic, Std.int(xPos - this.x), Std.int(yPos - this.y));
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
		this.alpha = 0.5;
		return;
	}
	
	public function deselect(isNeighborDeselect : Bool = false)
	{
		this.alpha = 1;
		return;
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