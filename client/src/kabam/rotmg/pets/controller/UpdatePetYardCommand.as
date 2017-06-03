package kabam.rotmg.pets.controller {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;

import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.pets.data.PetYardEnum;
import kabam.rotmg.pets.data.PetsModel;
import kabam.rotmg.pets.view.dialogs.LeavePetYard;
import kabam.rotmg.ui.model.HUDModel;

import robotlegs.bender.bundles.mvcs.Command;

public class UpdatePetYardCommand extends Command {

      [Inject]
      public var type:int;

      [Inject]
      public var petModel:PetsModel;

      [Inject]
      public var hudModel:HUDModel;

      [Inject]
      public var openDialog:OpenDialogSignal;

      public function UpdatePetYardCommand() {
         super();
      }

      override public function execute() : void {
         this.petModel.setPetYardType(this.getYardTypeFromEnum());
         this.openDialog.dispatch(new LeavePetYard(this.hudModel.gameSprite));
      }

      private function getYardTypeFromEnum() : int {
         var _local1:String = PetYardEnum.selectByOrdinal(this.type).value;
         return LOEBUILD_efda783509bc93eea698457c87bbee3f.getXMLfromId(_local1).@type;
      }
   }
}
