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
	
	public class Player extends Entity
	{
		[Embed(source = 'assets/Characters/player_temp.png')] private const PLAYER_ICON:Class;
		
		private var move_speed:Point;
		private var facing:int = 1; // 0 - LEFT, 1 - RIGHT
		
		private var _velocity:Point = new Point;
		private var _velocity_modifier:Number = 200;
		
		private var _gun:Gun = new Gun();
		private var _shot_timer:Number = 0.0;
		private var _can_shoot:Boolean = true;
		
		public var score:int = 0;
		
		public function Player() 
		{
			graphic = new Image( PLAYER_ICON );
			
			move_speed = new Point( 2.0, 2.0 );
			
			setHitbox(32, 32, 0, 0);
		}
		
		override public function update():void
		{	
			updateMovement();
			updateCollision();
			super.update();
		}
		
		private function updateMovement():void
		{
			var movement:Point = new Point;
			if ( Input.check(Key.UP) ) movement.y--;
			if ( Input.check(Key.DOWN) ) movement.y++;
			if ( Input.check(Key.LEFT) ) 
			{
				movement.x--;
				
				if ( facing == 1 )
				{
					facing = 0;
					
					var tmp_img:Image = new Image( PLAYER_ICON );
					tmp_img.flipped = true;
					graphic = tmp_img;
				}
			}
			if ( Input.check(Key.RIGHT) ) 
			{
				movement.x++;
				
				if ( facing == 0 )
				{
					facing = 1;
					
					tmp_img = new Image( PLAYER_ICON );
					graphic = tmp_img;
				}
			}
			
			_velocity.x = _velocity_modifier * FP.elapsed * movement.x;
			_velocity.y = _velocity_modifier * FP.elapsed * movement.y;
			
			if ( !_can_shoot )
			{
				_shot_timer += FP.elapsed;
				if ( _shot_timer >= _gun.shot_interval )
				{
					_can_shoot = true;
					_shot_timer = 0.0;
				}
			}
			
			if ( Input.check( Key.Z ) && _can_shoot )
			{
				_gun.shoot( new Point( -1, 0 ), new Point( x - 4, y ) );
				_can_shoot = false;
			} else if ( Input.check( Key.X ) && _can_shoot )
			{
				_gun.shoot( new Point( 1, 0 ), new Point( x + 4, y ) );
				_can_shoot = false;
			}
			
		}
		
		private function updateCollision():void
		{
			x += _velocity.x;
			
			if ( collide( "level", x, y ) )
			{
				if ( FP.sign( _velocity.x ) > 0 )
				{
					_velocity.x = 0;
					x = Math.floor( x / 32 ) * 32 + 32 - 32;
				} else
				{
					_velocity.x = 0;
					x = Math.floor( x / 32 ) * 32 + 32;
				}
			}
			
			y += _velocity.y;
			if ( collide( "level", x, y ) )
			{
				if ( FP.sign( _velocity.y ) > 0 )
				{
					_velocity.y = 0;
					y = Math.floor( y / 32 ) * 32 + 32 - 32;
				} else
				{
					_velocity.y = 0;
					y = Math.floor( y / 32 ) * 32 + 32;
				}
			}
		}
	}

}