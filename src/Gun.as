package  
{
	import flash.geom.Point;
	import net.flashpunk.FP;
	import net.flashpunk.Entity;

	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Gun
	{
		public var shot_interval:Number = 0.3;
		
		public function Gun() 
		{
			
		}
		
		public function shoot(direction:Point, start:Point):void
		{
			var bullet:Bullet = new Bullet( direction );
			bullet.x = start.x;
			bullet.y = start.y;
			
			FP.world.add( bullet );
		}
		
	}

}