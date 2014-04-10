package objects;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.util.FlxRandom;
import flixel.util.FlxRect;
import states.GameState;

/**
 * ...
 * @author Karlo
 */
class HexaTile extends FlxSprite
{
	inline public static var TILE_WIDTH 	:Int = 22;
	inline public static var TILE_HEIGHT 	:Int = 20;
	inline public static var LABEL_WIDTH 	:Int = 30;
	inline public static var LABEL_HEIGHT 	:Int = 24;
	static public inline var TILE_FACE_WIDTH:Float = (HexaTile.TILE_WIDTH / 1.57);		// Refers to the width of the face side of the hexagon
	
	public var col 	:Int = 0;
	public var row 	:Int = 0;
	var parent	:FlxGroup = null;
	var label 	:FlxText;
	
	//TODO: Create a hexaTileGraphic sprite
	//TODO: Might be a good idea to create a stamper class
	//TODO: Create a hexaTile Rect dimensions variable
	var castleGraphic:FlxSprite;	
	
	public var isCenter 	:Bool = false;
	public var isATerritory :Bool = false;
	public var territoryNumber :Int = 0;
	public var isMainBase 	:Bool = false;
	public var isPicked 	:Bool = false;
	
	// Neighbors
	public var top 			:HexaTile = null;
	public var topRight 	:HexaTile = null;
	public var bottomRight 	:HexaTile = null;
	public var bottom 		:HexaTile = null;
	public var bottomLeft 	:HexaTile = null;
	public var topLeft 		:HexaTile = null;
	
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
		this.color = 0x0;
		this.parent = parent;
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
		GameState.gameObjectsLayer.add(castleGraphic);
		
		this.setupLabel("1");
	}
	
	public function setupLabel(textToDisplay : String)
	{		
		//TODO: Take note of the scaled height so that it is consistent on all devices
		label = new FlxText(castleGraphic.x + castleGraphic.width / 2, castleGraphic.y + castleGraphic.height / 2 , LABEL_WIDTH);
		label.font = GameState.DEFAULT_FONT;
		label.size = LABEL_HEIGHT;
		label.x -= label.width / 2;
		label.y -= label.size / 2;
		label.alignment = "center";
		label.color = 0xFFFFFF;
		label.setBorderStyle(FlxText.BORDER_OUTLINE_FAST, 0, 2, 1);
		
		GameState.gameObjectsLayer.add(label);
		updateLabel(textToDisplay);
	}
	
	public function updateLabel(text : String)
	{
		label.text = text;
	}
	
	public function turnToSeaTile(seaCanvas:FlxSprite)
	{
		this.isATerritory = false;
		
		var stamp : FlxSprite = GameState.stampsHolder.setToFrame(GameState.stampsHolder.landStamp, FlxRandom.intRanged(1, 2));
		
		//TODO: Instead of changing the alpha, change the color
		stamp.alpha = FlxRandom.floatRanged(0, 0.5);		
		seaCanvas.stamp(stamp, Std.int(this.x), Std.int(this.y));
	}
}