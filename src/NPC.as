package  
{
	import net.flashpunk.FP;
	import net.flashpunk.Entity;

	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	
	public class NPC extends Entity
	{
		[Embed(source = 'assets/Characters/player_temp.png')] private const PLAYER_ICON:Class;
		//[Embed(source = 'assets/Characters/ghost_temp.png')] private const PLAYER_ICON:Class;
		
		private var facing:int = 1; // 0 - LEFT, 1 - RIGHT
		public var dialog:String = "Hello this is a test.";
		
		public function NPC() 
		{
			graphic = new Image( PLAYER_ICON );
			setHitbox(32, 32, 0, 0);
			type = "npc";
		}
		
		override public function update():void
		{	
			
		}
		
	}

}