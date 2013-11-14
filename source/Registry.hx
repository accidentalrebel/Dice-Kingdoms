package ;
import flixel.text.FlxText;
import flixel.util.FlxPoint;
import playArea.PlayArea;

/**
 * ...
 * @author 
 */
class Registry
{
	public static var colorList : Array<Int> = [ 0xFF0000, 0x00FF00, 0x0000FF, 0xFFFF00, 0x00FFFF, 0xFF00FF, 0x888888, 0xFFFFFF ];		
	public static var maxTerritories : Int = Math.floor(PlayArea.playAreaRows / 5) * Math.floor(PlayArea.playAreaCols / 5);	
	static public var territoryPerPlayer:Int;
	
	static public var initialArmyCount:Int = 20;	
	static public var maxArmyCountPerTerritory : Int = 8;
	
	static public var playAreaPadding : FlxPoint = new FlxPoint(15, 15);
	static public var playerIndicator : FlxText;
	
}