package tools;

/**
 * ...
 * @author Karlo
 */
class Tools
{

	public function new() 
	{
		
	}
	
	public static function hardCopyArray<A>(arrayToCopy : Array<A>)
	{
		var newArray : Array<A> = new Array<A>();
		for ( item in arrayToCopy )
			newArray.push(item);
			
		return newArray;
	}
	
	public static function randomMinMax(minValue : Float, maxValue : Float)
	{
		return minValue + Std.random(maxValue - minValue);
	}
}