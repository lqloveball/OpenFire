package speTools 
{
	import com.greensock.TweenMax;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.*;
	import flash.net.*;
	import com.ixiyou.speUI.mcontrols.MovieToVScrollBar
	/**
	 * ...
	 * @author maskim
	 */
	public class SpeTools extends Sprite 
	{
		
		public function SpeTools() 
		{
			addEventListener(Event.ADDED_TO_STAGE,addStage)
		}
		private var main:SpeToolsMain
		private var mainMask:Sprite
		private var sl:MovieToVScrollBar;
		private function addStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addStage);
			if (parent is Stage) stage.addEventListener(Event.RESIZE, reSize);
			else parent.addEventListener(Event.RESIZE, reSize);
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			main = _main
			mainMask=_mainMask
			main.mask = mainMask;
			mainMask.x = mainMask.y = 0;
			
			sl = new MovieToVScrollBar(_sl, null, true, true);
			sl.content = main;
			
			reSize();
		}
		
		
		
		private function reSize(e:Event = null ):void 
		{
			
			if (!parent) return;
			if (!stage) return;
			var _w:Number
			var _h:Number
			if (parent is Stage) {
				_w = stage.stageWidth;
				_h = stage.stageHeight;
			}else {
				_w = parent.width;
				_h =parent.height;
			}
			//trace(_w,_h)
			main.bg2.width = _w;
			main.bg.width = _w;
			
			
			sl.height  = _h;
			sl.x = _w - 5;
			
			mainMask.width = _w;
			mainMask.height = _h;
			sl.upSlider();
		}
		
	}

}