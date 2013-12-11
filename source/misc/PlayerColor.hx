package misc;
import flixel.util.FlxArrayUtil;

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
	inline public static var AQUA : Int = 0x33FFFF;
	inline public static var PINK : Int = 0xFF33FF;
	inline public static var ORANGE : Int = 0xFFA800;
	inline public static var WHITE : Int = 0xFFFFFF;

	public static var colorList : Array<Int> = [ PlayerColor.RED, PlayerColor.GREEN, PlayerColor.BLUE, PlayerColor.YELLOW
		, PlayerColor.AQUA, PlayerColor.PINK, PlayerColor.ORANGE, PlayerColor.WHITE ];	
	
	static public function shuffle() 
	{
		colorList = FlxArrayUtil.shuffle(colorList, colorList.length * 2);
	}
	
	static public function getColorAsString(colorValue : Int) : String
	{
		switch ( colorValue )
		{
			case RED: return "Red";
			case GREEN: return "Green";
			case BLUE: return "Blue";
			case YELLOW: return "Yellow";
			case AQUA: return "Aqua";
			case PINK: return "Pink";
			case ORANGE: return "Orange";
			case WHITE: return "White";
		}
		
		return "Invalid";
	}
}