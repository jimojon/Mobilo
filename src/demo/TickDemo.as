package test {
	import flash.display.Shape;
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
	dynamic public class TickTest extends Sprite {

		private var message1:TextField;
		private var message2:TextField;

		private var start1:int;
		private var start2:int;
		private var k:int = 0;
		private var j:int = 0;

		private var _sh1:Shape = new Shape();
		private var _sh2:Shape = new Shape();
		private var _sh3:Shape = new Shape();
		private var _sh4:Shape = new Shape();

		public function TickTest()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			var i:uint;
			var t:TextField;

			message1 = new TextField();
			message1.width = 160;
			message1.height = 20;
			message1.mouseEnabled = false;
			message1.text = "EnterFrame : tap to start";
			addChild(message1);

			message2 = new TextField();
			message2.x = 160;
			message2.width = 160;
			message2.height = 20;
			message2.mouseEnabled = false;
			message2.text = "Tick : tap to start";
			addChild(message2);

			for(i=1; i<=4; i++){
				t = this["e"+i] = new TextField();
				t.border = true;
				t.width = 40;
				t.height = 460;
				t.x = (i-1)*40;
				t.y = 20;
				t.mouseEnabled = false;
				addChild(t);
			}

			for(i=1; i<=4; i++){
				t = this["t"+i] = new TextField();
				t.border = true;
				t.width = 40;
				t.height = 460;
				t.x = 160+(i-1)*40;
				t.y = 20;
				t.mouseEnabled = false;
				addChild(t);
			}

			stage.addEventListener(MouseEvent.CLICK, start);
		}

		private function start(event : MouseEvent) : void
		{
			event.stopImmediatePropagation();

			if(event.stageX<=160){
				message1.htmlText = "EnterFrame";
				startTest1();
			}else{
				message2.htmlText = "Tick";
				startTest2();
			}
		}

		public function startTest1():void {
			stopTest2();
			start1 = getTimer();
			_sh1.addEventListener(Event.ENTER_FRAME, enterFrame1);
			_sh2.addEventListener(Event.ENTER_FRAME, enterFrame2);
			_sh3.addEventListener(Event.ENTER_FRAME, enterFrame3);
			_sh4.addEventListener(Event.ENTER_FRAME, enterFrame4);
		}

		public function stoptTest1():void {
			_sh1.removeEventListener(Event.ENTER_FRAME, enterFrame1);
			_sh2.removeEventListener(Event.ENTER_FRAME, enterFrame2);
			_sh3.removeEventListener(Event.ENTER_FRAME, enterFrame3);
			_sh4.removeEventListener(Event.ENTER_FRAME, enterFrame4);
		}

		private function enterFrame4(event : Event) : void {
			event.stopImmediatePropagation();
			_enterFrame(4);
		}

		private function enterFrame3(event : Event) : void {
			event.stopImmediatePropagation();
			_enterFrame(3);
		}

		private function enterFrame2(event : Event) : void {
			event.stopImmediatePropagation();
			_enterFrame(2);
		}

		private function enterFrame1(event : Event) : void {
			event.stopImmediatePropagation();
			_enterFrame(1);
			k++;
			if(k == 30)
				stoptTest1();
		}

		private function _enterFrame(col:uint):void {
			var m:String = (getTimer()-start1)+"\n";
			(this["e"+col] as TextField).appendText(m);

		}

		public function startTest2():void {
			stoptTest1();
			start2 = getTimer();
			Tick.create(tick1);
			Tick.create(tick2);
			Tick.create(tick3);
			Tick.create(tick4);
		}

		public function stopTest2():void {
			Tick.remove(tick1);
			Tick.remove(tick2);
			Tick.remove(tick3);
			Tick.remove(tick4);
		}

		public function tick1():void {
			tick(1);
			j++;
			if(j == 30)
				stopTest2();
		}
		public function tick2():void {
			tick(2);
		}
		public function tick3():void {
			tick(3);
		}
		public function tick4():void {
			tick(4);
		}

		public function tick(col:uint):void {
			var m:String = (getTimer()-start2)+"\n";
			(this["t"+col] as TextField).appendText(m);
		}
	}
}
