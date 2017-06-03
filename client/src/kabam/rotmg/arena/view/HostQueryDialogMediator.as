package kabam.rotmg.arena.view {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;

import flash.display.BitmapData;
import flash.events.Event;

import kabam.rotmg.dialogs.control.CloseDialogsSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class HostQueryDialogMediator extends Mediator {

      [Inject]
      public var view:HostQueryDialog;

      [Inject]
      public var closeDialogs:CloseDialogsSignal;

      public function HostQueryDialogMediator() {
         super();
      }

      override public function initialize() : void {
         this.view.setHostIcon(this.makeHostIcon());
         this.view.backClick.add(this.onBackClick);
      }

      private function makeHostIcon() : BitmapData {
         return LOEBUILD_efda783509bc93eea698457c87bbee3f.getRedrawnTextureFromType(6546,80,true);
      }

      private function onBackClick(param1:Event) : void {
         this.closeDialogs.dispatch();
      }
   }
}
