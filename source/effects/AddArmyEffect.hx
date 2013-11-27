package effects;
import flixel.addons.plugin.taskManager.AntTaskManager;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author Karlo
 */
class AddArmyEffect extends FlxText
{
	inline public static var EFFECT_DURATION = 1;
	
	var taskManager : AntTaskManager;
	
	public function new()
	{
		super(0, 0, 40, "+0", 14);
		this.alignment = "center";
	}
	
	public function init(xPos : Float = 0, yPos : Float = 0, str : String) 
	{
		this.revive();
		
		this.x = xPos;
		this.y = yPos;
		this.text = str;
		
		if ( taskManager != null )
			taskManager.clear();
			
		taskManager = new AntTaskManager(false);
		taskManager.addInstantTask(this, FlxTween.linearMotion, [this, xPos, yPos, xPos, yPos - 20, 1, true], true);
		taskManager.addPause(EFFECT_DURATION);
		taskManager.addInstantTask(this, this.kill);
	}
}