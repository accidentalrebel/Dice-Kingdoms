package objects;
import flash.display.Sprite;
import flixel.FlxSprite;
import flixel.system.replay.FlxReplay;
import flixel.util.FlxRandom;
import flixel.util.FlxRect;
import managers.GameplayManager;
import managers.TerritoryManager;
import flixel.FlxBasic;
import misc.PlayerColor;
import objects.Player;
import states.GameState;
import tools.Tools;

/**
 * ...
 * @author 
 */
class Territory extends FlxSprite
{
	private static inline var COVER_ALPHA : Float = 0.6;
	
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
	
	/**************************************************************************************
	 * Territory Sprite setup
	 **************************************************************************************/
	public function setupTerritorySprite() 
	{
		var boundingBox : FlxRect = Tools.getBoundingBox(members);
		this.makeGraphic(Std.int(boundingBox.width), Std.int(boundingBox.height), 0, true);
		this.setPosition(boundingBox.x, boundingBox.y);
		
		// For each hexaTile, we get it's positino and stamp a randomized land
		for ( tHexaTile in members )
		{
			var hexaTile : HexaTile = tHexaTile;
			var stamp : FlxSprite = GameState.stampsHolder.setToFrame(GameState.stampsHolder.landStamp, 3);
			
			//TODO: Instead of changing the alpha, change the color
			stamp.alpha = FlxRandom.floatRanged(0.5, 1);
			this.stamp(stamp, Std.int(hexaTile.x-boundingBox.x), Std.int(hexaTile.y-boundingBox.y));
		}
		
		setupCoverGraphic(boundingBox);		
		//drawBoundaries();
	}
	
	public function setupCoverGraphic(boundingBox:FlxRect)
	{
		coverSprite = new FlxSprite();
		coverSprite.makeGraphic(Std.int(this.width), Std.int(this.height), 0, true);	
		coverSprite.setPosition(this.x, this.y);
		GameState.playArea.add(coverSprite);
		
		// For each hexaTile, we get it's position and stamp a cover
		for ( tHexaTile in members )
		{
			var hexaTile : HexaTile = tHexaTile;
			GameState.stampsHolder.hexaTileStamp.alpha = COVER_ALPHA;
			coverSprite.stamp(GameState.stampsHolder.hexaTileStamp, Std.int(hexaTile.x-boundingBox.x), Std.int(hexaTile.y-boundingBox.y));
		}
	}
	
	/**************************************************************************************
	 * Territory Sprite manipulation methods
	 **************************************************************************************/
	public function setCoverColorTo(thisColor:Int) 
	{
		coverSprite.color = thisColor;
	}
	
	/**************************************************************************************
	 * Army count
	 **************************************************************************************/
	public function setArmyCount(count:Int) 
	{
		if ( centerTile == null )
			return;
		
		armyCount = count;
		centerTile.updateLabel(Std.string(count));
	}
	
	public function canIncreaseArmyCount(amount : Int = 1) : Bool 
	{
		if ( armyCount + amount > GameState.maxArmyCountPerTerritory )
			return false;
			
		return true;
	}
	
	public function increaseArmyCount(amount : Int = 1) : Bool
	{
		if ( armyCount + amount > GameState.maxArmyCountPerTerritory )
			return false;
		
		armyCount += amount;
		setArmyCount(armyCount);
		
		if ( GameState.playArea.setupFinished )
			GameState.gameGUI.spawnAddArmyEffect(centerTile.x, centerTile.y, amount);
		
		return true;
	}
	
	/**************************************************************************************
	 * Territory selection
	 **************************************************************************************/
	public function select(isNeighborSelect : Bool = false) 
	{
		var alphaValue : Float = 1;
		if ( isNeighborSelect )
			alphaValue = 0.25;
		else
			alphaValue = 0.5;
			
		this.alpha = alphaValue;
		this.coverSprite.alpha = alphaValue;
		return;
	}
	
	public function deselect(isNeighborDeselect : Bool = false)
	{
		this.alpha = 1;
		this.coverSprite.alpha = 1;
		return;
	}
	
	public function highlightNeighbors() 
	{
		for ( tNeighborNum in neighbors )
		{
			var neighborNum : Int = tNeighborNum;
			if ( GameState.territoryManager.getTerritory(neighborNum).ownerNumber == ownerNumber )
				continue;
			
			GameState.territoryManager.getTerritory(neighborNum).select(true);
		}
	}
	
	public function unhighlightNeighbors() 
	{
		for ( tNeighborNum in neighbors )
		{
			var neighborNum : Int = tNeighborNum;
			GameState.territoryManager.getTerritory(neighborNum).deselect(true);
		}
	}
	
	public function checkIfEnemyNeighbor(territoryNumber:Int) 
	{
		if ( GameState.territoryManager.getTerritory(territoryNumber).ownerNumber == ownerNumber )
			return false;
			
		return Lambda.has(neighbors, territoryNumber);
	}
	
	override public function destroy():Void 
	{
		GameState.playArea.remove(coverSprite);
		coverSprite.destroy();
		
		super.destroy();
	}
}