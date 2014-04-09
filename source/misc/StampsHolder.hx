package misc;
import flixel.FlxSprite;
import flixel.util.FlxRandom;
import objects.HexaTile;

/**
 * ...
 * @author 
 */
class StampsHolder
{
	public var landStamp 		: FlxSprite;
	public var boundaryStamp 	: FlxSprite;
	public var seaBoundaryStamp	: FlxSprite;
	public var hexaTileStamp	: FlxSprite;
	
	public function new() 
	{
		setupSprites();
	}
	
	public function setupSprites() 
	{
		landStamp = new FlxSprite(0, 0);
		landStamp.loadGraphic("assets/hexaTerrain.png", false, false, HexaTile.TILE_WIDTH, HexaTile.TILE_HEIGHT);
		
		boundaryStamp = new FlxSprite(0, 0);
		boundaryStamp.loadGraphic("assets/boundaryLines.png", false, false, HexaTile.TILE_WIDTH, HexaTile.TILE_HEIGHT);
		
		seaBoundaryStamp = new FlxSprite(0, 0);
		seaBoundaryStamp.loadGraphic("assets/seaBoundaryLines.png", false, false, HexaTile.TILE_WIDTH, HexaTile.TILE_HEIGHT);
		
		hexaTileStamp = new FlxSprite(0, 0);
		hexaTileStamp.loadGraphic("assets/hexaTile.png", false, false, HexaTile.TILE_WIDTH, HexaTile.TILE_HEIGHT);
	}
	
	public function randomizeFrame(theSprite : FlxSprite, minFrame : Int, maxFrame : Int) : FlxSprite
	{
		theSprite.animation.frameIndex = FlxRandom.intRanged(minFrame, maxFrame);
		return theSprite;
	}
	
	public function setToFrame(theSprite : FlxSprite, index : Int) : FlxSprite
	{
		theSprite.animation.frameIndex = index;
		return theSprite;
	}
}