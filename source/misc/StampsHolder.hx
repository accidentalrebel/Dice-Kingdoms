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
	public var landStamp : FlxSprite;
	public var boundaryStamp : FlxSprite;
	
	public function new() 
	{
		landStamp = new FlxSprite(0, 0);
		landStamp.loadGraphic("assets/hexaTerrain.png", false, false, HexaTile.TILE_WIDTH, HexaTile.TILE_HEIGHT);
		
		boundaryStamp = new FlxSprite(0, 0);
		boundaryStamp.loadGraphic("assets/boundaryLines.png", false, false, HexaTile.TILE_WIDTH, HexaTile.TILE_HEIGHT);
	}
	
	public function randomizeFrame(theSprite : FlxSprite) : FlxSprite
	{
		theSprite.animation.frameIndex = FlxRandom.intRanged(3, 8);
		return theSprite;
	}
	
	public function setToFrame(theSprite : FlxSprite, index : Int) : FlxSprite
	{
		theSprite.animation.frameIndex = index;
		return theSprite;
	}
}