package speTools 
{
	import adobe.utils.MMExecute;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.*;
	import flash.net.*;
	import openFireUI.MovieToTextInput;
	import com.ixiyou.speUI.mcontrols.TextInputCS5
	import openFireUI.MovieToComBox
	
	/**
	 * 
	 * @author maskim
	 */
	public class SpeToolsMain extends Sprite 
	{
		
		public var bg2:Sprite;
		public var bg:Sprite
		
		public function SpeToolsMain() 
		{
			bg2 = _bg2;
			bg = _bg;
			init();
			
		}
		
		private var btnLibrary:MovieClip;
		private var btnBatchName:MovieClip;
		private var btnImgSet:MovieClip;
		private var btnCoordinates:MovieClip;
		private var btnAlpha:MovieClip;
		private var btnInstanceName:MovieClip;
		private var btnLinkAs3:MovieClip;
		private var btnLinkAs2:MovieClip;
		private var btnCallJSAs3:MovieClip;
		private var btnCallJSAs2:MovieClip;
		
		private var btnCopyMovie:MovieClip;
		private var btnPasteMovie:MovieClip;
		private var btnRotate:MovieClip;
		
		private var textImgSetValue:TextInputCS5;
		private var textLibrary:MovieToTextInput;
		private var textBatchName:MovieToTextInput;
		private var textInstanceName:MovieToTextInput;
		private var comBoxImgSetType:MovieToComBox;
		private var comBoxImgSetSmooth:MovieToComBox;
		private var comBoxInstanceName:MovieToComBox;
		private var textArrangement360:TextInputCS5;
		private function init():void 
		{
			
			
			btnLibrary = Tools.setButton(_btnLibrary);
			btnBatchName = Tools.setButton(_btnBatchName);
			btnImgSet = Tools.setButton(_btnImgSet);
			btnCoordinates = Tools.setButton(_btnCoordinates);
			btnAlpha = Tools.setButton(_btnAlpha);
			btnInstanceName = Tools.setButton(_btnInstanceName);
			btnLinkAs3 = Tools.setButton(_btnLinkAs3);
			btnLinkAs2 = Tools.setButton(_btnLinkAs2);
			btnCallJSAs3 = Tools.setButton(_btnCallJSAs3);
			btnCallJSAs2 = Tools.setButton(_btnCallJSAs2);
			
			btnCopyMovie = Tools.setButton(_btnCopyMovie);
			btnPasteMovie = Tools.setButton(_btnPasteMovie);
			btnRotate = Tools.setButton(_btnRotate);
			
			
			
			
			btnLibrary.addEventListener(MouseEvent.CLICK,setLibrary)
			btnBatchName.addEventListener(MouseEvent.CLICK,setBatchName)
			btnImgSet.addEventListener(MouseEvent.CLICK,setImgFun)
			btnCoordinates.addEventListener(MouseEvent.CLICK,setCoordinates)
			btnAlpha.addEventListener(MouseEvent.CLICK,setAlphaText)
			btnInstanceName.addEventListener(MouseEvent.CLICK,setInstanceName)
			btnLinkAs3.addEventListener(MouseEvent.CLICK,setLinkAs3)
			btnLinkAs2.addEventListener(MouseEvent.CLICK,setLinkAs2)
			btnCallJSAs3.addEventListener(MouseEvent.CLICK,setCallJSAs3)
			btnCallJSAs2.addEventListener(MouseEvent.CLICK,setCallJSAs2)
			
			btnCopyMovie.addEventListener(MouseEvent.CLICK,copyMovie)
			btnPasteMovie.addEventListener(MouseEvent.CLICK,pasteMovie)
			btnRotate.addEventListener(MouseEvent.CLICK, setRotate)
			
			
			textLibrary = new MovieToTextInput(_textLibrary, '输入批量处理文件名');
			textBatchName = new MovieToTextInput(_textBatch, '输入批量命名');
			textInstanceName = new MovieToTextInput(_textInstanceName, '输入批量命名实力名');
			
			textArrangement360 = new TextInputCS5(_textArrangement360, 100);
			//textImgSetValue.maximum = 100;
			//textImgSetValue.minimum = 0;
			
			textImgSetValue = new TextInputCS5(_textImgSetValue, 100);
			textImgSetValue.maximum = 100;
			textImgSetValue.minimum = 0;
			
			comBoxImgSetType=new MovieToComBox(_comBoxImgSetType)
			comBoxImgSetSmooth=new MovieToComBox(_comBoxImgSetSmooth)
			comBoxInstanceName = new MovieToComBox(_comBoxInstanceName)
			
			comBoxImgSetType.data = ['png', 'jpg'];
			comBoxImgSetSmooth.data = ['true', 'false'];
			
			comBoxInstanceName.data=[{label:'横向',data:0},{label:'纵向',data:1}]
		}
		/**
		 * 360°排列元件
		 * @param	e
		 */
		private function setRotate(e:MouseEvent):void 
		{
			//trace('12121')
			AppControler.instance.jsflMMExecute("SpeTools/jsfl/arrangement360.jsfl", "setArrangement",textArrangement360.value);
		}
		/**
		 * 粘帖动画
		 * @param	e
		 */
		private function pasteMovie(e:MouseEvent):void 
		{
			AppControler.instance.jsflMMExecute("SpeTools/jsfl/coyeAndPasteMovie.jsfl", "pasteMotion_spe");
		}

		/**
		 * 拷贝动画
		 * @param	e
		 */
		private function copyMovie(e:MouseEvent):void 
		{
			AppControler.instance.jsflMMExecute("SpeTools/jsfl/coyeAndPasteMovie.jsfl", "copyMotion_spe");
		}
		/**
		
		
		/**
		 * 设置 call JS as2
		 * @param	e
		 */
		private function setCallJSAs2(e:MouseEvent):void 
		{
			AppControler.instance.jsflMMExecute("SpeTools/jsfl/addCallJs.jsfl", "addAs2")
		}
		/**
		 * 设置 call JS as3
		 * @param	e
		 */
		private function setCallJSAs3(e:MouseEvent):void 
		{
			//trace('setCallJSAs3')
			AppControler.instance.jsflMMExecute("SpeTools/jsfl/addCallJs.jsfl", "addAs3")
		}
		/**
		 * 设置连接as2
		 * @param	e
		 */
		private function setLinkAs2(e:MouseEvent):void 
		{
			AppControler.instance.jsflMMExecute("SpeTools/jsfl/addLink.jsfl", "addAs2")
		}
		/**
		 * 设置连接as3
		 * @param	e
		 */
		private function setLinkAs3(e:MouseEvent):void 
		{
			AppControler.instance.jsflMMExecute("SpeTools/jsfl/addLink.jsfl", "addAs3")
		}
		/**
		 *  设置实例名
		 * @param	e
		 */
		private function setInstanceName(e:MouseEvent):void 
		{
			AppControler.instance.jsflMMExecute("SpeTools/jsfl/ruleExamplesName.jsfl", "init",textInstanceName.text,comBoxInstanceName.select.data);
			
		}
		/**
		 * 设置text透明滤镜
		 * @param	e
		 */
		private function setAlphaText(e:MouseEvent):void 
		{
			AppControler.instance.jsflMMExecute("SpeTools/jsfl/textAlpha.jsfl", "init");
			//AppControler.instance.jsflMMExecute("OpenFire.jsfl", "test");
			
		}
		/**
		 * 坐标取整
		 * @param	e
		 */
		private function setCoordinates(e:MouseEvent):void 
		{
			AppControler.instance.jsflMMExecute("SpeTools/jsfl/positionInteger.jsfl", "init");
		}
		/**
		 * 设置图片质量
		 * @param	e
		 */
		private function setImgFun(e:MouseEvent):void 
		{
			//trace(comBoxImgSetType.select.value,comBoxImgSetSmooth.select.value,textImgSetValue.value)
			AppControler.instance.jsflMMExecute("SpeTools/jsfl/setPictureQuality.jsfl", "setBitmapData",comBoxImgSetType.select.value,comBoxImgSetSmooth.select.value,textImgSetValue.value);
		}
		/**
		 * 批量命名库文件
		 * @param	e
		 */
		private function setBatchName(e:MouseEvent):void 
		{
			AppControler.instance.jsflMMExecute("SpeTools/jsfl/processingName.jsfl", "init", textBatchName.text);
		}
		/**
		 * 整理库
		 * @param	e
		 */
		private function setLibrary(e:MouseEvent):void 
		{
			AppControler.instance.jsflMMExecute("SpeTools/jsfl/processingPSD.jsfl","init",textLibrary.text);
		}
		
	}

}