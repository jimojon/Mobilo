package com.mobilo.bench {
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldType;

	/**
	 * @author jonas
	 * @date 4 juil. 2011
	 */
	public class BenchView extends Sprite {

		private var textfield:TextField;

		public function BenchView() {
			Bench.output = output;
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
		}

		private function output(result : String) : void {
			textfield = new TextField();
			textfield.selectable = true;
			textfield.type = TextFieldType.INPUT;
			textfield.width = stage.stageWidth;
			textfield.height = stage.stageHeight;
			textfield.text = result;

			addChild(textfield);

			Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, textfield.text);
		}

	}
}
