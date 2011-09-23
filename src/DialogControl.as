package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.Screen;
	
	/**
	 * ...
	 * @author Jacob
	 */
	public class DialogControl extends Entity
	{
		public var dialoglist:Array;
		private var madetextline:Boolean = false;
		private var widthmod:Number = 0;
		private var heightmod:Number = 0;
		
		private var blinkind:Number = 0;
		private var textind:Number = 0;
		
		public function DialogControl()
		{
			dialoglist = new Array();
			layer = -100;
		}
		
		public function addDialog(message:String):void
		{
			dialoglist.push(message);
			if (dialoglist.length == 1)
			{
				updateText();
			}
			
		}
		
		private function nextDialog():void
		{
			if (dialoglist.length <= 0)
				return;
			
			dialoglist.splice(0, 1);
			textind = 0;
			updateText();
		}
		
		private function updateText():void
		{
			if (dialoglist.length > 0)
			{
				
				//textobj.SetText(dialoglist[0]);
			}
			else
			{
				//textobj.SetText("");
			}
		}
		
		override public function update():void
		{
			if (dialoglist.length > 0) {
				if (widthmod < 1)
					widthmod = Math.max(.1,Math.min(widthmod +.15, 1));
				else if (heightmod < 1)
					heightmod = Math.max(.1,Math.min(heightmod +.15, 1));
				else 
				{
					var indadd:Number = .5;
					if (Input.check(Key.X))
						indadd *= 2;
					textind = Math.min(textind + indadd, dialoglist[0].length);
				}
				
				blinkind += .05;
				if (blinkind > 2)
					blinkind -= 2;
				
				if(Input.pressed(Key.X))
				{
					if(textind >= dialoglist[0].length)
						nextDialog();
				}
			}
			else 
			{
				if (widthmod > 0)
					widthmod = Math.max(widthmod -.15, 0);
				else if (heightmod > 0)
					heightmod = Math.max(heightmod -.15, 0);
				
				if (heightmod < .1)
					heightmod = 0
				if (widthmod < .1)
					widthmod = 0
				
				blinkind = 1;
				textind = 0;
			}
		}
		
		override public function render():void
		{
			var width:int = FP.screen.width / 2;
			var height:int = FP.screen.height / 4;
			
			width *= widthmod;
			height *= heightmod;
			
			var x1:int = (FP.screen.width - width) / 2;
			var y1:int = FP.screen.height * (3 / 4) - height / 2;
			
			var xborder:int = 1 + 9 * widthmod;
			var yborder:int = 1 + 9 * heightmod;
			
			if (widthmod > 0 || heightmod > 0)
			{
				Draw.rect(x1 - xborder, y1 - yborder, width + xborder*2, height + yborder*2);
				Draw.rect(x1 - xborder + 1, y1 - yborder + 1, width + xborder*2 - 2, height + yborder*2 - 2, 0);
			}
			if (widthmod >= 1 && heightmod >= 1 && dialoglist.length > 0)
			{
				Text.size = 32;
				var ttext:String = dialoglist[0];
				ttext = ttext.slice(0, textind);
				Draw.graphic(new Text(ttext, x1, y1, width, height));
				
				if (textind >= dialoglist[0].length)
				{
					if (blinkind >= 1)
					{
						Draw.rect(x1 + width - xborder - 16, y1 + height - yborder - 16, 16, 16);
						Draw.rect(x1 + width - xborder - 12, y1 + height - yborder - 12, 8, 8, 0);
					}
					else
						Draw.rect(x1 + width - xborder - 14, y1 + height - yborder - 14, 12, 12);
				}
			}
		}
		
	}
	
}