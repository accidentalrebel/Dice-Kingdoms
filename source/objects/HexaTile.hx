package objects;
import flash.display.Sprite;
import flixel.group.FlxGroup;
import flixel.system.layer.frames.FlxFrame;
import objects.Territory;
import flixel.system.FlxAssets;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxPoint;
import flixel.util.FlxRect;
import tools.Tools;

/**
 * ...
 * @author Karlo
 */
class HexaTile extends FlxSprite
{
	//public static var tileWidth : Int = 32;
	//public static var tileHeight : Int = 28;
	public static var tileWidth : Int = 22;
	public static var tileHeight : Int = 20;
	
	var col : Int = 0;
	var row : Int = 0;
	var parent : FlxGroup = null;
	var label : FlxText;
	var boundaryGraphic:FlxSprite;
	var coverGraphic:FlxSprite;
	
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
		var hexaSpacingX : Float = (tileWidth / 4);
      
		xPos = col * ( tileWidth - hexaSpacingX + 1.5);
		if ( col % 2 == 0 )
			yPos = row * tileHeight + (tileHeight / 2) - 1;			
		else
			yPos = row * tileHeight - 1;
		
		super(xPos + Registry.playAreaPadding.x, yPos + Registry.playAreaPadding.y);
		
		//this.loadGraphic("assets/hexaTerrain.png", false, false, tileWidth, tileHeight);
		//this.animation.frameIndex = Tools.randomMinMax(1, 2);
		
		this.parent = parent;
		Registry.playArea.add(this);
		
		coverGraphic = new FlxSprite(this.x, this.y, "assets/hexaTile.png");
		coverGraphic.alpha = 0.25;
		Registry.playArea.add(coverGraphic);
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
			boundaryGraphic.loadGraphic("assets/boundaryLines.png", false, false, tileWidth, tileHeight);
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