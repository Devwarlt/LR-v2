package kabam.rotmg.game.view {
import com.company.assembleegameclient.map.LOEBUILD_4a218ca1436fee34076fdca93698bac4.LOEBUILD_2f05f88d589905f707225941d764de4a;
import com.company.assembleegameclient.map.LOEBUILD_4a218ca1436fee34076fdca93698bac4.LOEBUILD_d71287c311912d45ec3f504b24da0385;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.game.model.AddSpeechBalloonVO;
import kabam.rotmg.game.model.ChatFilter;
import kabam.rotmg.game.signals.AddSpeechBalloonSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class MapOverlayMediator extends Mediator {

      [Inject]
      public var view:LOEBUILD_2f05f88d589905f707225941d764de4a;

      [Inject]
      public var addSpeechBalloon:AddSpeechBalloonSignal;

      [Inject]
      public var chatFilter:ChatFilter;

      [Inject]
      public var account:Account;

      public function MapOverlayMediator() {
         super();
      }

      override public function initialize() : void {
         this.addSpeechBalloon.add(this.onAddSpeechBalloon);
      }

      override public function destroy() : void {
         this.addSpeechBalloon.remove(this.onAddSpeechBalloon);
      }

      private function onAddSpeechBalloon(param1:AddSpeechBalloonVO) : void {
         var _local2:String = Boolean(this.account.isRegistered()) || Boolean(this.chatFilter.guestChatFilter(param1.go.name_))?param1.text:". . .";
         var _local3:* = new LOEBUILD_d71287c311912d45ec3f504b24da0385(param1.go,_local2,param1.name,param1.isTrade,param1.isGuild,param1.background,param1.backgroundAlpha,param1.outline,param1.outlineAlpha,param1.textColor,param1.lifetime,param1.bold,param1.hideable);
         this.view.addSpeechBalloon(_local3);
      }
   }
}
