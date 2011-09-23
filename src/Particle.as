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
	
	public class Particle extends Entity
	{
		[Embed(source = 'assets/Misc/particle.png')] private const PARTICLE_ICON:Class;
		
		private var _velocity_modifier:Number = 8.0;
		private var _direction:Point;
		private var _alpha_amount:Number = 1.0;
		private var _alpha_modifier:Number = 0.05;
		private var _angle:Number = 0.0;
		private var _angle_modifier:Number = 10.0;
		
		private var _life_timer:Number = 0.0;
		private var _life_interval:Number = 2.0;
		
		public function Particle(dir:Point, pos:Point) 
		{
			_direction = dir;
			x = pos.x;
			y = pos.y;
			
			graphic = new Image( PARTICLE_ICON );
			
			if ( FP.random > 0.5 )
				_velocity_modifier *= -1;
		}
		
		override public function update():void
		{
			x += _velocity_modifier * _direction.x
			y += _velocity_modifier * _direction.y;
			
			_angle += _angle_modifier;
			_alpha_amount -= _alpha_modifier;
			var tmp_img:Image = new Image( PARTICLE_ICON );
			tmp_img.alpha = _alpha_amount;
			tmp_img.angle = _angle;
			graphic = tmp_img;
			
			_life_timer += FP.elapsed;
			if ( _life_timer >= _life_interval )
			{
				FP.world.remove( this );
			}
			
			super.update();
		}
		
	}

}