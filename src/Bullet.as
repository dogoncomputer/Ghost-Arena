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
	
	public class Bullet extends Entity
	{
		[Embed(source = 'assets/Bullets/bullet_temp.png')] private const BULLET_ICON:Class;
		
		private var _velocity_modifier:Number = 8.0;
		private var _direction:Point;
		private var _angle:Number = 0.0;
		private var _angle_modifier:Number = 10.0;
		
		public function Bullet( dir:Point ) 
		{
			_direction = dir;
			
			graphic = new Image( BULLET_ICON );
			
			setHitbox( 32, 32, 0, 0 );
			
			type = "bullet";
		}
		
		override public function update():void
		{
			x += _velocity_modifier * _direction.x;
			y += _velocity_modifier * _direction.y;
			
			if ( collide( "level", x, y ) )
			{
				FP.world.remove( this );
				
				var i:int = 0;
				for ( i = 0; i < 6; i++ )
				{
					var tmp_particle:Particle = new Particle( new Point( FP.random * 1 - 1, FP.random * 1 - 1 ), new Point( x, y ) );
					FP.world.add( tmp_particle );
				}
			}
			
			_angle += _angle_modifier;
			var tmp_img:Image = new Image( BULLET_ICON );
			tmp_img.angle = _angle;
			graphic = tmp_img;
			
			super.update();
		}
		
	}

}