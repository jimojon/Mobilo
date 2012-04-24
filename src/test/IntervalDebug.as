package test {
	import com.jonas.utils.Button;
	import com.mobilo.time.Interval;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.Dictionary;

	/**
	 * @author Jonas Monnier
	 * @date Apr 24, 2012
	 */
	public class IntervalDebug extends Sprite 
	{
		private var _addButton:Button;
		private var _oButtons:Dictionary;
		private var _label:TextField;
		private var _ping:TextField;
		private var _i:uint;
		
		public function IntervalDebug() {
			_oButtons = new Dictionary();

			_addButton = new Button("Add");
			_addButton.x = _addButton.y = 20;
			_addButton.addEventListener(MouseEvent.CLICK, onAddClick);
			addChild(_addButton);
			
			_label = new TextField();
			_label.width = 140;
			_label.x = 80;
			_label.y = 20;
			addChild(_label);
			
			_ping = new TextField();
			_ping.x = 240;
			_ping.y = 20;
			addChild(_ping);
		}

		private function onAddClick(event : MouseEvent) : void {
			var id:uint = Interval.create(onInterval, 200, 0);
			var bt:Button = new Button(String(id));
			bt.data = id;
			bt.addEventListener(MouseEvent.CLICK, onButtonClick);
			bt.x = 20;
			_oButtons[id] = bt;
			addChild(bt);
			_update();
		}

		private function onButtonClick(event : MouseEvent) : void {
			var bt:Button = event.currentTarget as Button;
			var id:uint = bt.data as uint;
			Interval.clear(id);
			removeChild(bt);
			bt.removeEventListener(MouseEvent.CLICK, onButtonClick);
			bt = null;
			delete(_oButtons[id]);
			_update();
		}
		
		private function _update():void {
			var n:uint = Interval.length;
			_label.text = "Running "+n+" interval"+(n > 0 ? "s" : "");
			
			var bt:Button;
			var ny:Number = 50;
			var nx:Number = 20;
			var n:uint = 0;
			for(var i:String in _oButtons){
				bt = _oButtons[i] as Button;
				bt.y = ny;
				bt.x = nx;
				ny = bt.y+25;
				n++;
				if(n % 10 == 0){
					ny = 50;
					nx = 20+(n/10*80);
				}
			}
		}
		
		private function onInterval():void {
			_ping.text = String(_i++);
		}
	}
}
