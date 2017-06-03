package kabam.rotmg.game.focus.view {
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.GameSprite;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;

import flash.utils.Dictionary;

import kabam.rotmg.game.focus.control.SetGameFocusSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class GameFocusMediator extends Mediator {

      [Inject]
      public var signal:SetGameFocusSignal;

      [Inject]
      public var view:GameSprite;

      public function GameFocusMediator() {
         super();
      }

      override public function initialize() : void {
         this.signal.add(this.onSetGameFocus);
      }

      override public function destroy() : void {
         this.signal.remove(this.onSetGameFocus);
      }

      private function onSetGameFocus(param1:String = "") : void {
         this.view.setFocus(this.getFocusById(param1));
      }

      private function getFocusById(param1:String) : GameObject {
         var _local3:GameObject = null;
         if(param1 == "") {
            return this.view.map.player_;
         }
         var _local2:Dictionary = this.view.map.goDict_;
         for each(_local3 in _local2) {
            if(_local3.name_ == param1) {
               return _local3;
            }
         }
         return this.view.map.player_;
      }
   }
}
