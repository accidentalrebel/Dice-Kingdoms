package misc;

/**
 * ...
 * @author 
 */
class PlayerColor
{
	inline public static var RED : Int = 0xFF3333;
	inline public static var GREEN : Int = 0x33FF33;
	inline public static var BLUE : Int = 0x3333FF;
	inline public static var YELLOW : Int = 0xFFFF33;
	inline public static var LIGHT_BLUE : Int = 0x33FFFF;
	inline public static var PINK : Int = 0xFF33FF;
	inline public static var ORANGE : Int = 0xFFA800;
	inline public static var WHITE : Int = 0xFFFFFF;

	public static var colorList : Array<Int> = [ PlayerColor.RED, PlayerColor.GREEN, PlayerColor.BLUE, PlayerColor.YELLOW
		, PlayerColor.LIGHT_BLUE, PlayerColor.PINK, PlayerColor.ORANGE, PlayerColor.WHITE ];	
	
	public function new() 
	{
		
	}
	
}