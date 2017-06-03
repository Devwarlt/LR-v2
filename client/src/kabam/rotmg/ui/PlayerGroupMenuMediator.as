package kabam.rotmg.ui {
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.assembleegameclient.ui.menu.PlayerGroupMenu;

import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.game.signals.AddTextLineSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class PlayerGroupMenuMediator extends Mediator {

      [Inject]
      public var view:PlayerGroupMenu;

      [Inject]
      private var addTextLine:AddTextLineSignal;

      public function PlayerGroupMenuMediator() {
         super();
      }

      override public function initialize() : void {
         this.view.unableToTeleport.add(this.onUnableToTeleport);
      }

      override public function destroy() : void {
         this.view.unableToTeleport.remove(this.onUnableToTeleport);
      }

      private function onUnableToTeleport() : void {
         this.addTextLine.dispatch(ChatMessage.make(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.ERROR_CHAT_NAME,"No players are eligible for teleporting"));
      }
   }
}
