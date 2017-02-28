package openFireUI 
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import flash.text.*;
	import flash.utils.*;
	import flash.net.*;
	import flash.utils.*;
	import com.ixiyou.utils.ReflectUtil;
	import com.ixiyou.utils.display.DisplayUtil
	/**
	 * ...
	 * @author maskim
	 */
	public class MovieToComBox extends Sprite 
	{
		private var box:Sprite
		private var skin:MovieClip;
		private var itemClass:Class
		private var item_h:Number;
		private var label:TextField
		public function MovieToComBox(skin:MovieClip,formerly:Boolean = true, parentBool:Boolean=true) 
		{
			if (formerly) {
				this.x = skin.x
				this.y = skin.y
				skin.x = skin.y = 0;
			}
			if (skin.parent && parentBool) {
				skin.parent.addChild(this)
				this.name=skin.name
			}
			this.skin = skin;
			addChild(skin)
			box = new Sprite()
			skin.removeChild(skin.box);
			item_h = skin.box.height;
			itemClass = ReflectUtil.getClass(skin.box);
			
			label = skin.label;
			
			while (box.numChildren > 0) box.removeChildAt(0);
			addEventListener(MouseEvent.MOUSE_DOWN,downFun)
		}
		
		private function downFun(e:MouseEvent):void 
		{
			
			var pt:Point = DisplayUtil.localToContent(new Point(0, (skin.height + 1) >> 0), this, stage);
			box.x=pt.x
			box.y=pt.y
			stage.addChild(box);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, stageDown)
		}
		
		private function stageDown(e:MouseEvent):void 
		{
			if (!this.contains(e.target as DisplayObject)) {
				if (box.parent) box.parent.removeChild(box)
				stage.removeEventListener(MouseEvent.MOUSE_DOWN, stageDown)
				return
			}
			
		}
		
		
		public function set data(value:Array):void 
		{
			itemArr = new Array();
			for (var i:int = 0; i < value.length; i++) 
			{
				var temp:Object = value[i];
				addItem(temp);
			}
			dispatchEvent(new Event('addAllData'))
			select = itemArr[0].data;
		}
		
		public function get data():Array 
		{
			var _data:Array = new Array();
			for (var i:int = 0; i < itemArr.length; i++) 
			{
				_data.push(MovieClip(itemArr[i]).data);
			}
			return _data;
		}
		public function getItems():Array {
			return itemArr;
		}
		private var itemArr:Array = new Array()
		/**
		 * 添加
		 * @param	value
		 */
		public function addItem(value:Object):void {
			var mc:MovieClip = new itemClass() as MovieClip;
			var obj:Object
			if (value is String) {
				obj = { label:value,value:value }
			}else if(value is Number){
				obj = { label:value+'',value:value }
			}else if(value is Boolean){
				obj = { label:value+'',value:value }
			}else {
				obj = value;
				
				if (obj.label == null) {
					trace('wu label')
					obj.label = '[Object]';
				}
			}
			mc.data = obj;
			itemArr.push(mc);
			if (mc.label) mc.label.text = obj.label;
			Tools.setButton(mc);
			mc.addEventListener(MouseEvent.MOUSE_DOWN,mcClick)
			upItemShow()
			dispatchEvent(new Event('addItem'))
		}
		
	
		/**
		 * 删除
		 * @param	value
		 */
		public function removeItem(value:Object):void {
			for (var i:int = 0; i < itemArr.length; i++) 
			{
				if (value == itemArr[i].data) {
					
					//_selectItem = itemArr[i] as MovieClip;
					//dispatchEvent(new Event('upData'))
					var mc:MovieClip= itemArr[i] as MovieClip
					mc.removeEventListener(MouseEvent.MOUSE_DOWN,mcClick)
					itemArr.splice(i, 1);
					if (select == value) {
						if (itemArr[0]) select = itemArr[0].data
						else select = null;
					};
					upItemShow()
					dispatchEvent(new Event('removeItem'))
					return;
				}
			}
			
		}
		private function mcClick(e:MouseEvent):void 
		{
			var mc:MovieClip = e.target as MovieClip;
			select = mc.data;
		}
		private var _select:Object
		/**
		 * 选择
		 */
		public function get select():Object 
		{
			return _select;
		}
		
		public function set select(value:Object):void 
		{
			
			if (_select == value) return;
			if (value == null) {
				_select = null;
				_selectItem = null;
				upItemShow()
				dispatchEvent(new Event('upData'));
				return;
			}
			for (var i:int = 0; i < itemArr.length; i++) 
			{
				if (value == itemArr[i].data) {
					_select = value;
					_selectItem = itemArr[i] as MovieClip;
					upItemShow()
					dispatchEvent(new Event('upData'));
					return;
				}
			}
			
		}
		private var _selectItem:MovieClip
		/**
		 * 当前选择按钮项目
		 */
		public function get selectItem():MovieClip 
		{
			return _selectItem;
		}
		public function upItemShow():void {
			
			
			while (box.numChildren > 0) box.removeChildAt(0);
			
			if (select) label.text = select.label;
			else label.text = 'null';
			if (!itemArr) return;
			for (var i:int = 0; i < itemArr.length; i++) 
			{
				var mc:MovieClip = itemArr[i];
				box.addChild(mc)
				mc.y = item_h * i;
			}
		}
		/**
		 * 返回选择项目 根据位置
		 * @param	value
		 * @return
		 */
		public function getItemByIndex(value:uint):Object {
			var obj:Object = null;
			if (itemArr && itemArr[value]) obj = itemArr[value].data;
			return obj;
		}
		
	}

}