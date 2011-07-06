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
package com.mobilo.bench {
	import com.mobilo.time.Timeout;

	import flash.system.System;
	import flash.utils.getTimer;

	/**
	 * @author jonas
	 * @date 24 juin 2011
	 */
	public class Bench {
		private static var _stack : Vector.<Object> = new Vector.<Object>();
		private static var _running : Boolean = false;
		private static var _start : int;
		private static var _time : int;
		private static var _max : int;
		private static var _min : int;
		private static var _total : int;

		private static var _average : int;
		private static var _current : Object;
		private static var _output : Function;
		private static var _result : String;

		public static var delay : uint = 1000;

		public static function push(method : Function, description : String = "", iterations : uint = 5) : void {
			_stack.push({method:method, description:description, iterations:iterations, count:0});
		}

		public static function clear() : void {
			_stack.length = 0;
			Timeout.clearAll();
		}

		public static function run() : void {
			_result = "";
			_max = 0;
			_min = 0;
			_total = 0;

			Timeout.create(_run, delay * 2);
		}

		private static function _run() : void {
			_current = _stack[0];

			if (_current.count == 0)
				_result += _current.description + "\n------------------------------------------------------------\n";

			_start = getTimer();

			_current.method();

			_time = getTimer() - _start;

			_max = Math.max(_time, _max);
			if (_min == 0)
				_min = _time;
			else
				_min = Math.min(_time, _min);
			_total += _time;
			_result += "time=" + _time + " ms [memory total=" + Number(System.totalMemory * 0.000000954).toFixed(3) + " private=" + Number(System.privateMemory * 0.000000954).toFixed(3) + " free=" + Number(System.freeMemory * 0.000000954).toFixed(3) + "]\n";

			_current.count++;
			if (_current.count == _current.iterations) {
				_average = Math.round(_total / _current.count);
				_result += "------------------------------------------------------------\ntime=" + _average + " max=" + _max + " min=" + _min + " deviation=" + Number((_max - _min) / _average).toFixed(3) + "\n\n";
				_stack.shift();
				_max = 0;
				_min = 0;
				_total = 0;
				if (_stack.length == 0) {
					_output(_result);
				} else {
					_gc();
					Timeout.create(_run, delay);
				}
			} else {
				_gc();
				Timeout.create(_run, delay);
			}
		}

		private static function _gc() : void {
			System.gc();
		}

		public static function get running() : Boolean {
			return _running;
		}

		public static function set output(output : Function) : void {
			_output = output;
		}

		static public function get result() : String {
			return _result;
		}
	}
}
