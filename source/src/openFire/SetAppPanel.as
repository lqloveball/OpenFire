package openFire 
{
	import adobe.utils.MMExecute;
	import com.greensock.TweenMax;
	import com.ixiyou.net.Cache;
	import flash.display.*;
	import flash.events.*;
	import flash.system.Capabilities;
	import flash.text.*;
	import flash.utils.*;
	import flash.net.*;
	
	/**
	 * 设置工具面板
	 * @author maskim
	 */
	public class SetAppPanel extends Sprite 
	{
		
		public function SetAppPanel() 
		{
			addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		private function addStage(e:Event):void 
		{
			this.mouseChildren = true;
			this.mouseEnabled = true
			this.alpha = 0;
			this.x = stage.stageWidth;
			this.y = 0;
			TweenMax.to(this,.3,{alpha:1,x:0})
			//removeEventListener(Event.ADDED_TO_STAGE, addStage);
			stage.addEventListener(Event.RESIZE, reSize);
			init()
			reSize()
		}
		
		private function reSize(e:Event=null):void 
		{
			if (!stage) return;
			top.width=bg.width = stage.stageWidth;
			bg.height = stage.stageHeight;
			//this.x = this.y = 0;
			btn.x = stage.stageWidth - btn.width - 4;
			btn.y = 4;
			
		}
		private var cacher:Cache
		public function init():void {
			cacher = new Cache('setAppPanel');
			Tools.setButton(btn);
			btn.addEventListener(MouseEvent.CLICK, breakHome)
			Tools.setButton(btn_install)
			btn_install.addEventListener(MouseEvent.CLICK, installFun)
			
			Tools.setButton(btn_selectUpInstallFile)
			Tools.setButton(btn_upInstall)
			btn_selectUpInstallFile.addEventListener(MouseEvent.CLICK, selectUpInstallFile);
			btn_upInstall.addEventListener(MouseEvent.CLICK, upInstall);
			if (cacher.getData('upInstallFile')) {
				text_upInstall.text = cacher.getData('upInstallFile');
			}else {
				text_upInstall.text = '';
			}
		}
		
		private function upInstall(e:MouseEvent):void 
		{
			if (Capabilities.playerType == 'External') {
				if (text_upInstall.text == ''||text_upInstall.text == 'null') {
					MMExecute("alert('选择安装文件 *.jsfl')")
					return;
				}
				//MMExecute("fl.runScript(alert('选择安装文件 *.jsfl'))")
				var caller:String="FLfile.exists('" + text_upInstall.text + "')"
				var rdata:String = MMExecute(caller);
				DebugOutput.add('文件是否存在：', caller, rdata);
				if (rdata != 'false') {
					MMExecute('fl.runScript("'+text_upInstall.text+'")');
				}else {
					MMExecute("fl.runScript(alert('安装文件 *.jsfl 不存在'))")
				}
				
			}
		}
		
		private function selectUpInstallFile(e:MouseEvent):void 
		{
			var file:String=''
			if(Capabilities.playerType=='External')file= MMExecute('fl.browseForFileURL("open","Select a UpInstall.jsfl","*.jsfl")');
			cacher.setData('upInstallFile', file);
			text_upInstall.text = file;
		}
		
		private function installFun(e:MouseEvent):void 
		{
			var file:String =''
			if(Capabilities.playerType=='External')file= MMExecute('fl.browseForFileURL("open","Select a install.jsfl","*.jsfl")');
			if (file != 'null'&&file!=''){
				if(Capabilities.playerType=='External')MMExecute('fl.runScript("'+file+'")');
			}
		}
		
		private function breakHome(e:MouseEvent):void 
		{
			this.mouseChildren = false;
			this.mouseEnabled = false;
			this.alpha = 1;
			TweenMax.to(this,.3,{alpha:0,onComplete:onComplete,x:stage.stageWidth})
		}
		
		private function onComplete():void 
		{
			if (parent)parent.removeChild(this);
		}
		
		
	}

}