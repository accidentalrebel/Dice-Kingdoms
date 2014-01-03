package layers;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.util.FlxRandom;
import misc.PlayerColor;
import objects.HexaTile;
import objects.Player;
import objects.Territory;
import states.PlayState;

/**
 * ...
 * @author Karlo
 */
class PlayAreaLayer extends FlxGroup
{
	//TODO: Just remove the hexaTiles that has no surrounding same-territory neighbors
	inline public static var PLAY_AREA_COLUMNS 	: Int = 42;
	inline public static var PLAY_AREA_ROWS 	: Int = 26;
	inline public static var BOUNDARY_COLOR_MINUEND 	: Int = 0x111111;
	
	public var seaCanvas		: FlxSprite;
	public var playAreaArray 	: Array<Array<HexaTile>>;
	public var setupFinished 	: Bool = false;
	
	inline public static var AREA_WIDTH : Float = (((PlayAreaLayer.PLAY_AREA_COLUMNS) / 2)) * HexaTile.TILE_WIDTH
		+ ((PlayAreaLayer.PLAY_AREA_COLUMNS) / 2) * HexaTile.TILE_FACE_WIDTH 
		+ (HexaTile.TILE_WIDTH - HexaTile.TILE_FACE_WIDTH) /2;		
	inline public static var AREA_HEIGHT : Float = (PlayAreaLayer.PLAY_AREA_ROWS * HexaTile.TILE_HEIGHT)
		+ HexaTile.TILE_HEIGHT / 2;
	
	public function new()
	{
		super();
	}
	
	public function init(parent : FlxState) 
	{		
		seaCanvas = new FlxSprite(0, 0);
		seaCanvas.makeGraphic(Std.int(AREA_WIDTH), Std.int(AREA_HEIGHT), 0);
		this.add(seaCanvas);
		playAreaArray = new Array<Array<HexaTile>>();
		
		for ( col in 0...PLAY_AREA_COLUMNS )
		{
			var rowArray : Array<HexaTile> = new Array<HexaTile>();
			playAreaArray.push(rowArray);
			
			for ( row in 0...PLAY_AREA_ROWS )
			{
				var hexaTile : HexaTile = new HexaTile(this, col, row);
				playAreaArray[col].push(hexaTile);
			}
		}
	   
		// We set the neighbors of each hexaTile
		for ( col in 0...PLAY_AREA_COLUMNS )
		{
			for ( row in 0...PLAY_AREA_ROWS )
			{
				var currentHexaTile : HexaTile = playAreaArray[col][row];
				
				// We then get the surrounding of this tile
				// First the bottom neighbor
				if ( row + 1 <= PLAY_AREA_ROWS )			
					currentHexaTile.bottom = playAreaArray[col][row + 1];
				// We get the top neighbor
				if ( row - 1 >= 0 )
					currentHexaTile.top = playAreaArray[col][row - 1];
					
				if ( col % 2 == 0 ) 		// If even
				{
					if ( col - 1 >= 0 )
					{
						currentHexaTile.topLeft = playAreaArray[col - 1][row];
						currentHexaTile.bottomLeft = playAreaArray[col - 1][row + 1];
					}
					
					if ( col + 1 < PLAY_AREA_COLUMNS )
					{
						currentHexaTile.topRight = playAreaArray[col + 1][row];					
						currentHexaTile.bottomRight = playAreaArray[col + 1][row + 1];
					}
				}
				else						// If odd
				{
					if ( col - 1 >= 0 )
					{
						currentHexaTile.topLeft = playAreaArray[col - 1][row - 1];
						currentHexaTile.bottomLeft = playAreaArray[col - 1][row];
					}
					
					if ( col + 1 < PLAY_AREA_COLUMNS)
					{
						currentHexaTile.topRight = playAreaArray[col + 1][row - 1];
						currentHexaTile.bottomRight = playAreaArray[col + 1][row];
					}
				}
			}
		}
	}
	
