package openFire 
{
	import adobe.utils.MMExecute;
	import flash.display.*;
	import flash.events.*;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import flash.text.*;
	import flash.utils.*;
	import flash.net.*;
	import com.ixiyou.speUI.collections.MSprite;
	import com.ixiyou.utils.display.DisplayUtil
	import com.ixiyou.net.Cache
	/**
	 * 
	 * @author maskim
	 */
	public class ListPanel extends MSprite 
	{
		
		public function ListPanel() 
		{
			
			addEventListener(Event.ADDED_TO_STAGE,addStage)
		}
		
		private function addStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addStage);
		
			initUI();
		}
		
	
		 /**组件大小更新*/
		override public function upSize():void {
			
			if (listArr && listArr.length > 0) {
				for (var i:int = 0; i < listArr.length; i++) 
				{
					var temp:ListItem = listArr[i];
					temp.setSize(width>>0,temp.height)
				}
			}
			
			mcSelect.mcBg.width = width;
			mcSelect.mcTip.x = width - mcSelect.mcTip.width;
			mcSelect.textLabel.width = mcSelect.mcTip.x - 6;
			
			boxMask.width = bg.width = width>>0;
			
			//trace('upSize:',width)
			
		}
		private var bg:Sprite
		private var boxMask:Sprite
		private var box:Sprite
		private var showBox:Sprite
		private var showBool:Boolean = false;
		
		public function initUI():void {
			mcSelect.mouseChildren = false;
			mcSelect.buttonMode = true;
			mcSelect.addEventListener(MouseEvent.CLICK,selectFun)
			
			showBox = mcbox;
			bg = mcbox.bg
			box = mcbox.box;
			boxMask = mcbox.boxMask;
			box.mask=boxMask
			
			while (box.numChildren > 0) box.removeChildAt(0);
			
			removeChild(showBox)
			var data:String = AppControler.instance.jsflMMExecute('OpenFire.jsfl', 'initAppList');
			if (data) initAppList(data)
			else initAppList('')
			//if(ExternalInterface.available)ExternalInterface.addCallback("initAppList", initAppList); 
		}
		
		
		
		private function stageDown(e:MouseEvent):void 
		{
			var mc:DisplayObject = e.target as DisplayObject;
			if (box.contains(showBox)) {
				
			}else {
				
			}
			hit();
			stage.removeEventListener(MouseEvent.MOUSE_DOWN,stageDown)
		}
		
		public function hit():void {
			if (!stage) return;
			if (stage.contains(showBox)) stage.removeChild(showBox);
			showBool = false;
		}
		
		public function show():void {
			if (!stage) return;
			stage.addChild(showBox);
			stage.addEventListener(MouseEvent.MOUSE_DOWN,stageDown)
			var pt:Point = DisplayUtil.localToContent(new Point(), this, stage);
	
			showBox.x = pt.x;
			showBox.y = pt.y + mcSelect.height + 1;
			showBool = true;
		}
		
		private function selectFun(e:MouseEvent):void 
		{
			showBool = !showBool;
			if (showBool) show()
			else hit();
		}
		private var listArr:Array
		private var cache:Cache
		
		private function initAppList(value:String):void 
		{
			
			//MMExecute('fl.trace("initAppList ok swf")')
			DebugOutput.add('initAppList:', value);
			var data:Object
			if (value == '') {
				data = { arr:[
						{
						appUrl:"",
						appName:"SpeTools",
						appSwf:"",
						appXml:""
					}
				]}
			}else {
				data = Tools.json_decode(value);
			}
			
			var num:Number = data.arr.length;
			num=Math.min(num,5)
			bg.height = boxMask.height = num * new ListItem().bg.height;
			while (box.numChildren > 0) box.removeChildAt(0);
			showBox.addEventListener(MouseEvent.MOUSE_MOVE,showMove)
			
			
			listArr=new Array()
			for (var i:int = 0; i <  data.arr.length; i++) 
			{
				var temp:ListItem = new ListItem();
				temp.setData(data.arr[i]);
				box.addChild(temp);
				temp.y = i * temp.bg.height;
				listArr.push(temp);
				temp.addEventListener('upData',upSelectFun)
			}
			upData()
			
			cache=new Cache('openFire_md')
			_selectData = cache.getData('selectMenuObj');
			//trace(cache,_selectData)
			if (_selectData) {
				DebugOutput.add('上次选择:', _selectData.appName);
				for (i = 0; i <listArr.length ; i++) 
				{
					temp = listArr[i];
					if (_selectData.appName == temp.data.appName) {
						DebugOutput.add('选择上次选择:', _selectData.appName);
						upSelect(temp.data);
						return;
					}
				}
				temp = listArr[0];
				upSelect(temp.data);
			}else {
				for (i = 0; i <listArr.length ; i++) 
				{
					temp = listArr[i];
					if ('SpeTools' == temp.data.appName) {
						upSelect(temp.data);
						return;
					}
				}
				temp = listArr[0];
				//DebugOutput.add('第一次选择:', temp.data.appName);
				upSelect(temp.data);
			}
			
		}
		
		private function showMove(e:MouseEvent):void 
		{
			if (listArr.length <= 5) return;
			var num:Number=showBox.mouseY/boxMask.height
			box.y=(boxMask.height-box.height)*num>>0
		}
		private function upSelectFun(e:Event):void 
		{
			var temp:ListItem = e.target as ListItem;
			upSelect(temp.data);
		}
	
		
		public function upSelect(value:Object):void 
		{
			//trace('upSelect')
			_selectData = value
			cache.setData('selectMenuObj',_selectData)
			mcSelect.textLabel.text = value.appName;
			if (value.swf != "") {
				AppControler.instance.gotoPage(value.appName);
			}
			dispatchEvent(new Event('upData'));
		}
			private var _selectData:Object
		public function get selectData():Object 
		{
			return _selectData;
		}
		
		public function upData():void {
			resetSize()
		}
		
		
		
	}

}