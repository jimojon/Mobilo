package test {
	import com.mobilo.time.Tick;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.getTimer;

	/**
	 * @author jonas
	 * @date 22 juin 2011
	 */
	 [SWF(width="320", height="480", frameRate="60", backgroundColor="#f2f2f2")]
	public class TickTest extends Sprite {

		private var message1:TextField;
		private var message2:TextField;
		private var start1:int;
		private var start2:int;
		private var i:int = 0;
		private var j:int = 0;

		public function TickTest()
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
		}

		private function start(event : MouseEvent) : void {
			event.stopImmediatePropagation();
			stage.removeEventListener(MouseEvent.CLICK, start);
			message1.htmlText = "EnterFrame\n";
			message2.htmlText = "Tick\n";
			startTest1();
			startTest2();
		}

		public function startTest1():void {
			start1 = getTimer();
			addEventListener(Event.ENTER_FRAME, test1);
		}

		public function startTest2():void {
			start2 = getTimer();
			Tick.create(test2);
		}

		public function test1(event:Event):void {
			event.stopImmediatePropagation();
			var m:String = (getTimer()-start1)+"\n";
			message1.appendText(m);
			i++;
			if(i == 30)
				removeEventListener(Event.ENTER_FRAME, test1);
		}

		public function test2():void {
			var m:String = (getTimer()-start2)+"\n";
			message2.appendText(m);
			j++;
			if(j == 30)
				Tick.remove(test2);

		}
	}
}
