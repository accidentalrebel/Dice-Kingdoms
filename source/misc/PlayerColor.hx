package misc;
import flixel.util.FlxArrayUtil;

/**
 * ...
 * @author 
 */
class PlayerColor
{
	inline public static var RED 	: Int = 0xFF0000;
	inline public static var GREEN 	: Int = 0x00FF00;
	inline public static var BLUE 	: Int = 0x0000FF;
	inline public static var YELLOW : Int = 0xFFFF00;
	inline public static var AQUA 	: Int = 0x00FFFF;
	inline public static var PINK 	: Int = 0xFF00FF;
	inline public static var ORANGE : Int = 0xFF5500;
	inline public static var WHITE 	: Int = 0xCCCCCC;

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