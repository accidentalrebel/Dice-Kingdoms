package ui;
import flixel.addons.ui.FlxButtonPlus;
import states.GameState;

/**
 * ...
 * @author Karlo
 */
class CustomButton extends FlxButtonPlus
{
	public function new(X:Int, Y:Int, Callback:Dynamic, ?Params:Array<Dynamic>, ?Label:String, Width:Int = 100, Height:Int = 20)
	{
		super(X, Y, Callback, Params, Label, Width, Height);
		
		this.textNormal.font = GameState.DEFAULT_FONT;
		this.textNormal.size = 15;
		
		this.textHighlight.font = GameState.DEFAULT_FONT;
		this.textHighlight.size = 15;
	}	
}