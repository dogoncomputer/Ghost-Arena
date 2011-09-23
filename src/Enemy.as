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
	
	public class Enemy extends Entity
	{
		[Embed(source = 'assets/Characters/ghost.png')] private const ENEMY_ICON:Class;
		
		private var _velocity_modifier:Number;
		private var _direction:Point;
		
		public function Enemy(pos:Point, dir:Point) 
		{
			x = pos.x;
			y = pos.y;
			
			_velocity_modifier = FP.random * 1 + 1;
			if ( FP.random > 0.5 )
				_velocity_modifier *= -1;
			
			_direction = dir;
			
			graphic = new Image( ENEMY_ICON );
			
			setHitbox( 32, 32, 0, 0 );
		}
		
		override public function update():void
		{
			super.update();
			
			x += _velocity_modifier * _direction.x;
			y += _velocity_modifier * _direction.y;
			
			if ( x < 0 || x > FP.screen.width || y < 0 || y > FP.screen.height )
			{
				FP.world.remove( this );
			}
			
			var b:Bullet = collide( "bullet", x, y ) as Bullet;
			
			if ( b )
			{
				FP.world.remove( this );
				FP.world.remove( b );
				
				var i:int = 0;
				for ( i = 0; i < 6; i++ )
				{
					var tmp_particle:Particle = new Particle( new Point( FP.random * 1 - 1, FP.random * 1 - 1 ), new Point( x, y ) );
					FP.world.add( tmp_particle );
				}
			}
		}
		
	}

}