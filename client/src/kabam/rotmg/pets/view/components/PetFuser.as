package kabam.rotmg.pets.view.components {
import flash.display.Sprite;

import kabam.rotmg.pets.data.PetSlotsState;
import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.pets.view.components.slot.PetFeedFuseSlot;

import org.osflash.signals.Signal;

public class PetFuser extends Sprite {

      public const openPetPicker:Signal = new Signal(String);

      private var leftSlot:PetFeedFuseSlot;

      private var arrow:FeedFuseArrow;

      private var rightSlot:PetFeedFuseSlot;

      private var state:PetSlotsState;

      public function PetFuser() {
         this.leftSlot = new PetFeedFuseSlot();
         this.arrow = PetsViewAssetFactory.returnPetFeederArrow();
         this.rightSlot = PetsViewAssetFactory.returnPetFuserRightSlot();
         super();
         this.leftSlot.showFamily = true;
         addChild(this.leftSlot);
         addChild(this.arrow);
         addChild(this.rightSlot);
         this.leftSlot.openPetPicker.addOnce(this.onOpenLeftPetPicker);
         this.rightSlot.openPetPicker.addOnce(this.onOpenRightPetPicker);
      }

      public function initialize(param1:PetSlotsState) : void {
         this.state = param1;
         this.setPet(this.state.leftSlotPetVO,PetSlotsState.LEFT);
         if(this.state.rightSlotPetVO) {
            this.setPet(this.state.rightSlotPetVO,PetSlotsState.RIGHT);
         }
         this.updateHighlights();
      }

      public function setPet(param1:PetVO, param2:String) : void {
         var _local3:PetFeedFuseSlot = null;
         if(param1) {
            _local3 = param2 == PetSlotsState.LEFT?this.leftSlot:this.rightSlot;
            _local3.setPet(param1);
         }
      }

      private function onOpenLeftPetPicker() : void {
         this.openPetPicker.dispatch(PetSlotsState.LEFT);
      }

      private function onOpenRightPetPicker() : void {
         this.openPetPicker.dispatch(PetSlotsState.RIGHT);
      }

      public function updateHighlights() : void {
         if(this.state.isAcceptableFuseState()) {
            this.arrow.highlight(true);
            this.rightSlot.highlight(true);
            this.leftSlot.highlight(true);
         } else {
            this.rightSlot.highlight(this.state.rightSlotPetVO == null);
            this.leftSlot.highlight(this.state.leftSlotPetVO == null);
            this.arrow.highlight(false);
         }
      }
   }
}
