package bench {
	import com.mobilo.bench.Bench;
	import com.mobilo.bench.BenchView;


	/**
	 * @author jonas
	 * @from Grant Skinner PerformanceTest
	 * @date 4 juil. 2011
	 */
	final public class Loops extends BenchView {
		private var loops : uint = 1000000;
		private var vec : Vector.<Boolean> = new Vector.<Boolean>(loops);

		public function Loops() {
			super();
			Bench.push(forIncrement, 'forIncrement', 5);
			Bench.push(forDecrement, 'forDecrement', 5);
			Bench.push(whileIncrement, 'whileIncrement', 5);
			Bench.push(whileDecrement, 'whileDecrement', 5);
			Bench.push(doWhileIncrement, 'doWhileIncrement', 5);
			Bench.push(doWhileDecrement, 'doWhileDecrement', 5);
			Bench.push(forIn, 'forIn', 5);
			Bench.push(forEachIn, 'forEachIn', 5);
			Bench.push(forEachInUntyped, 'forEachInUntyped', 5);
			Bench.push(forEachInPosttyped, 'forEachInPosttyped', 5);
			Bench.push(vecForEach, 'vecForEach', 5);

			Bench.run();
		}

		private function forIncrement() : void {
			for (var i : uint = 0; i < loops; i++) {
				var a : uint = i;
			}
		}

		private function forDecrement() : void {
			for (var i : uint = loops; i > 0; i--) {
				var a : uint = i - 1;
			}
		}

		private function whileIncrement() : void {
			var i : uint = 0;
			while (i < loops) {
				var a : uint = i;
				i++;
			}
		}

		private function whileDecrement() : void {
			var i : uint = loops;
			while (--i) {
				var a : uint = i;
			}
		}

		private function doWhileIncrement() : void {
			var i : uint = 0;
			do {
				var a : uint = i;
			} while (++i < loops);
		}

		private function doWhileDecrement() : void {
			var i : uint = loops - 1;
			do {
				var a : uint = i;
			} while (i--);
		}

		private function forIn() : void {
			for (var b:* in vec) {
				var a : uint = b;
			}
		}

		private function forEachIn() : void {
			for each (var b:Boolean in vec) {
				var a : uint = loops;
			}
		}

		private function forEachInUntyped() : void {
			for each (var b:* in vec) {
				var a : uint = loops;
			}
		}

		private function forEachInPosttyped() : void {
			for each (var b:* in vec) {
				var c : Boolean = b as Boolean;
				var a : uint = loops;
			}
		}

		private function vecForEach() : void {
			vec.forEach(vecForEachF);
		}

		// helper functions:
		private function vecForEachF(item : Boolean, index : int, vec : Vector.<Boolean>) : void {
			var a : uint = index;
		}
	}
}
