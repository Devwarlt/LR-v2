package kabam.rotmg.game.view {
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.GameSprite;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.assembleegameclient.ui.panels.ButtonPanel;

import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;

import kabam.rotmg.text.model.TextKey;

import org.osflash.signals.Signal;

public class MoneyChangerPanel extends ButtonPanel {

      public var triggered:Signal;

      public function MoneyChangerPanel(param1:GameSprite) {
         super(param1,TextKey.MONEY_CHANGER_TITLE,TextKey.MONEY_CHANGER_BUTTON);
         this.triggered = new Signal();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }

      private function onAddedToStage(param1:Event) : void {
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }

      private function onRemovedFromStage(param1:Event) : void {
         stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }

      override protected function onButtonClick(param1:MouseEvent) : void {
         this.triggered.dispatch();
      }

      private function onKeyDown(param1:KeyboardEvent) : void {
         if(param1.keyCode == LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.interact && stage.focus == null) {
            this.triggered.dispatch();
         }
      }
   }
}
