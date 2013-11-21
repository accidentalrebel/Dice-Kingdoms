package ;
import flixel.text.FlxText;
import flixel.util.FlxPoint;
import layers.BattleLayer;
import layers.GameGUILayer;
import layers.PlayAreaLayer;
import managers.TerritoryManager;

/**
 * ...
 * @author 
 */
class Registry
{
	public static var colorList : Array<Int> = [ 0xFF0000, 0x00FF00, 0x0000FF, 0xFFFF00, 0x00FFFF, 0xFF00FF, 0x000000, 0xFFFFFF ];		
	public static var maxTerritories : Int = Math.floor(PlayAreaLayer.playAreaRows / 5) * Math.floor(PlayAreaLayer.playAreaCols / 5);	
	static public var territoryPerPlayer:Int;
	
	static public var initialArmyCount:Int = 20;	
	static public var maxArmyCountPerTerritory : Int = 8;
	
	static public var playAreaPadding : FlxPoint = new FlxPoint(15, 15);
	
	static public var gameGUI:GameGUILayer;
	static public var playArea:PlayAreaLayer;
	static public var battleLayer: BattleLayer;
	static public var territoryManager:TerritoryManager;
	
}