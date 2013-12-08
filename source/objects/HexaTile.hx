package objects;
import flash.display.Sprite;
import flixel.group.FlxGroup;
import flixel.system.layer.frames.FlxFrame;
import flixel.util.FlxRandom;
import managers.PlayerManager;
import managers.TerritoryManager;
import objects.Territory;
import flixel.system.FlxAssets;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxPoint;
import flixel.util.FlxRect;
import states.PlayState;
import tools.Tools;

/**
 * ...
 * @author Karlo
 */
class HexaTile extends FlxSprite
{
	inline public static var TILE_WIDTH : Int = 22;
	inline public static var TILE_HEIGHT : Int = 20;
	inline public static var LABEL_WIDTH : Int = 30;
	inline public static var LABEL_HEIGHT : Int = 20;
	static public inline var TILE_FACE_WIDTH: Float = (HexaTile.TILE_WIDTH / 1.57);		// Refers to the width of the face side of the hexagon
	
	var col : Int = 0;
	var row : Int = 0;
	var parent : FlxGroup = null;
	var label : FlxText;
	var castleGraphic:FlxSprite;
	
	public var isCenter : Bool = false;
	public var isATerritory : Bool = false;
	public var territoryNumber : Int = 0;
	public var isMainBase : Bool = false;
	public var isPicked : Bool = false;
	
	// Neighbors
	public var top : HexaTile = null;
	public var topRight : HexaTile= null;
	public var bottomRight : HexaTile = null;
	public var bottom : HexaTile = null;
	public var bottomLeft : HexaTile = null;
	public var topLeft : HexaTile = null;
	
	public function new(parent : FlxGroup, col : Int , row : Int) 
	{
		this.col = col;
		this.row = row;
      
		var xPos = 0.0;
		var yPos = 0.0;
		var hexaSpacingX : Float = (TILE_WIDTH / 4);
      
		xPos = col * ( TILE_WIDTH - hexaSpacingX + 1.5);
		if ( col % 2 == 0 )
			yPos = row * TILE_HEIGHT + (TILE_HEIGHT / 2) - 1;			
		else
			yPos = row * TILE_HEIGHT - 1;
		
		super(xPos, yPos);
		
		this.loadGraphic("assets/hexaTerrain.png", false, false, TILE_WIDTH, TILE_HEIGHT);
		this.animation.frameIndex = FlxRandom.intRanged(3, 8);
		
		this.parent = parent;
		PlayState.playArea.add(this);
		
		//PlayState.playArea.add(coverGraphic);
	}	
	
	public function checkIfClicked(xPos:Float, yPos:Float)
	{
		if ( xPos >= x && xPos <= x + width && yPos >= y && yPos <= y + height )
			return true;
			
		return false;
	}
	
	public function setupCastle() 
	{
		castleGraphic = new FlxSprite(this.x + this.width / 2, this.y + this.height / 2 , "assets/castle.png");
		castleGraphic.x -= castleGraphic.width / 2;
		castleGraphic.y -= castleGraphic.height / 2;
		PlayState.gameObjectsLayer.add(castleGraphic);
		
		this.setupLabel("1");
	}
	
	public function setupLabel(textToDisplay : String)
	{		
		//TODO: Take note of the scaled height so that it is consistent on all devices
		label = new FlxText(castleGraphic.x + castleGraphic.width / 2, castleGraphic.y + castleGraphic.height / 2 , LABEL_WIDTH);
		label.size = LABEL_HEIGHT;
		label.x -= label.width / 2;
		label.y -= label.size / 2;
		label.alignment = "center";
		label.color = 0xFFFFFF;
		
		PlayState.gameObjectsLayer.add(label);
		updateLabel(textToDisplay);
	}
	
	public function updateLabel(text : String)
	{
		label.text = text;
	}
	
	public function drawBoundaries(colorToUse : Int) 
	{		
		function drawBoundary(theNeighbor : HexaTile, frameToUse:Int) 
		{
			if ( theNeighbor != null && theNeighbor.isATerritory
				&& this.territoryNumber == theNeighbor.territoryNumber )
				return;
				
			var boundaryGraphic : FlxSprite = new FlxSprite(0, 0);
			boundaryGraphic.loadGraphic("assets/boundaryLines.png", false, false, TILE_WIDTH, TILE_HEIGHT);
			boundaryGraphic.color = colorToUse;
			boundaryGraphic.animation.frameIndex = frameToUse;
		
			//stamp(boundaryGraphic, this.animation.frameIndex * tileWidth);
			PlayState.playArea.playAreaCanvas.stamp(boundaryGraphic, Std.int(this.x), Std.int(this.y));
		}
		
		drawBoundary(this.top, 0);
		drawBoundary(this.topRight, 1);
		drawBoundary(this.bottomRight, 2);
		drawBoundary(this.bottom, 3);
		drawBoundary(this.bottomLeft, 4);
		drawBoundary(this.topLeft, 5);
	}
	
	public function setCoverColorTo(tColor : Int)
	{		
		this.color = tColor;
	}
	
	public function turnToSeaTile()
	{
		this.isATerritory = false;
		this.animation.frameIndex = FlxRandom.intRanged(0, 2);		// Set to the sea graphic
	}
}