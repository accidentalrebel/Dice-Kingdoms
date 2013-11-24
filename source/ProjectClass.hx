package;

import flash.Lib;
import flixel.FlxG;
import flixel.FlxGame;
import states.MenuState;
	
class ProjectClass extends FlxGame
{	
	public function new()
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;
		var ratioX:Float = stageWidth / 800;
		var ratioY:Float = stageHeight / 600;
		var ratio:Float = Math.min(ratioX, ratioY);
		
		super(Math.ceil(stageWidth / ratio), Math.ceil(stageHeight / ratio), MenuState, 1, 60, 60);
		
		trace("stageWidth " + stageWidth + " stageHeight " + stageHeight);
		trace("ratioX " + ratioX + " ratioY " + ratioY + " ratio " + ratio);
		trace("FlxG.width " + FlxG.width + " FlxG.height " + FlxG.height);
	}
}
