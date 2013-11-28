package effects;
import flixel.addons.plugin.taskManager.AntTaskManager;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import tools.ARFade;

/**
 * ...
 * @author Karlo
 */
class AddArmyEffect extends FlxText
{
	inline public static var EFFECT_DURATION = 2;
	
	var taskManager : AntTaskManager;
	
	public function new()
	{
		super(0, 0, 40, "+0", 14);
		this.alignment = "center";
	}
	
	public function init(xPos : Float = 0, yPos : Float = 0, str : String) 
	{
		this.revive();
		
		this.alpha = 1;
		this.x = xPos;
		this.y = yPos;
		this.text = "+" + str;
		
		if ( taskManager != null )
			taskManager.clear();
			
		taskManager = new AntTaskManager();
		taskManager.addInstantTask(this, FlxTween.linearMotion, [this, xPos, yPos, xPos, yPos - 20, EFFECT_DURATION, true]);
		taskManager.addPause(EFFECT_DURATION / 4);
		taskManager.addInstantTask(this, fadeOut);
		taskManager.addPause(EFFECT_DURATION / 1.3);
		taskManager.addInstantTask(this, this.kill);
	}
	
	function fadeOut()
	{
		var fadeScript : ARFade = cast(Registry.gameGUI.recycle(ARFade), ARFade);
		fadeScript.init(this, 0, EFFECT_DURATION / 1.3);			
	}
}