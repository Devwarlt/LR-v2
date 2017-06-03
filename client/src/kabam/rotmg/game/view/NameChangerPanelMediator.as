package kabam.rotmg.game.view {
import com.company.assembleegameclient.account.ui.LOEBUILD_74a13e89b510f04db8bb32dcec0faa62;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.view.RegisterPromptDialog;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.ui.signals.NameChangedSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class NameChangerPanelMediator extends Mediator {

      [Inject]
      public var account:Account;

      [Inject]
      public var view:NameChangerPanel;

      [Inject]
      public var openDialog:OpenDialogSignal;

      [Inject]
      public var nameChanged:NameChangedSignal;

      public function NameChangerPanelMediator() {
         super();
      }

      override public function initialize() : void {
         this.view.chooseName.add(this.onChooseName);
         this.nameChanged.add(this.onNameChanged);
      }

      override public function destroy() : void {
         this.view.chooseName.remove(this.onChooseName);
         this.nameChanged.remove(this.onNameChanged);
      }

      private function onChooseName() : void {
         if(this.account.isRegistered()) {
            this.openDialog.dispatch(new LOEBUILD_74a13e89b510f04db8bb32dcec0faa62(this.view.gs_,this.view.buy_));
         } else {
            this.openDialog.dispatch(new RegisterPromptDialog(TextKey.NAME_CHANGER_PANEL_MEDIATOR_TEXT));
         }
      }

      private function onNameChanged(param1:String) : void {
         this.view.updateName(param1);
      }
   }
}
