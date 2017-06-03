package com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9 {
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;

import flash.events.KeyboardEvent;
import flash.events.MouseEvent;

import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.game.signals.AddTextLineSignal;

public class LOEBUILD_c11ff77a16e23fedc0889a2f7c4b40b6 {

      private static const MINUTE_IN_MS:int = 60 * 1000;

      private static const FIRST_WARNING_MINUTES:int = 10;

      private static const SECOND_WARNING_MINUTES:int = 15;

      private static const KICK_MINUTES:int = 20;

      public var gs_:GameSprite = null;

      public var idleTime_:int = 0;

      private var addTextLine:AddTextLineSignal;

      public function LOEBUILD_c11ff77a16e23fedc0889a2f7c4b40b6() {
         super();
         this.addTextLine = StaticInjectorContext.getInjector().getInstance(AddTextLineSignal);
      }

      public function start(param1:GameSprite) : void {
         this.gs_ = param1;
         this.idleTime_ = 0;
         this.gs_.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         this.gs_.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }

      public function update(param1:int) : Boolean {
         var _local2:int = this.idleTime_;
         this.idleTime_ = this.idleTime_ + param1;
         if(this.idleTime_ < FIRST_WARNING_MINUTES * MINUTE_IN_MS) {
            return false;
         }
         if(this.idleTime_ >= FIRST_WARNING_MINUTES * MINUTE_IN_MS && _local2 < FIRST_WARNING_MINUTES * MINUTE_IN_MS) {
            this.addTextLine.dispatch(this.makeFirstWarning());
            return false;
         }
         if(this.idleTime_ >= SECOND_WARNING_MINUTES * MINUTE_IN_MS && _local2 < SECOND_WARNING_MINUTES * MINUTE_IN_MS) {
            this.addTextLine.dispatch(this.makeSecondWarning());
            return false;
         }
         if(this.idleTime_ >= KICK_MINUTES * MINUTE_IN_MS && _local2 < KICK_MINUTES * MINUTE_IN_MS) {
            this.addTextLine.dispatch(this.makeThirdWarning());
            return true;
         }
         return false;
      }

      private function makeFirstWarning() : ChatMessage {
         var _local1:ChatMessage = new ChatMessage();
         _local1.name = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.ERROR_CHAT_NAME;
         _local1.text = "You have been idle for " + FIRST_WARNING_MINUTES + " minutes, you will be disconnected if you are idle for " + "more than " + KICK_MINUTES + " minutes.";
         return _local1;
      }

      private function makeSecondWarning() : ChatMessage {
         var _local1:ChatMessage = new ChatMessage();
         _local1.name = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.ERROR_CHAT_NAME;
         _local1.text = "You have been idle for " + SECOND_WARNING_MINUTES + " minutes, you will be disconnected if you are idle for " + "more than " + KICK_MINUTES + " minutes.";
         return _local1;
      }

      private function makeThirdWarning() : ChatMessage {
         var _local1:ChatMessage = new ChatMessage();
         _local1.name = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.ERROR_CHAT_NAME;
         _local1.text = "You have been idle for " + KICK_MINUTES + " minutes, disconnecting.";
         return _local1;
      }

      public function stop() : void {
         this.gs_.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         this.gs_.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         this.gs_ = null;
      }

      private function onMouseMove(param1:MouseEvent) : void {
         this.idleTime_ = 0;
      }

      private function onKeyDown(param1:KeyboardEvent) : void {
         this.idleTime_ = 0;
      }
   }
}
