package
{
	import adobe.utils.MMExecute;
	import com.ixiyou.utils.StringUtil
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.Capabilities;
	public class AppControler extends EventDispatcher
	{
		private static var _instance:AppControler
		public static function get instance():AppControler {
			if (!_instance)_instance = new AppControler()
			return _instance
		}

		private var _root:MovieClip
		public function AppControler()
		{
			
		}

		public function get root():MovieClip
		{
			return _root;
		}

		public function set root(value:MovieClip):void
		{
			if(_root)return;
			_root = value;
			root.stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDown)
			DebugOutput.add('OpenFire version: v0.04')
			DebugOutput.setStage(_root.stage);
			DebugOutput.add('flashPlay:' + Capabilities.version, ' >>isDebugger:' + Capabilities.isDebugger, " >>playerType : " + Capabilities.playerType );
		}
		
		private function keyDown(e:KeyboardEvent):void 
		{
			//trace(e.keyCode)
			//shift+d
			if (e.shiftKey && e.keyCode == 68) {
				//trace('jsflDebug')
				jsflDebug = !jsflDebug;
				if(Capabilities.playerType=='External'){
					MMExecute("fl.trace('" + "jsflDebug:"+jsflDebug+ "')")
				}
			}
		}
		
		
		public function getPlayerType():String{
			return Capabilities.playerType
		}
		public function get execute():Boolean{
			if(Capabilities.playerType=='External')return true;
			else return false;
		}

		/**
		 *这个框架windowsSWF下的路径
		 * @return
		 *
		 */
		public  function get toolsFileURL():String{
			return 'OpenFire';
		}
		public var jsflDebug:Boolean = false 
		public function alertByJSFL(value:String):String {
			if (Capabilities.playerType == 'External') {
				var data:String = MMExecute('alert(' + '"' + value + '"' + ')')
				return data;
			}
			return 'null';
		}
		/**
		 * 进行jsfl方法调用
		 * @param value
		 * @param fun
		 * @param avalue
		 * @return
		 *
		 */
		public function jsflMMExecute(value:String, fun:String = '', ...avalue):*{
			var bool:Boolean=false
			if(Capabilities.playerType=='External')bool=true
			var data:Object
			var comString:String = ''
			var str:String=''
			if (value.lastIndexOf('.jsfl') == -1) value = value + '.jsfl';
			if (fun == '') {
				comString='fl.runScript(fl.configURI+"WindowSWF/' + toolsFileURL + '/' + value + '")'
			}
			else if (avalue.length >= 1) {
				str='fl.runScript(fl.configURI+"WindowSWF/'+toolsFileURL+'/'+value+'","'+fun+'"'
				for (var i:int = 0; i < avalue.length; i++)
				{
					str=str+',"'+avalue[i]+'"'
				}
				str += ')';
				comString=str
				
			}
			else {
				str = 'fl.runScript(fl.configURI+"WindowSWF/' + toolsFileURL + '/' + value + '","' + fun + '")'
				comString=str
			}
			
			var returnStr:String = '请求jsfl命令:' + comString 
			if(jsflDebug)DebugOutput.add(returnStr);
			if(jsflDebug&&bool)MMExecute("fl.trace('" + returnStr + "')")
			
			data=MMExecute(comString)
			returnStr= '返回:' + data;
			if(jsflDebug)DebugOutput.add(returnStr);
			if(jsflDebug&&bool)MMExecute("fl.trace('" + returnStr + "')")
			
			return data;
		}
		
		public function gotoPage(value:String):void {
				if (!root) return;
				root.gotoPage(value);
		}
	}
}