	public function setupTerritories()
	{		
	    var centerBaseList : Array<HexaTile> = new Array<HexaTile>();
		var currentTerritoryNumber : Int = 0;
		var recursiveMax : Int = 5;
		var recursiveCount : Int = 0;
		var alpha : Float = 0;
	    
		//TODO: Turn to a sea tile function to be removed
		function markTerritory(hexaTile : HexaTile, canOverride : Bool = false) : Bool
		{  
			if (hexaTile == null || hexaTile.isATerritory || hexaTile.col <= 0 || hexaTile.row <= 0 
				|| hexaTile.col >= PLAY_AREA_COLUMNS - 1 || hexaTile.row >= PLAY_AREA_ROWS - 1)
				return false;
			
			hexaTile.isATerritory = true;	
			hexaTile.territoryNumber = currentTerritoryNumber;
			
			return true;
		}
		
		function setAsMainBase(hexaTile : HexaTile) : Bool
		{
			if (hexaTile == null)
				return false;
			
			markTerritory(hexaTile); 
			hexaTile.isMainBase = true;
			
			return true;
		}	
		
		function setupCenter(currentHexaTile : HexaTile)
		{
			if (currentHexaTile == null)
				return false;
      
			markTerritory(currentHexaTile);
			markTerritory(currentHexaTile.top, true);
			markTerritory(currentHexaTile.bottom);
			markTerritory(currentHexaTile.topLeft);
			markTerritory(currentHexaTile.topRight);
			markTerritory(currentHexaTile.bottomLeft);
			markTerritory(currentHexaTile.bottomRight);
			
			return true;
		}
		
		function recursiveExpand(currentHexaTile : HexaTile)
		{
			if (currentHexaTile == null || recursiveCount > recursiveMax
				|| ( currentHexaTile.isATerritory 
					&& currentHexaTile.territoryNumber != currentTerritoryNumber))
				return null;   
				
			recursiveCount += 1;
			var neighborList : Array<HexaTile> = new Array<HexaTile>();
		
			if (currentHexaTile.top != null 
				&& !currentHexaTile.top.isPicked )
				neighborList.push( currentHexaTile.top);
			
			if (currentHexaTile.topRight != null 
				&& !currentHexaTile.topRight.isPicked)
				neighborList.push( currentHexaTile.topRight);
			
			if (currentHexaTile.bottomRight != null
				&& !currentHexaTile.bottomRight.isPicked)
				neighborList.push( currentHexaTile.bottomRight);
			
			if (currentHexaTile.bottom != null
				&& !currentHexaTile.bottom.isPicked)
				neighborList.push( currentHexaTile.bottom);
			
			if (currentHexaTile.bottomLeft != null
				&& !currentHexaTile.bottomLeft.isPicked)
				neighborList.push( currentHexaTile.bottomLeft);
			
			if (currentHexaTile.topLeft != null
				&& !currentHexaTile.topLeft.isPicked)
				neighborList.push( currentHexaTile.topLeft);
			
		    if (neighborList == null || neighborList.length <= 0
				|| ( currentHexaTile.isATerritory 
					&& currentHexaTile.territoryNumber != currentTerritoryNumber))
				return null;
			
		    var roll : Int = FlxRandom.intRanged(0, neighborList.length-1);
		    var pickedNeighbor : HexaTile = neighborList[roll];
		    
		    setupCenter(pickedNeighbor);
		    pickedNeighbor.isPicked = true;
		    return recursiveExpand(pickedNeighbor);
		}
		
		function expandBase(centerTile : HexaTile)
		{			
			recursiveCount = 0;
			recursiveExpand(centerTile.topLeft);
			recursiveCount = 0;
			recursiveExpand(centerTile.bottomRight);			
		}
		
		function markMainBase(centerTile : HexaTile, centerBaseList : Array<HexaTile>)
		{	
			centerTile.isCenter = true;		
			
			centerBaseList.push(centerTile);
			setAsMainBase(centerTile);
			setAsMainBase(centerTile.top);
			setAsMainBase(centerTile.topRight);
			setAsMainBase(centerTile.bottomRight);
			setAsMainBase(centerTile.bottom);
			setAsMainBase(centerTile.bottomLeft);
			setAsMainBase(centerTile.topLeft);
			
			centerTile.setupCastle();
			//centerTile.setupLabel("1");
		}
		
		function setupTerritory(rollX : Int, rollY : Int, centerBaseList : Array<HexaTile>)
		{	
			// We move the center slightly to make it more random
			var rollXModifier = FlxRandom.intRanged(-1, 0);
			var rollYModifier = FlxRandom.intRanged(-1, 0);
			
			rollX = rollX + rollXModifier;
			rollY = rollY + rollYModifier;
		  
			var currentHexaTile = playAreaArray[rollX][rollY];
			markMainBase(currentHexaTile, centerBaseList);
		}
		
		function setTerritoryNeighbor(hexaTile : HexaTile)
		{
			function checkNeighbor(neighborToCheck : HexaTile)
			{
				if ( neighborToCheck == null || !neighborToCheck.isATerritory )
					return;
				
				if ( neighborToCheck.territoryNumber != hexaTile.territoryNumber )
				{
					var neighborList : Array<Int> = PlayState.territoryManager.getTerritory(hexaTile.territoryNumber).neighbors;
					if ( !Lambda.has(neighborList, neighborToCheck.territoryNumber))
						neighborList.push(neighborToCheck.territoryNumber);
				}
			}
			
			checkNeighbor(hexaTile.top);	
			checkNeighbor(hexaTile.topRight);
			checkNeighbor(hexaTile.bottomRight);
			checkNeighbor(hexaTile.bottom);
			checkNeighbor(hexaTile.bottomLeft);
			checkNeighbor(hexaTile.topLeft);
		}
		
		// TODO: Check why players are being skipped even though they still have one territory left
		// We initialize the territories
		for (row in 1...(Math.floor(PLAY_AREA_ROWS/5) + 1))
		{
			for (col in 1...(Math.floor(PLAY_AREA_COLUMNS/5) + 1))
			{  
				setupTerritory((col * 5)-1, (row * 5)-2, centerBaseList);
				currentTerritoryNumber += 1;
			}
        }
		
		// We expand the territories
		var count : Int = 0;
		for ( centerBase in centerBaseList )
		{
			currentTerritoryNumber = count;
			expandBase(centerBase);
			count++;
		}
		
		// We group the territories		
		// We create the territory list
		for ( i in 0...PlayState.maxTerritories )
		{
			var territory : Territory = new Territory(i);
			this.add(territory);
			PlayState.territoryManager.territoryList.push(territory);
		}
		
		for ( row in 0...PLAY_AREA_ROWS)
		{
			for ( col in 0...PLAY_AREA_COLUMNS)
			{
				var hexaTile : HexaTile = playAreaArray[col][row];
				if (hexaTile != null)
				{
					// We turn non territories to sea tiles
					if ( !hexaTile.isATerritory )
						//hexaTile.kill();
						hexaTile.turnToSeaTile();
					else
					{						
						var currentTerritory : Territory = PlayState.territoryManager.getTerritory(hexaTile.territoryNumber);
						currentTerritory.members.push(hexaTile);
						
						// We set the neighboring territories
						setTerritoryNeighbor(hexaTile);
					}
				}
			}
		}
		
		for ( tCenter in centerBaseList )
		{
			var center : HexaTile = tCenter;
			PlayState.territoryManager.getTerritory(center.territoryNumber).centerTile = center;
		}
		
		PlayState.territoryManager.setupTerritorySprites();
		this.drawBoundaries();
	} 
	
