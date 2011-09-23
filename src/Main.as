package
{
	import net.flashpunk.Engine;

	import net.flashpunk.FP;

	public class Main extends Engine
	{
		public function Main()
		{
			super(832, 608, 60, false);
			
			FP.console.enable();
			FP.world = new Arena;
		}

		override public function init():void
		{
		}
		
		override public function update():void
		{
			
			if (Assets.dialog.dialoglist.length > 0)
			{
				//FP.world.active = false;
				Assets.dialog.update();
			}
			else
			{
				super.update();
			}
		}
	}
}