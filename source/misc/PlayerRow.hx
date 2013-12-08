package misc;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;

/**
 * ...
 * @author Karlo
 */
class PlayerRow extends FlxSprite
{
	private var nameLabel 	: FlxText;
	private var aiLabel 	: FlxText;
	private var territoryCountLabel	: FlxText;
	private var parent:FlxSpriteGroup;

	public function new(tParent : FlxSpriteGroup, xPos : Float, yPos : Float) 
	{
		super();
		
		parent = tParent;
		nameLabel = new FlxText(xPos, yPos, 300, "Player Label", 14);
		
		parent.add(nameLabel);
	}
	
}