package objects;
import flixel.FlxSprite;
import flixel.system.replay.FlxReplay;
import flixel.util.FlxRect;
import managers.GameplayManager;
import managers.TerritoryManager;
import flixel.FlxBasic;
import misc.PlayerColor;
import objects.Player;
import states.PlayState;
import tools.Tools;

/**
 * ...
 * @author 
 */
class Territory extends FlxSprite
{
	private static inline var COVER_ALPHA : Float = 0.5;
	
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
			this.stamp(PlayState.stampsHolder.randomizeFrame(PlayState.stampsHolder.landStamp), Std.int(hexaTile.x-boundingBox.x), Std.int(hexaTile.y-boundingBox.y));
		}
		
		setupCoverGraphic(boundingBox);		
		drawBoundaries();
	}
	
	public function setupCoverGraphic(boundingBox:FlxRect)
	{
		coverSprite = new FlxSprite();
		coverSprite.makeGraphic(Std.int(this.width), Std.int(this.height), 0, true);	
		coverSprite.setPosition(this.x, this.y);
		PlayState.playArea.add(coverSprite);
		
		// For each hexaTile, we get it's position and stamp a cover
		for ( tHexaTile in members )
		{
			var hexaTile : HexaTile = tHexaTile;
			PlayState.stampsHolder.hexaTileStamp.alpha = COVER_ALPHA;
			coverSprite.stamp(PlayState.stampsHolder.hexaTileStamp, Std.int(hexaTile.x-boundingBox.x), Std.int(hexaTile.y-boundingBox.y));
		}
	}
	
	public function drawBoundaries()
	{
		// We now draw the boundaries
	    for ( tMember in members )
		{
			var member : HexaTile = tMember;
			if ( member != null )
			{
				drawMemberBoundary(member, PlayerColor.WHITE);
			}
		}
	}
	
	private function drawMemberBoundary(hexaTile : HexaTile, colorToUse : Int) 
	{		
		function drawBoundary(theNeighbor : HexaTile, frameToUse:Int) 
		{
			if ( theNeighbor != null && theNeighbor.isATerritory
				&& hexaTile.territoryNumber == theNeighbor.territoryNumber )
				return;
				
			var boundaryGraphic : FlxSprite = PlayState.stampsHolder.setToFrame(PlayState.stampsHolder.boundaryStamp, frameToUse);
			boundaryGraphic.color = colorToUse;
		
			var territory : Territory = PlayState.territoryManager.getTerritory(territoryNumber);
			coverSprite.stamp(boundaryGraphic, Std.int(hexaTile.x - this.x), Std.int(hexaTile.y - this.y));			
		}
		
		drawBoundary(hexaTile.top, 0);
		drawBoundary(hexaTile.topRight, 1);
		drawBoundary(hexaTile.bottomRight, 2);
		drawBoundary(hexaTile.bottom, 3);
		drawBoundary(hexaTile.bottomLeft, 4);
		drawBoundary(hexaTile.topLeft, 5);
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
	
	/**************************************************************************************
	 * Territory selection
	 **************************************************************************************/
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