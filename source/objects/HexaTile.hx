package objects;
import flash.display.Sprite;
import flixel.system.layer.frames.FlxFrame;
import objects.Territory;
import flixel.system.FlxAssets;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxPoint;
import flixel.util.FlxRect;

/**
 * ...
 * @author Karlo
 */
class HexaTile extends FlxSprite
{
	public static var tileWidth : Int = 32;
	public static var tileHeight : Int = 28;
	//public static var tileWidth : Int = 24;
	//public static var tileHeight : Int = 21;
	
	var col : Int = 0;
	var row : Int = 0;
	var parent : FlxState = null;
	var label : FlxText;
	var boundaryGraphic:FlxSprite;
	
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
	
	public function new(parent : FlxState, col : Int , row : Int) 
	{
		this.col = col;
		this.row = row;
      
		var xPos = 0.0;
		var yPos = 0.0;
		var hexaSpacingX : Float = tileWidth / 4;
      
		xPos = col * ( tileWidth - hexaSpacingX);
		if ( col % 2 == 0 )
			yPos = row * tileHeight + (tileHeight / 2);			
		else
			yPos = row * tileHeight;
		
		super(xPos + Registry.playAreaPadding.x, yPos + Registry.playAreaPadding.y);
		
		loadGraphic("assets/hexaTile.png");
		//scale = new FlxPoint(0.75, 0.75);
		
		this.parent = parent;
		this.parent.add(this);
	}	
	
	public function checkIfClicked(xPos:Float, yPos:Float)
	{
		if ( xPos >= x && xPos <= x + width && yPos >= y && yPos <= y + height )
			return true;
			
		return false;
	}
	
	public function setupLabel(textToDisplay : String)
	{
		label = new FlxText(this.x, this.y, 30);
		label.alignment = "center";
		label.size = 20;
		label.color = 0x000000;
		
		this.parent.add(label);
		updateLabel(textToDisplay);
	}
	
	public function updateLabel(text : String)
	{
		label.text = text;
	}
	
	public function drawBoundaries() 
	{
		function drawBoundary(theNeighbor : HexaTile, frameToUse:Int) 
		{
			if ( theNeighbor != null && theNeighbor.isATerritory
				&& this.territoryNumber == theNeighbor.territoryNumber )
				return;
				
			boundaryGraphic = new FlxSprite(this.x, this.y);
			boundaryGraphic.loadGraphic("assets/boundaryLines.png", true, false, 32, 28);
			boundaryGraphic.animation.frameIndex = frameToUse;
			
			this.parent.add(boundaryGraphic);
		}
		
		drawBoundary(this.top, 0);
		drawBoundary(this.topRight, 1);
		drawBoundary(this.bottomRight, 2);
		drawBoundary(this.bottom, 3);
		drawBoundary(this.bottomLeft, 4);
		drawBoundary(this.topLeft, 5);
	}
}