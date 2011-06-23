package test {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.utils.getTimer;


	/**
	 * @author jonas
	 * @date 23 juin 2011
	 */
	[SWF(width="320", height="480", frameRate="60", backgroundColor="#f2f2f2")]
	public class AdobeTimerTest extends Sprite
	{
		private var message:TextField;
		private var startTime:int;
		private var repeat:int = 30;
		private var delay:int = 20000;

		public function AdobeTimerTest()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			message = new TextField();
			message.width = 160;
			message.height = 480;
			message.mouseEnabled = false;
			message.text = "Tap to start";
			addChild(message);

			stage.addEventListener(MouseEvent.CLICK, start);
		}

		private function start(event : MouseEvent) : void {
			event.stopImmediatePropagation();
			stage.removeEventListener(MouseEvent.CLICK, start);
			message.htmlText = "Timer()\n";

			var timer:Timer = new Timer(delay, repeat);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			startTime = getTimer();
			timer.start();
		}

		public function onTimer(event:TimerEvent):void {
			event.stopImmediatePropagation();
			var m:String = (getTimer()-startTime)+"\n";
			message.appendText(m);
		}

	}
}
