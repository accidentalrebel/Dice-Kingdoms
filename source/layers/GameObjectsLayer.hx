package layers;
import flixel.group.FlxGroup;

/**
 * ...
 * @author Karlo
 */
class GameObjectsLayer extends FlxGroup
{

	public function new() 
	{
		super();
	}
	
	public function reset()
	{
		for ( member in _members )
		{
			member.destroy();
		}
		
		clear();
	}
}