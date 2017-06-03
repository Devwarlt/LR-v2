package kabam.rotmg.game.commands {
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.LOEBUILD_aa29b95f65f1f34f1682d7480bcd9150;

import robotlegs.bender.bundles.mvcs.Command;

public class GiftStatusUpdateCommand extends Command {

      [Inject]
      public var model:LOEBUILD_aa29b95f65f1f34f1682d7480bcd9150;

      [Inject]
      public var hasGift:Boolean;

      public function GiftStatusUpdateCommand() {
         super();
      }

      override public function execute() : void {
         this.model.setHasGift(this.hasGift);
      }
   }
}
