package layers;
import flash.Lib;
import flash.Memory;
import flixel.addons.display.FlxSpriteAniRot;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import managers.CameraManager;
import managers.PlayerManager;
import managers.TerritoryManager;
import objects.HexaTile;
import objects.Player;
import objects.Territory;
import flixel.FlxBasic;
import flixel.FlxState;
import flixel.util.FlxPoint;

/**
 * ...
 * @author Karlo
 */
class PlayAreaLayer extends FlxGroup
{
	public static var playAreaCols : Int = 42;
	public static var playAreaRows : Int = 26;
	public var playAreaArray : Array<Array<HexaTile>>;
	public var playAreaCanvas:FlxSprite;

	public function new()
	{
		super();
	}
	
	public function init(parent : FlxState) 
	{		
		playAreaCanvas = new FlxSprite(0, 0);
		playAreaCanvas.cameras = [ CameraManager.mainCamera ];
		
		//TODO: Get the actual height of the playArea by calculating using the tileHeight and playAreaRows
		playAreaCanvas.makeGraphic(Std.int(FlxG.width)
			, Std.int((FlxG.height + 100) / FlxG.camera.zoom), 0);
		
		playAreaArray = new Array<Array<HexaTile>>();
		
		for ( col in 0...playAreaCols+1 )
		{
			var rowArray : Array<HexaTile> = new Array<HexaTile>();
			playAreaArray.push(rowArray);
			
			for ( row in 0...playAreaRows+1 )
			{
				var hexaTile : HexaTile = new HexaTile(this, col, row);
				playAreaArray[col].push(hexaTile);
			}
		}
	   
		// We set the neighbors of each hexaTile
		for ( col in 0...playAreaCols+1 )
		{
			for ( row in 0...playAreaRows+1 )
			{
				var currentHexaTile : HexaTile = playAreaArray[col][row];
				
				// We then get the surrounding of this tile
				// First the bottom neighbor
				if ( row + 1 <= playAreaRows )			
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
					
					if ( col + 1 < playAreaCols )
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
					
					if ( col + 1 < playAreaCols)
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
	    
		function markTerritory(hexaTile : HexaTile, canOverride : Bool = false) : Bool
		{  
			if (hexaTile == null || hexaTile.isATerritory)
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
			
		    var roll : Int = Std.random(neighborList.length);
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
			
			centerTile.setupLabel("1");
		}
		
		function setupTerritory(rollX : Int, rollY : Int, centerBaseList : Array<HexaTile>)
		{	
			// We move the center slightly to make it more random
			var rollXModifier = Std.random(2) - 1;
			var rollYModifier = Std.random(2) - 1;
			
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
					var neighborList : Array<Int> = Registry.territoryManager.getTerritory(hexaTile.territoryNumber).neighbors;
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
		
		// We initialize the territories
		for (row in 1...(Math.floor(playAreaRows/5) + 1))
		{
			for (col in 1...(Math.floor(playAreaCols/5) + 1))
			{  
				setupTerritory((col * 5)-1, (row * 5)-1, centerBaseList);
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
		for ( i in 0...Registry.maxTerritories )
		{
			var territory : Territory = new Territory(i);
			Registry.territoryManager.territoryList.push(territory);
		}
		
		for ( row in 0...playAreaRows+1)
		{
			for ( col in 0...playAreaCols+1)
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
						var currentTerritory : Territory = Registry.territoryManager.getTerritory(hexaTile.territoryNumber);
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
			Registry.territoryManager.getTerritory(center.territoryNumber).centerTile = center;
		}
	} 
	
	public function assignTerritories() 
	{
		var pickedTerritories : Array<Int> = new Array<Int>();
		
		function getRandomTerritoryNum()
		{
			var roll : Int = 0;
			while (true)
			{
				roll = Std.random(Registry.territoryManager.territoryList.length);
				if ( !Lambda.has(pickedTerritories, roll) )
					break;
			}
			
			pickedTerritories.push(roll);
			return roll;
		}
      
		Registry.territoryPerPlayer = Math.floor(Registry.maxTerritories / PlayerManager.playerList.length);
		for (playerNum in 1...PlayerManager.playerList.length+1 )
	    {
			for (j in 0...Registry.territoryPerPlayer)
			{
				Registry.playArea.assignTerritory(getRandomTerritoryNum(), playerNum);        
			}
	    }
	}
	
	public function assignTerritory(territoryNum : Int, playerNum : Int)
	{
		var territory : Territory = Registry.territoryManager.getTerritory(territoryNum);
		
		// If someone already owns this territory
		if ( territory.ownerNumber > 0 )
		{
			var oldOwner : Player = PlayerManager.getPlayer(territory.ownerNumber);
			oldOwner.territories.remove(territoryNum);
		}
			
		// We now assign to the new owner
		territory.ownerNumber = playerNum;
		var newOwner: Player = PlayerManager.getPlayer(playerNum);
		newOwner.territories.push(territoryNum);
		
	    for ( tMember in territory.members )
		{
			var member : HexaTile = tMember;
			if ( member != null )
			{
				member.setCoverColorTo(PlayerManager.getPlayer(playerNum).territoryColor);
				member.drawBoundaries(PlayerManager.getPlayer(playerNum).territoryColor);
			}
		}
	}
	
	public function checkForClickedTiles(xPos:Float, yPos:Float) 
	{
		for ( col in 0...playAreaCols+1 )
		{
			for ( row in 0...playAreaRows+1 )
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
		var toDeselect : Territory = Registry.territoryManager.getTerritory(thisTerritory);
		toDeselect.deselect();
		toDeselect.unhighlightNeighbors();
		
		return -1;
	}
}