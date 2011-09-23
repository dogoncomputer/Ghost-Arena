package  
{
	import flash.geom.Point;
	import net.flashpunk.FP;
	
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.World;
	
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Arena extends World
	{
		[Embed(source = "tesetLevel.oel", mimeType = "application/octet-stream")] private static const DEFAULT_MAP:Class;
		
		private var _spawn_points:Array = new Array;
		
		public function Arena() 
		{
			var level:Level = new Level(DEFAULT_MAP);
			
			var dataList:XMLList;
			var dataElement:XML;
			
			dataList = level.levelData.objects.playerstart;
			for each (dataElement in dataList )
			{
				Assets.player.x = int( dataElement.@x );
				Assets.player.y = int( dataElement.@y );
				
				add( Assets.player );
			}
			dataList = level.levelData.objects.spawnpoint;
			for each (dataElement in dataList )
			{
				_spawn_points.push( new Point( int( dataElement.@x ), int ( dataElement.@y ) ) );
			}
			
			trace( _spawn_points.length );
			
			add( level );
			add(Assets.dialog);
		}
		
		override public function update():void
		{
			super.update();
			
			if ( Input.pressed( Key.SPACE ) )
			{
				Assets.player.score += 1;
			}
			
			if ( Input.pressed( Key.U ) )
			{
				remove( Assets.player );
				FP.world = new Arena;
			}
			
			if ( Input.pressed( Key.D ) )
			{
				Assets.dialog.addDialog(FP.random.toString());
			}
			
			if ( FP.random > 0.95 )
			{
				var point_index:Number = FP.random * 3;
				if ( FP.random > 0.5 )
				{
					add( new Enemy( _spawn_points[ Math.floor( point_index ) ], new Point( FP.random * 1 - 1, FP.random * 1 - 1 ) ) );
				} else
				{
					add( new Enemy( _spawn_points[ Math.ceil( point_index ) ], new Point( FP.random * 1 - 1, FP.random * 1 - 1 ) ) );
				}
				
			}
		}
		
	}

}