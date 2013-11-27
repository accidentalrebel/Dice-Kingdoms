package ;
import flixel.text.FlxText;
import flixel.util.FlxPoint;
import layers.BattleLayer;
import layers.GameGUILayer;
import layers.PlayAreaLayer;
import managers.GameplayManager;
import managers.TerritoryManager;

/**
 * ...
 * @author 
 */
class Registry
{
												//TODO: Make an enum for the colors
												// RED		GREEN	   BLUE		 YELLOW   L.BLUE	PINK	   ORANGE	WHITE   
	public static var colorList : Array<Int> = [ 0xFF3333, 0x33FF33, 0x3333FF, 0xFFFF33, 0x33FFFF, 0xFF33FF, 0xFF6600, 0xFFFFFF ];		
	public static var maxTerritories : Int = Math.floor(PlayAreaLayer.PLAY_AREA_ROWS / 5) * Math.floor(PlayAreaLayer.PLAY_AREA_COLUMNS / 5);	
	static public var playAreaPadding : FlxPoint = new FlxPoint(15, 15);
	
	static public var territoryPerPlayer:Int;	
	static public var initialArmyCount:Int = 20;	
	static public var maxArmyCountPerTerritory : Int = 8;	
	
	static public var gameGUI:GameGUILayer;
	static public var playArea:PlayAreaLayer;
	static public var battleLayer: BattleLayer;
	static public var territoryManager:TerritoryManager;
	static public var gameplayManager:GameplayManager;
	
}