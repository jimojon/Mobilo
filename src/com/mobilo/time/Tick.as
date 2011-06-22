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
	import flash.display.Shape;
	import flash.events.Event;
	/**
	 * @author jonas
	 * @date 22 juin 2011
	 */
	public class Tick
	{
		private static var _stack : Vector.<Function> = new Vector.<Function>();
		private static var _running : Boolean = false;
		private static var _e : Shape = new Shape();

		public static function create(closure : Function) : void {
			_stack.push(closure);
			if (!_running){
				_running = true;
				_e.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}

		public static function remove(closure : Function) : void {
			_stack.push(closure);
			var n : int = _stack.length;
			for(var i:uint=0; i<n; i++){
				if(_stack[i] == closure){
					_stack.splice(i, 1);
				}
			}

			if (_stack.length == 0 && _running){
				_running = false;
				_e.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}

		public static function removeAll() : void {
			if (_running) {
				_e.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				_stack.length = 0;
				_running = false;
			}
		}

		public static function get running() : Boolean {
			return _running;
		}

		private static function onEnterFrame(event : Event) : void {
			event.stopImmediatePropagation();
			var n : int = _stack.length;
			for(var i:uint=0; i<n; i++){
				_stack[i]();
			}
		}
	}
}
