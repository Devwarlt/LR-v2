package kabam.rotmg.pets.view.dialogs {
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.GameSprite;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.assembleegameclient.ui.dialogs.Dialog;
import com.company.googleanalytics.GA;

import flash.events.Event;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.text.model.TextKey;

public class LeavePetYard extends PetDialog {

      private var gameSprite:GameSprite;

      private var closeDialogSignal:CloseDialogsSignal;

      public function LeavePetYard(param1:GameSprite) {
         this.closeDialogSignal = StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal);
         this.gameSprite = param1;
         super("LeavePetYardDialog.title","LeavePetYardDialog.text",TextKey.PET_DIALOG_REMAIN,TextKey.PET_DIALOG_LEAVE,null);
         addEventListener(Dialog.LEFT_BUTTON,this.onClose);
         addEventListener(Dialog.RIGHT_BUTTON,this.onExitToNexus);
         titleText_.setMultiLine(true);
      }

      private function onClose(param1:Event) : void {
         this.closeDialogSignal.dispatch();
      }

      private function onExitToNexus(param1:Event) : void {
         this.gameSprite.gsc_.escape();
         GA.global().trackEvent("enterPortal","Nexus Button");
         LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.needsRandomRealm = false;
         LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.save();
         this.closeDialogSignal.dispatch();
      }
   }
}