	public function assignTerritories() 
	{
		var pickedTerritories : Array<Int> = new Array<Int>();
		
		function getRandomTerritoryNum()
		{
			var roll : Int = 0;
			while (true)
			{
				roll = FlxRandom.intRanged(0, PlayState.territoryManager.territoryList.length-1);
				if ( !Lambda.has(pickedTerritories, roll) )
					break;
			}
			
			pickedTerritories.push(roll);
			return roll;
		}
      
		PlayState.territoryPerPlayer = Math.floor(PlayState.maxTerritories / PlayState.playerManager.playerList.length);
		for (playerNum in 1...PlayState.playerManager.playerList.length+1 )
	    {
			for (j in 0...PlayState.territoryPerPlayer)
			{				
				PlayState.playArea.assignTerritory(getRandomTerritoryNum(), playerNum);        
			}
	    }
	}
	
	public function drawBoundaries()
	{
		for ( col in 0...PLAY_AREA_COLUMNS )
		{			
			for ( row in 0...PLAY_AREA_ROWS )
			{
				drawTileBoundary(playAreaArray[col][row], PlayerColor.WHITE);
			}
		}
	}
	
	private function drawTileBoundary(hexaTile : HexaTile, colorToUse : Int) 
	{		
		function drawBoundary(theNeighbor : HexaTile, frameToUse:Int) 
		{
			// IF this tile is a land territory
			if ( hexaTile.isATerritory )
			{
				if ( theNeighbor != null && theNeighbor.isATerritory
					&& hexaTile.territoryNumber == theNeighbor.territoryNumber )
					return;
					
				var boundaryGraphic : FlxSprite = PlayState.stampsHolder.setToFrame(PlayState.stampsHolder.boundaryStamp, frameToUse);
				boundaryGraphic.color = colorToUse - BOUNDARY_COLOR_MINUEND;
			
				var territory : Territory = PlayState.territoryManager.getTerritory(hexaTile.territoryNumber);
				territory.coverSprite.stamp(boundaryGraphic, Std.int(hexaTile.x - territory.x)
					, Std.int(hexaTile.y - territory.y));
			}
			// If this tile is a sea tile
			else
			{
				if ( theNeighbor == null || !theNeighbor.isATerritory )
					return;
					
				var boundaryGraphic : FlxSprite = PlayState.stampsHolder.setToFrame(PlayState.stampsHolder.seaBoundaryStamp, frameToUse);
				boundaryGraphic.color = colorToUse;
				seaCanvas.stamp(boundaryGraphic, Std.int(hexaTile.x)
					, Std.int(hexaTile.y));
			}
		}
		
		drawBoundary(hexaTile.top, 0);
		drawBoundary(hexaTile.topRight, 1);
		drawBoundary(hexaTile.bottomRight, 2);
		drawBoundary(hexaTile.bottom, 3);
		drawBoundary(hexaTile.bottomLeft, 4);
		drawBoundary(hexaTile.topLeft, 5);
	}
	
