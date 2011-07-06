package com.mobilo.bench {
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldType;

	/**
	 * @author jonas
	 * @date 4 juil. 2011
	 */
	[SWF(width="320", height="480", frameRate="60", backgroundColor="#f2f2f2")]
	public class BenchView extends Sprite {

		private var textfield:TextField;

		public function BenchView() {
			Bench.output = output;
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
		}

		private function output(result : String) : void {
			textfield = new TextField();
			addChild(textfield);
			textfield.text = result;
			textfield.type = TextFieldType.INPUT;
			textfield.multiline = true;
			textfield.wordWrap = true;
			textfield.width = stage.stageWidth;
			textfield.height = stage.stageHeight;

			// Any way to put text into IOS clipboard ?
		}
	}
}


