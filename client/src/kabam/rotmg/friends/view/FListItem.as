package kabam.rotmg.friends.view {
import flash.display.Sprite;

import kabam.rotmg.friends.model.FriendVO;

import org.osflash.signals.Signal;

public class FListItem extends Sprite {

      public var actionSignal:Signal;

      public function FListItem() {
         this.actionSignal = new Signal(String,String);
         super();
      }

      protected function init(param1:Number, param2:Number) : void {
      }

      public function update(param1:FriendVO, param2:String) : void {
      }

      public function destroy() : void {
      }
   }
}
