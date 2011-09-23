package  
{
	import flash.utils.ByteArray;
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.masks.Grid;

	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.World;
	
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Level extends Entity
	{
		[Embed(source = 'assets/Tiles/wall1.png')] private const WALL1_ICON:Class;
		private var _tiles:Tilemap;
		private var _grid:Grid;
		
		public var levelData:XML;
		
		public function Level(xml:Class)
		{
			// setup tilemap
			_tiles = new Tilemap( WALL1_ICON, 800, 608, 32, 32 );
			graphic = _tiles;
			layer = 1;
			_grid = new Grid( 800, 608, 32, 32, 0, 0 );
			mask = _grid;
			
			loadLevel(xml);
			
			type = "level";
		}
		
		private function loadLevel(xml:Class):void
		{
			var rawData:ByteArray = new xml;
			var dataString:String = rawData.readUTFBytes( rawData.length );
			levelData = new XML(dataString);
			//trace(xmlData);
			
			var dataList:XMLList;
			var dataElement:XML;
			
			dataList  = levelData.OurTiles.tile;
			for each (dataElement in dataList )
			{
				_tiles.setTile( int(dataElement.@x) / 32, int(dataElement.@y) / 32, int(dataElement.@tx)/ 32 );
				_grid.setTile( int(dataElement.@x) / 32, int(dataElement.@y) / 32, int(dataElement.@tx)/ 32 == 0 );
			}
		}
		
	}

}