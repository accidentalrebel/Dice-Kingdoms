package misc;
import flixel.group.FlxGroup;
import flixel.text.FlxText;

/**
 * ...
 * @author Karlo
 */
class PlayerRow extends FlxGroup
{
	private var nameLabel 	: FlxText;
	private var aiLabel 	: FlxText;
	private var territoryCountLabel	: FlxText;

	public function new(xPos : Float, yPos : Float) 
	{
		super();
		
		nameLabel = new FlxText(xPos, yPos, 300, "Player Label", 14);
		add(nameLabel);
	}
	
}