package ui;
import flixel.addons.ui.FlxButtonPlus;
import states.GameState;

/**
 * ...
 * @author Karlo
 */
class CustomButton extends FlxButtonPlus
{
	private var BUTTON_FONT_SIZE : Float = 15;
	
	public function new(X:Int, Y:Int, Callback:Dynamic, ?Params:Array<Dynamic>, ?Label:String, Width:Int = 100, Height:Int = 20)
	{
		super(X, Y, Callback, Params, Label, Width, Height);
		
		this.textNormal.font 	= this.textHighlight.font 	= GameState.DEFAULT_FONT;
		this.textNormal.y 		= this.textHighlight.y 		+= (this.height / 2 - BUTTON_FONT_SIZE);
		this.textNormal.size 	= this.textHighlight.size 	= BUTTON_FONT_SIZE;
	}	
}