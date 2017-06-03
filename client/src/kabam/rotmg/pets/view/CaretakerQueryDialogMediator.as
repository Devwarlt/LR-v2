package kabam.rotmg.pets.view {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;

import flash.display.BitmapData;

import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.pets.data.PetsModel;
import kabam.rotmg.pets.view.dialogs.CaretakerQueryDialog;

import robotlegs.bender.bundles.mvcs.Mediator;

public class CaretakerQueryDialogMediator extends Mediator {

      [Inject]
      public var view:CaretakerQueryDialog;

      [Inject]
      public var model:PetsModel;

      [Inject]
      public var closeDialogs:CloseDialogsSignal;

      public function CaretakerQueryDialogMediator() {
         super();
      }

      override public function initialize() : void {
         this.view.closed.addOnce(this.onClosed);
         this.view.setCaretakerIcon(this.makeCaretakerIcon());
      }

      private function makeCaretakerIcon() : BitmapData {
         var _local1:int = this.model.getPetYardObjectID();
         return LOEBUILD_efda783509bc93eea698457c87bbee3f.getRedrawnTextureFromType(_local1,80,true);
      }

      override public function destroy() : void {
         this.view.closed.removeAll();
      }

      private function onClosed() : void {
         this.closeDialogs.dispatch();
      }
   }
}
