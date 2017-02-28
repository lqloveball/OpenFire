package speTools 
{
	import adobe.utils.MMExecute;
	import flash.display.*;
	import flash.events.*;
	import flash.system.Capabilities;
	import flash.text.*;
	import flash.utils.*;
	import flash.net.*;
	import openFireUI.MovieToTextInput;
	
	/**
	 * ...
	 * @author maskim
	 */
	public class ProjectManagement extends MovieClip 
	{
		private var fla:MovieToTextInput;
		private var bin:MovieToTextInput;
		private var swc:MovieToTextInput;
		private var other:MovieToTextInput;
		private var otherCode:MovieToTextInput;
		private var src:MovieToTextInput;
		
		public function ProjectManagement() 
		{
			fla = new MovieToTextInput(mc_fla, '输入');
			bin = new MovieToTextInput(mc_bin, '输入');
			swc = new MovieToTextInput(mc_swc, '输入');
			other = new MovieToTextInput(mc_other, '输入');
			otherCode = new MovieToTextInput(mc_otherCode, '输入');
			src = new MovieToTextInput(mc_src, '输入');
			
			fla.label.text = 'fla';
			src.label.text='src'
			bin.label.text = 'bin';
			swc.label.text = 'libs';
			other.label.text = 'other';
			otherCode.label.text = 'otherCode';
			
			Tools.setButton(btn_select)
			Tools.setButton(btn_create)
			Tools.setButton(btn_flaSet)
			Tools.setButton(btn_copyOther)
			
			textProject.text = '选择项目路径';
			btn_select.addEventListener(MouseEvent.CLICK, selectFile);
			btn_create.addEventListener(MouseEvent.CLICK, createFun)
			
			btn_flaSet.addEventListener(MouseEvent.CLICK, flaSetFun);
			btn_copyOther.addEventListener(MouseEvent.CLICK,copyOtherFun)
		}
		
		private function copyOtherFun(e:MouseEvent):void 
		{
			if (textProject.text == '' || textProject.text == 'null' || textProject.text == '选择项目路径') {
				AppControler.instance.alertByJSFL('选择项目路径');
				return;
			}
			var url:String=textProject.text
			if(url.lastIndexOf('/')!=(url.length-1)){
				url=url+'/'
			}
			url = url + otherCode.text;
			if(url.lastIndexOf('/')!=(url.length-1)){
				url=url+'/'
			}
			AppControler.instance.jsflMMExecute("SpeTools/jsfl/ProjectManagement.jsfl","copyOtherCode",url);
		}
		
		private function flaSetFun(e:MouseEvent):void 
		{
			AppControler.instance.jsflMMExecute("SpeTools/jsfl/ProjectManagement.jsfl", "setFlaByConfig",src.text,swc.text,bin.text,otherCode.text);
		}

		/**
		 * 选择项目文件夹
		 * @param	e
		 */
		private function selectFile(e:MouseEvent):void 
		{
			
			var url:String = AppControler.instance.jsflMMExecute("SpeTools/jsfl/ProjectManagement.jsfl", "browseFolder");
			//AppControler.instance.alertByJSFL(url);
			if (url == 'null') {
				textProject.text = "选择项目路径";
			}else {
				textProject.text = url;
			}
		}
		private function createFun(e:MouseEvent):void 
		{
			
			if (textProject.text == '' || textProject.text == 'null' || textProject.text == '选择项目路径') {
				AppControler.instance.alertByJSFL('选择项目路径');
				return;
			}
			if (!Tools.getDefaultBool(fla.label)) {
				AppControler.instance.alertByJSFL('设置fla目录');
				return;
			}
			if (!Tools.getDefaultBool(src.label)) {
				AppControler.instance.alertByJSFL('设置src目录');
				return;
			}
			if (!Tools.getDefaultBool(bin.label)) {
				AppControler.instance.alertByJSFL('设置bin目录');
				return;
			}
			if (!Tools.getDefaultBool(other.label)) {
				AppControler.instance.alertByJSFL('设置other目录');
				return;
			}
			if (!Tools.getDefaultBool(swc.label)) {
				AppControler.instance.alertByJSFL('设置swc目录');
				return;
			}
			if (!Tools.getDefaultBool(otherCode.label)) {
				AppControler.instance.alertByJSFL('设置otherCode目录');
				return;
			}
			
			var url:String = textProject.text;
			//AppControler.instance.alertByJSFL(MMExecute("FLfile.exists('"+url+'/'+fla.text+"')"))
			if(MMExecute("FLfile.exists('"+url+'/'+fla.text+"')")=='false')MMExecute('FLfile.createFolder("'+url+'/'+fla.text+'")')
			if(MMExecute("FLfile.exists('"+url+'/'+src.text+"')")=='false')MMExecute('FLfile.createFolder("'+url+'/'+src.text+'")')
			if(MMExecute("FLfile.exists('"+url+'/'+bin.text+"')")=='false')MMExecute('FLfile.createFolder("'+url+'/'+bin.text+'")')
			if(MMExecute("FLfile.exists('"+url+'/'+other.text+"')")=='false')MMExecute('FLfile.createFolder("'+url+'/'+other.text+'")')
			if(MMExecute("FLfile.exists('"+url+'/'+swc.text+"')")=='false')MMExecute('FLfile.createFolder("'+url+'/'+swc.text+'")')
			if(MMExecute("FLfile.exists('"+url+'/'+otherCode.text+"')")=='false')MMExecute('FLfile.createFolder("'+url+'/'+otherCode.text+'")')
			
		}
	}

}