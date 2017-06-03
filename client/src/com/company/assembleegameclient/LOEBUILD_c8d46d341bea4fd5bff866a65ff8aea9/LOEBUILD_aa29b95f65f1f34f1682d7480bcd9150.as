package com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9 {
import kabam.rotmg.game.signals.UpdateGiftStatusDisplaySignal;

public class LOEBUILD_aa29b95f65f1f34f1682d7480bcd9150 {

      [Inject]
      public var updateGiftStatusDisplay:UpdateGiftStatusDisplaySignal;

      public var hasGift:Boolean;

      public function LOEBUILD_aa29b95f65f1f34f1682d7480bcd9150() {
         super();
      }

      public function setHasGift(param1:Boolean) : void {
         this.hasGift = param1;
         this.updateGiftStatusDisplay.dispatch();
      }
   }
}
