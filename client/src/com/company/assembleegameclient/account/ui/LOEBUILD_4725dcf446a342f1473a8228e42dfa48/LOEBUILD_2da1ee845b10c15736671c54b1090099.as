package com.company.assembleegameclient.account.ui.LOEBUILD_4725dcf446a342f1473a8228e42dfa48 {
import com.company.assembleegameclient.account.ui.CreateGuildFrame;

import kabam.rotmg.dialogs.control.CloseDialogsSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class LOEBUILD_2da1ee845b10c15736671c54b1090099 extends Mediator {

      [Inject]
      public var view:CreateGuildFrame;

      [Inject]
      public var closeDialog:CloseDialogsSignal;

      public function LOEBUILD_2da1ee845b10c15736671c54b1090099() {
         super();
      }

      override public function initialize() : void {
         this.view.close.add(this.onClose);
      }

      override public function destroy() : void {
         this.view.close.remove(this.onClose);
      }

      private function onClose() : void {
         this.closeDialog.dispatch();
      }
   }
}
