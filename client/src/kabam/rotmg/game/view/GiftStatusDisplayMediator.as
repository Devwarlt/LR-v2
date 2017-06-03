package kabam.rotmg.game.view {
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.LOEBUILD_aa29b95f65f1f34f1682d7480bcd9150;

import kabam.rotmg.game.signals.UpdateGiftStatusDisplaySignal;

public class GiftStatusDisplayMediator {

      [Inject]
      public var updateGiftStatusDisplay:UpdateGiftStatusDisplaySignal;

      [Inject]
      public var view:GiftStatusDisplay;

      [Inject]
      public var giftStatusModel:LOEBUILD_aa29b95f65f1f34f1682d7480bcd9150;

      public function GiftStatusDisplayMediator() {
         super();
      }

      public function initialize() : void {
         this.updateGiftStatusDisplay.add(this.onGiftChestUpdate);
         if(this.giftStatusModel.hasGift) {
            this.view.drawAsOpen();
         } else {
            this.view.drawAsClosed();
         }
      }

      private function onGiftChestUpdate() : void {
         if(this.giftStatusModel.hasGift) {
            this.view.drawAsOpen();
         } else {
            this.view.drawAsClosed();
         }
      }
   }
}
