package test {
	import com.mobilo.time.Timeout;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;


	/**
	 * @author jonas
	 * @date 16 juin 2011
	 */
	[SWF(width="320", height="480", frameRate="60", backgroundColor="#f2f2f2")]
	public class TimeoutTest extends Sprite
	{
		private var message1:TextField;
		private var message2:TextField;
		private var start1:int;
		private var start2:int;
		private var iteration:int = 30;
		private var delay:int = 100;

//		var o:Object;

		public function TimeoutTest()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			message1 = new TextField();
			message1.width = 160;
			message1.height = 480;
			message1.mouseEnabled = false;
			message1.text = "Tap to start";
			addChild(message1);

			message2 = new TextField();
			message2.x = 160;
			message2.width = 160;
			message2.height = 480;
			message2.mouseEnabled = false;
			addChild(message2);

			stage.addEventListener(MouseEvent.CLICK, start);
			//start(null);

//			o = {};
//			o.test3 = function(s:String){
//				var m:String = (getTimer()-start2)+"\n";
//				message2.appendText(m);
//			}

		}

		private function start(event : MouseEvent) : void {
			event.stopImmediatePropagation();
			stage.removeEventListener(MouseEvent.CLICK, start);
			message1.htmlText = "setTimeout()\n";
			message2.htmlText = "Timeout.create()\n";
			startTest1();
			startTest2();
		}

		public function startTest1():void {
			var i:uint;
			var n:uint = 0;
			start1 = getTimer();
			for(i=1; i<=iteration; i++){
				n = i*delay;
				setTimeout(test1, n, "A "+n+" ms delay - ");
			}
		}

		public function startTest2():void {
			var i:uint;
			var n:uint = 0;
			start2 = getTimer();

//			Timeout.create(test2, 500, "test01 500 - ");
//			Timeout.create(test2, 100, "test02 100 - ");

			Timeout.clear(3);

			for(i=1; i<=iteration; i++){
				n = i*delay;
				Timeout.create(test2, n, "A "+n+" ms delay - ");
			}

			Timeout.clear(3);
			Timeout.clear(3);
			Timeout.clear(3);
		}

		public function test1(s:String):void {
			var m:String = s+(getTimer()-start1)+"\n";
			message1.appendText(m);
		}

		public function test2(s:String):void {
			var m:String = s+(getTimer()-start2)+"\n";
			message2.appendText(m);
		}
	}
}