	public function assignTerritory(territoryNum : Int, playerNum : Int)
	{
		var territory : Territory = PlayState.territoryManager.getTerritory(territoryNum);
		
		// If someone already owns this territory
		if ( territory.ownerNumber > 0 )
		{
			var oldOwner : Player = PlayState.playerManager.getPlayer(territory.ownerNumber);
			oldOwner.territories.remove(territoryNum);
		}
			
		// We now assign to the new owner
		territory.ownerNumber = playerNum;
		var newOwner: Player = PlayState.playerManager.getPlayer(playerNum);
		newOwner.territories.push(territoryNum);
		
		// We set the territory cover color
		territory.setCoverColorTo(PlayState.playerManager.getPlayer(playerNum).territoryColor);
		
		//TODO: We now have no more use for the HexaTile's sprite. Destroy it here.
	}
	
	public function checkForClickedTiles(xPos:Float, yPos:Float) 
	{
		for ( col in 0...PLAY_AREA_COLUMNS )
		{
			for ( row in 0...PLAY_AREA_ROWS )
			{
				var hexaTile : HexaTile = playAreaArray[col][row];
				if ( hexaTile.checkIfClicked(xPos, yPos) )
					return hexaTile;
			}
		}
		
		return null;
	}
	
	public function selectTerritory(clickedTerritory : Territory, neighborSelect : Bool = false) : Int
	{	
		clickedTerritory.select(neighborSelect);
		return clickedTerritory.territoryNumber;
	}
    
	public function deselectTerritory(thisTerritory : Int) : Int
	{
		var toDeselect : Territory = PlayState.territoryManager.getTerritory(thisTerritory);
		toDeselect.deselect();
		toDeselect.unhighlightNeighbors();
		
		return -1;
	}
}