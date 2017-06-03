package com.company.assembleegameclient.ui.panels {
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.GameSprite;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;

import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;

import kabam.rotmg.text.model.TextKey;

public class CharacterChangerPanel extends ButtonPanel {

      public function CharacterChangerPanel(param1:GameSprite) {
         super(param1,TextKey.CHARACTER_CHANGER_TITLE,TextKey.CHARACTER_CHANGER_BUTTON);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }

      override protected function onButtonClick(param1:MouseEvent) : void {
         gs_.closed.dispatch();
      }

      private function onAddedToStage(param1:Event) : void {
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }

      private function onRemovedFromStage(param1:Event) : void {
         stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }

      private function onKeyDown(param1:KeyboardEvent) : void {
         if(param1.keyCode == LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.interact && stage.focus == null) {
            gs_.closed.dispatch();
         }
      }
   }
}
