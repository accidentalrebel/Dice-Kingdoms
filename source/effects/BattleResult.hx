package effects;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import objects.HexaTile;
import objects.Territory;
import states.GameState;

/**
 * ...
 * @author Karlo
 */
enum BattleResultType {
	ATTACK;
	DEFEND;
}
 
class BattleResult extends FlxSpriteGroup
{
	var battleLabel : FlxText;
	var battleSprite : FlxSprite;
	
	public function new(xPos : Float, yPos : Float, resultType : BattleResultType) 
	{	
		super(xPos, yPos);
		
		battleSprite = new FlxSprite(0, 0);
		
		var imageToUse : String = "";
		if ( resultType == BattleResultType.ATTACK )
			imageToUse = "assets/swords.png";
		else if ( resultType == BattleResultType.DEFEND )
			imageToUse = "assets/shield.png";		
		
		battleSprite.loadGraphic(imageToUse, false, false);
		
		battleLabel = new FlxText(0, 0, 100, "88", 18);
		battleLabel.font = GameState.DEFAULT_FONT;
		battleLabel.x = battleSprite.width / 2 - battleLabel.width / 2;
		battleLabel.y = battleSprite.height / 2 - battleLabel.height / 2;
		battleLabel.setBorderStyle(FlxText.BORDER_OUTLINE_FAST, 0, 1, 1);
		battleLabel.alignment = "center";
		
		this.cameras = [GameState.cameraManager.mainCamera];
		
		this.add(battleSprite);
		this.add(battleLabel);
		
		this.x = -100;
		this.y = -100;
		
		this.hide();
	}
	
	function hide() 
	{
		this.battleSprite.visible = false;
		this.battleLabel.visible = false;
	}
	
	function show()
	{
		this.battleSprite.visible = true;
		this.battleLabel.visible = true;
	}
	
	public function changeLabelText(labelText : String )
	{
		this.battleLabel.text = labelText;
	}
	
	public function hideLabel()
	{
		this.battleLabel.visible = false;
	}
	
	public function showLabel()
	{
		this.battleLabel.visible = true;
	}
	
	public function attachToTerritory(territoryNumber : Int)
	{	
		this.battleSprite.visible = true;
		var territoryToAttachTo : Territory = GameState.territoryManager.getTerritory(territoryNumber);
		this.setPosition(territoryToAttachTo.centerTile.x + HexaTile.TILE_WIDTH / 2 - battleSprite.width / 2, territoryToAttachTo.centerTile.y - 40);
	}
	
	public function setAsWinner() 
	{
		changeLabelText("WINNER");
	}
	
	public function setAsLoser() 
	{
		changeLabelText("LOSER");
	}
}