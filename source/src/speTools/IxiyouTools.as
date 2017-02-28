package speTools 
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
	public class IxiyouTools extends MovieClip 
	{
		private var btnSetSLAs3:MovieClip;
		private var btnSetBtnAs3:MovieClip;
		
		public function IxiyouTools() 
		{
			btnSetSLAs3 = Tools.setButton(_btnSetSLAs3);
			btnSetBtnAs3 = Tools.setButton(_btnSetBtnAs3);
			btnSetSLAs3.addEventListener(MouseEvent.CLICK,setSLAs3)
			btnSetBtnAs3.addEventListener(MouseEvent.CLICK,setBtnAs3)
		}
		/*
		 * 设置按钮
		 * @param	e
		 */
		private function setBtnAs3(e:MouseEvent):void 
		{
			
		}
		/**
		 * 设置滚动条组件
		 * @param	e
		 */
		private function setSLAs3(e:MouseEvent):void 
		{
			
		}
	}

}