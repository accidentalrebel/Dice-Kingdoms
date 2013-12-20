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
	
	public function new() 
	{
		landStamp = new FlxSprite(0, 0);
		landStamp.loadGraphic("assets/hexaTerrain.png", false, false, HexaTile.TILE_WIDTH, HexaTile.TILE_HEIGHT);
	}
	
	public function getRandomLand() : FlxSprite
	{
		landStamp.animation.frameIndex = FlxRandom.intRanged(3, 8);
		return landStamp;
	}
}