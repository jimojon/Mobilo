package test {
	import com.mobilo.bench.Bench;
	import com.mobilo.bench.BenchView;

	import flash.display.Sprite;

	/**
	 * @author jonas
	 * @date 29 juin 2011
	 */
	[SWF(width="320", height="480", frameRate="60", backgroundColor="#f2f2f2")]
	public class BenchTest extends BenchView {

		private var loops:int = 1000000;

		public function BenchTest() {
			super();
			Bench.push(readObjectWithBracket, 'Test bracket syntax on object (read)', 5);
			Bench.push(readObjectWithDot, 'Test dot syntax on object (read)', 5);
			Bench.push(pushSpriteInArray, 'Test how GC works - 10000 Sprite in an Array', 5);
			Bench.push(readObjectWithDot, 'Test dot syntax on object (read)', 5);
			Bench.run();
		}

		private function readObjectWithBracket() : void {
			var o : Object = {value:"toto"};
			var a : String;
			for (var i : uint = 0; i < loops; i++) {
				a = o["value"];
			}
		}

		private function readObjectWithDot() : void {
			var o : Object = {value:"toto"};
			var a : String;
			for (var i : uint = 0; i < loops; i++) {
				a = o.value;
			}
		}

		private function pushSpriteInArray() : void {
			var a : Array = [];
			for (var i : uint = 0; i < 10000; i++) {
				a.push(new Sprite());
			}
		}
	}
}
