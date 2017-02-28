package movieToDivMovie 
{
	import adobe.utils.MMExecute;
	import flash.display.*;
	import flash.events.*;
	import flash.system.Capabilities;
	import flash.text.*;
	import flash.utils.*;
	import flash.net.*;
	import com.ixiyou.net.Cache;
	/**
	 * 
	 * @author maskim
	 */
	public class MovieToDivMovie extends MovieClip 
	{
		private var cacher:Cache;
		
		public function MovieToDivMovie() 
		{
			
			if (stage)addStage()
			else addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		private function addStage(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addStage);
			init();
			
		}
		public function init():void {
			cacher = new Cache('MovieToDivMovieConfig');
			Tools.setButton(mcSelectJSFL);
			Tools.setButton(mcRunJSFL);
			mcSelectJSFL.addEventListener(MouseEvent.CLICK,selectJSFL)
			mcRunJSFL.addEventListener(MouseEvent.CLICK, runJSFL)
			if (cacher.getData('flatodiv_jsfl')) {
				text_jsflUrl.text = cacher.getData('flatodiv_jsfl');
			}else {
				text_jsflUrl.text = '';
			}
		}
		
		private function runJSFL(e:MouseEvent):void 
		{
			if (Capabilities.playerType == 'External') {
				if (text_jsflUrl.text == ''||text_jsflUrl.text == 'null') {
					MMExecute("alert('选择脚本文件 *.jsfl')")
					return;
				}
				//MMExecute("fl.runScript(alert('选择安装文件 *.jsfl'))")
				var caller:String="FLfile.exists('" + text_jsflUrl.text + "')"
				if (caller != 'false') {
					MMExecute('fl.runScript("'+text_jsflUrl.text+'")');
				}else {
					MMExecute("fl.runScript(alert('脚本文件 *.jsfl 不存在'))")
				}
				
			}
		
		}
		
		private function selectJSFL(e:MouseEvent):void 
		{
			var file:String=''
			if(Capabilities.playerType=='External')file= MMExecute('fl.browseForFileURL("open","Select a UpInstall.jsfl","*.jsfl")');
			cacher.setData('flatodiv_jsfl', file);
			text_jsflUrl.text = file;
		}
		
	}

}