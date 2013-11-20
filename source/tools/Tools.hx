package tools;

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
	
	public static function randomMinMax(minValue : Int, maxValue : Int) : Int
	{
		return Std.int(minValue + Math.round((Math.random() * (maxValue - minValue))));
	}
	
	public static function shuffleArray<T>(arrayToShuffle : Array<T>) : Array<T>
	{
		var newArray : Array<T> = new Array<T>();
		
		while (arrayToShuffle.length > 0)
		{
			var pos : Int = Std.random(arrayToShuffle.length);
			
			newArray.push(arrayToShuffle[pos]);
			arrayToShuffle.splice(pos, 1);
		}
		
		return newArray;
	}
}