package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent
	import flash.utils.getTimer;

	public class ttt extends MovieClip {
		private var totalTimes:uint = 10000;
		/*总共拥有时间（游戏中的操作会影响到这个时间，不过总时间不显示在屏幕，仅用于判断游戏进行的时间是否超过总共拥有的时间
		（取得方法:getTimer()-startTime)*/
		
		private var remainTime:uint = totalTimes;//剩余时间（用于显示在屏幕）
		private var startTime:uint;//开始时间
		
		public function ttt(){
           timeText.addEventListener(MouseEvent.CLICK,begin)//点击中间的那个文本，开始计时（bug：再点击则会再计时。此处为了代码量少容易看，就不补这个bug了）
		}
		private function changeTime(event:MouseEvent){//点击时增加或减少总时间
			if (event.target == addTimeText){
				totalTimes +=2000;
			}
			if (event.target == minusTimeText){
				totalTimes -=2000;
			}
		}
		private function renewTime(event:Event){//更新屏幕显示
			var timeGap:uint = getTimer()-startTime;
			if (timeGap > totalTimes){
			    endGame();
			}
			else{
				remainTime = totalTimes - timeGap;
				timeText.text = Math.floor(remainTime/1000).toString()+":"+Math.floor((remainTime % 1000)/10);
				trace(remainTime);
			}
		}
		private function endGame(){//时间用完，移除更新的监听器
			removeEventListener(Event.ENTER_FRAME,renewTime);
			timeText.text = "Time's Over";
		}
		private function begin(event:MouseEvent){//触发了计时器的开始
			addTimeText.addEventListener(MouseEvent.CLICK,changeTime);
		    minusTimeText.addEventListener(MouseEvent.CLICK,changeTime);
		    stage.addEventListener(Event.ENTER_FRAME,renewTime)
		    startTime = getTimer();
			
		}
	}
}


