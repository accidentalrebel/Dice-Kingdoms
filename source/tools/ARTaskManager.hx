package tools;
import flixel.addons.plugin.taskManager.AntTaskManager;
import flixel.FlxG;

/**
 * ...
 * @author Karlo
 */
class ARTaskManager extends AntTaskManager
{
	/**
	 * Dictates whether this task manager is affected by pause or not.
	 */
	public var isPauseProof : Bool = false;

	public function new(Cycle:Bool = false, ?OnComplete:Void->Void)
	{
		super(Cycle, OnComplete);
	}
	
	override public function update():Void 
	{
		if ( !isPauseProof && FlxG.paused )
			return;
		
		super.update();
	}
}