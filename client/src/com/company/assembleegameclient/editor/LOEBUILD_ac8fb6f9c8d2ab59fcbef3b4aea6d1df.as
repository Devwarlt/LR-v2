package com.company.assembleegameclient.editor {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.utils.Dictionary;

public class LOEBUILD_ac8fb6f9c8d2ab59fcbef3b4aea6d1df extends Sprite {

      private var keyCodeDict_:Dictionary;

      private var yOffset_:int = 0;

      private var selected_:LOEBUILD_d8c235d417345612d45a6cc3a3c2efad = null;

      public function LOEBUILD_ac8fb6f9c8d2ab59fcbef3b4aea6d1df() {
         this.keyCodeDict_ = new Dictionary();
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }

      public function getCommand() : int {
         return this.selected_.command_;
      }

      public function setCommand(param1:int) : void {
         var _local3:LOEBUILD_d8c235d417345612d45a6cc3a3c2efad = null;
         var _local2:int = 0;
         while(_local2 < numChildren) {
            _local3 = getChildAt(_local2) as LOEBUILD_d8c235d417345612d45a6cc3a3c2efad;
            if(_local3 != null) {
               if(_local3.command_ == param1) {
                  this.setSelected(_local3);
                  break;
               }
            }
            _local2++;
         }
      }

      protected function setSelected(param1:LOEBUILD_d8c235d417345612d45a6cc3a3c2efad) : void {
         if(this.selected_ != null) {
            this.selected_.setSelected(false);
         }
         this.selected_ = param1;
         this.selected_.setSelected(true);
      }

      private function onAddedToStage(param1:Event) : void {
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }

      private function onRemovedFromStage(param1:Event) : void {
         stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }

      private function onKeyDown(param1:KeyboardEvent) : void {
         if(stage.focus != null) {
            return;
         }
         var _local2:LOEBUILD_d8c235d417345612d45a6cc3a3c2efad = this.keyCodeDict_[param1.keyCode];
         if(_local2 == null) {
            return;
         }
         _local2.callback_(_local2);
      }

      protected function addCommandMenuItem(param1:String, param2:int, param3:Function, param4:int) : void {
         var _local5:LOEBUILD_d8c235d417345612d45a6cc3a3c2efad = new LOEBUILD_d8c235d417345612d45a6cc3a3c2efad(param1,param3,param4);
         _local5.y = this.yOffset_;
         addChild(_local5);
         this.keyCodeDict_[param2] = _local5;
         if(this.selected_ == null) {
            this.setSelected(_local5);
         }
         this.yOffset_ = this.yOffset_ + 30;
      }

      protected function addBreak() : void {
         this.yOffset_ = this.yOffset_ + 30;
      }
   }
}
