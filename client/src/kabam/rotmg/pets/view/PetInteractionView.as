package kabam.rotmg.pets.view {
import com.company.assembleegameclient.util.StageProxy;

import flash.display.Sprite;

import kabam.rotmg.pets.view.dialogs.ClearsPetSlots;

public class PetInteractionView extends Sprite implements ClearsPetSlots {

      public var stageProxy:StageProxy;

      public function PetInteractionView() {
         super();
         this.stageProxy = new StageProxy(this);
      }

      protected function positionThis() : void {
         this.x = (800 - this.width) * 0.5;
         this.y = (600 - this.height) * 0.5;
      }
   }
}
