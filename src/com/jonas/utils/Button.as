package com.jonas.utils {
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	/**
	 * @author Jonas Monnier
	 * @date Apr 18, 2012
	 */
	public class Button extends Sprite {
		private var _label:TextField;
		public var data:Object;
		
		public function Button(label:String) {
			buttonMode = true;
			_label = new TextField();
			_label.mouseEnabled = false;
			_label.autoSize = TextFieldAutoSize.LEFT;
			_label.x = 10;
			addChild(_label);
			this.label = label;
		}
		
		public function set label(label:String):void {
			_label.htmlText = label;
			graphics.beginFill(0xCCCCCC);
			graphics.drawRect(0, 0, _label.width+20, _label.height);
			graphics.endFill();
		}
	}
}
