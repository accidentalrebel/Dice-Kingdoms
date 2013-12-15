package effects;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;

/**
 * ...
 * @author Karlo
 */
class BattleResult extends FlxSprite
{
	var battleLabel : FlxSprite;
	
	public function new(tParent : FlxSpriteGroup, xPos, yPos) 
	{
		super(xPos, yPos);
		
		this.loadGraphic("assets/soldier.png", false, false);
		
		battleLabel = new FlxText(0, 0, 31, "88", 18);
		battleLabel.x = xPos + this.width / 2 - battleLabel.width / 2;
		battleLabel.y = yPos + this.height / 2 - battleLabel.height / 2;
		tParent.add(this);
		tParent.add(battleLabel);
	}
	
	/**
	 * Attaches this battle result to the specified territory.
	 * Handles the positioning.
	 * @param	territoryNumber
	 */
	public function attachToTerritory(territoryNumber : Int)
	{
		
	}
}