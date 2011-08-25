/*
The MIT License

Copyright (c) 2011 Jonas Monnier

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/
package com.mobilo.time {
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	/**
	 * @author @jonasmonnier @Seraf_NSS @mirezko
	 */
	public class Interval {
		private static var _stack : Dictionary = new Dictionary();
		private static var _running : Boolean = false;
		private static var _id : int = -1;
		
		public static function create(closure : Function, delay : Number, repeatCount : uint, ...args : Array) : int {
			_id++;
			_stack[_id] = {closure:closure, delay:delay, args:args, repeatCount:repeatCount, last:getTimer(), count:0, id:_id};
			if (!_running) {
				_running = true;
				Tick.create(tick);
			}
			return _id;
		}
		
		public static function clear(id : int) : Boolean {
			if(_stack.hasOwnProperty(id))
			{
				delete _stack[id];
				return true;
			}
			else
			{
				return false;
			}
		}
		
		public static function clearAll() : void {
			if (_running) {
				Tick.remove(tick);
				for (var key:Object in _stack)
				{
					delete _stack[key];
				}
				_running = false;
			}
		}
		
		public static function get running() : Boolean {
			return _running;
		}
		
		private static function tick() : void {
			var length : int = 0;
			var handler:Object;
			for (var i:Object in _stack)
			{
				handler = _stack[i];
				if (getTimer() - handler["last"] >= handler["delay"]) {
					(handler["closure"] as Function).apply(null, handler["args"]);
					handler["last"] = getTimer();
					handler["count"]++;
					if (handler["count"] == handler["repeatCount"] && _stack.hasOwnProperty(i))
						delete _stack[i];
				}
				length++;
			}
			if (length == 0) {
				Tick.remove(tick);
				_running = false;
			}
		}
	}
}
