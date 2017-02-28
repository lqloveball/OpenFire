package openFire 
{
	import com.greensock.TweenMax;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.*;
	import flash.net.*;
	
	/**
	 * ...
	 * @author maskim
	 */
	public class TopPanel extends Sprite 
	{
		public var listPanel:ListPanel;
		
		public function TopPanel() 
		{
			addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		private function addStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addStage);
			stage.addEventListener(Event.RESIZE, reSize);
			init()
			reSize()
		}
		
		private function reSize(e:Event=null):void 
		{
			if (!stage) return;
			bg.width = stage.stageWidth;
			this.x = this.y = 0;
			btn_set.x = stage.stageWidth - 50 - 4;
			listPanel.setSize(btn_set.x - listPanel.x - 4,20);
		}
		public function init():void {
			Tools.setButton(btn_set);
			btn_set.addEventListener(MouseEvent.CLICK,settings)
			listPanel = _listPanel;
			
		}
		/**
		 * 设置
		 * @param	e
		 */
		private function settings(e:MouseEvent):void 
		{
			
			
			AppControler.instance.root.addChild(AppControler.instance.root.setAppPanel)
		}
		
	}

}