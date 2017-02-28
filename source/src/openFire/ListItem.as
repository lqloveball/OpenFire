package openFire 
{
	import adobe.utils.MMExecute;
	import com.ixiyou.speUI.collections.MSprite;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.*;
	import flash.net.*;
	
	/**
	 * ...
	 * @author maskim
	 */
	public class ListItem extends MSprite 
	{
		
		public function ListItem() 
		{
			label.text = '';
			bg.gotoAndStop(1)
			this.mouseChildren = false;
			this.buttonMode = true;
			this.addEventListener(MouseEvent.MOUSE_OVER, mOver)
			this.addEventListener(MouseEvent.MOUSE_OUT, mOut)
			this.addEventListener(MouseEvent.MOUSE_DOWN,mClick)
		}
		
		private function mClick(e:MouseEvent):void 
		{
			dispatchEvent(new Event('upData'))
		}
		
		private function mOut(e:MouseEvent):void 
		{
			Tools.movieFrame(bg,1)
		}
		
		private function mOver(e:MouseEvent):void 
		{
			Tools.movieFrame(bg,'end')
		}
		private var _data:Object
		/**
		 * 
		 * @param	value
		 * var temp={
				appUrl:appUrl,
				appName:appName,
				appSwf:appSwf,
				appXml:appXml
			};
		 */
	
		public function setData(value:Object):void {
			_data=value
			label.text = data.appName;
		}
		override public function upSize():void {
			//trace('item:',width)
			this.bg.width = this.width;
			label.width = this.width - 20;
		}
		
		public function get data():Object 
		{
			return _data;
		}
	}

}