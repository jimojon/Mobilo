package com.mobilo.time {
	import flash.utils.getTimer;

	/**
	 * @author @jonasmonnier @Seraf_NSS
	 */
	public class Interval {
		private static var _stack : Vector.<Object> = new Vector.<Object>();
		private static var _running : Boolean = false;
		private static var _id : int = -1;

		public static function create(closure : Function, delay : Number, repeatCount:uint, ...args : Array) : int {
			_id++;
			_stack.push({closure:closure, delay:delay, args:args, repeatCount:repeatCount, last:getTimer(), count:0, id:_id});
			if (!_running){
				_running = true;
				Tick.create(tick);
			}
			return _id;
		}

		private static function tick() : void {
			var i : int = 0;
			var b : Boolean = _stack.length > 0;
			while (b) {
				if (getTimer() - _stack[i]["last"] >= _stack[i]["delay"]) {
					(_stack[i]["closure"] as Function).apply(null, _stack[i]["args"]);
					_stack[i]["last"] = getTimer();
					_stack[i]["count"]++;
					trace(_stack[i]["count"], _stack[i]["repeatCount"]);
					if(_stack[i]["count"] == _stack[i]["repeatCount"])
						_stack.splice(i, 1);
				} else {
					i++;
				}
				b = _stack.length > i;
			}
			if (_stack.length == 0) {
				Tick.remove(tick);
				_running = false;
			}
		}

		public static function get running() : Boolean {
			return _running;
		}

		public static function clear(id : int) : Boolean {
			var l : int = _stack.length ;
			while (l--) {
				if ( _stack[l]["id"] == id ) {
					_stack.splice(l, 1);
					return true;
				}
			}
			return false;
		}

		public static function clearAll() : void {
			if (_running) {
				Tick.remove(tick);
				_stack.length = 0;
				_running = false;
			}
		}
	}
}
