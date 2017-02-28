package openFireUI 
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.*;
	import flash.net.*;
	import com.ixiyou.speUI.mcontrols.MovieHSlider
	/**
	 * 
	 * @author maskim
	 */
	public class MovieToTextInput extends Sprite 
	{
		private var skin:MovieClip
		private var _label:TextField
		public function MovieToTextInput(skin:MovieClip,defaultInfo:String='',formerly:Boolean = true, parentBool:Boolean=true) 
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
			skin.gotoAndStop(1);
			_label = skin.label;
			Tools.addDefaultInfo(label, defaultInfo);
			Tools.addTextMovieBg(label,skin)
		}
		
		public function get label():TextField 
		{
			return _label;
		}
		public function get text():String {
			return label.text;
		}
		public function set text(value:String):void {
			label.text = value;
		}
		
	}

}