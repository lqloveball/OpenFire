package 
{
	import com.ixiyou.speUI.collections.MSprite;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.*;
	import flash.net.*;
	import openFire.*;
	import com.greensock.loading.*;
	import com.greensock.events.*;
	import com.ixiyou.managers.AlertManager
	import com.ixiyou.utils.StringUtil
	/**
	 * 
	 * @author maskim
	 */
	public class OpenFire extends MovieClip 
	{
		
		public function OpenFire() 
		{
			addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		private function addStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addStage);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			AlertManager.getInstance().stage = stage;
			stage.addEventListener(Event.RESIZE, reSize);
			init()
			reSize()
		}
		
		private function reSize(e:Event=null):void 
		{
			if (!stage) return;
			
			box.setSize(stage.stageWidth, stage.stageHeight - topPanel.bg.height - downPanel.bg.height)
			//trace('box reSize:',box.width,box.height)
			boxMask.x=box.x = 0;
			boxMask.y=box.y = topPanel.bg.height;
			boxMask.width = box.width;
			boxMask.height = box.height;
			
		}
		
		private var boxMask:Sprite=new Sprite()
		public var box:MSprite = new MSprite()
		
		public var topPanel:TopPanel
		public var downPanel:DownPanel
		public var setAppPanel:SetAppPanel
		public function init():void {
			
			
			
			addChild(box);
			boxMask.graphics.beginFill(0)
			boxMask.graphics.drawRect(0,0,10,10)
			addChild(boxMask);
			box.mask = boxMask;
			
			topPanel=_topPanel
			downPanel = _downPanel
			setAppPanel = _setAppPanel
			if(contains(setAppPanel)) removeChild(setAppPanel)
			
			AppControler.instance.root = this;
			
			if(topPanel.listPanel.selectData)AppControler.instance.gotoPage(topPanel.listPanel.selectData.appName);
			
		}
	
		private var _page:String = '';
		public function get page():String { return _page }
		private var loader:SWFLoader;
		
		public function gotoPage(value:String):void {
			if (_page == value) return;
			_page = value;
			if (loader&&loader.status != LoaderStatus.COMPLETED) {
				loader.paused =true
			}
			//while (box.numChildren > 0) box.removeChildAt(0);
			loader = new SWFLoader('OpenFire/'+page+"/"+page+".swf", {onComplete:onComplete,onError:onError});
			loader.load()
		}
		private function onComplete(e:*):void 
		{
			while (box.numChildren > 0) box.removeChildAt(0);
			var mc:DisplayObject = DisplayObjectContainer(loader.rawContent);
			//trace("onComplete:",mc)
			box.addChild(mc);
		}
		
		private function onError(e:*):void 
		{
			
		}
		
		
	}

}