package test {
	import com.mobilo.time.Timeout;

	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.utils.getTimer;

	/**
	 * @author jonas
	 * @date 6 juil. 2011
	 */
	public class ForInIncrement extends Sprite {

		public function ForInIncrement()
		{
			Timeout.create(test, 2000);
		}

		private function test():void {
			var start:int = getTimer();
			for (var i : uint = 0; i < 1000000000; i++) {
				var a : uint = i;
			}
			var time:int = getTimer()-start;
			var text:TextField = new TextField();
			text.border = true;
			text.text = time.toString()+" ms";
			addChild(text);
		}
	}
}
