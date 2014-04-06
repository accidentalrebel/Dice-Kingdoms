package tools;
import flixel.FlxSprite;
import flixel.util.FlxPoint;
import flixel.util.FlxRect;
import states.GameState;

/**
 * ...
 * @author Karlo
 */
class Tools
{		
	public static function hardCopyArray<A>(arrayToCopy : Array<A>)
	{
		var newArray : Array<A> = new Array<A>();
		for ( item in arrayToCopy )
			newArray.push(item);
			
		return newArray;
	}
	
	public static function getBoundingBox(arrayToGoThrough : Array<Dynamic>) : FlxRect
	{
		var smallestValues : FlxPoint = new FlxPoint(9999, 9999);
		var largestValues : FlxPoint = new FlxPoint( -9999, -9999);
		
		// We go through each sprite and then we log the smallest and largest values
		// For example: If the current value is smaller than the recorded smallest value,
		// Then that means that the current value is smaller.
		for ( tSprite in arrayToGoThrough )
		{
			var sprite : FlxSprite = cast(tSprite, FlxSprite);
			if ( sprite.x < smallestValues.x )
				smallestValues.x = sprite.x;
				
			if ( sprite.y < smallestValues.y )
				smallestValues.y = sprite.y;
				
			if ( sprite.x + sprite.width > largestValues.x )
				largestValues.x = sprite.x + sprite.width;
				
			if ( sprite.y + sprite.height > largestValues.y )
				largestValues.y = sprite.y + sprite.height;
		}
		
		// We then calculate the bounding box
		return new FlxRect(smallestValues.x, smallestValues.y
			, largestValues.x - smallestValues.x, largestValues.y - smallestValues.y);
	}
}