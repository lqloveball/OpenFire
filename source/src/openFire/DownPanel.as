package openFire 
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.*;
	import flash.net.*;
	
	/**
	 * ...
	 * @author maskim
	 */
	public class DownPanel extends Sprite 
	{
		
		public function DownPanel() 
		{
			addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		private function addStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addStage);
			stage.addEventListener(Event.RESIZE, reSize);
		}
		
		private function reSize(e:Event=null):void 
		{
			if (!stage) return;
			bg.width = stage.stageWidth;
			this.x = 0;
			this.y = stage.stageHeight - bg.height;
		}
	}

}