package com.company.assembleegameclient.screens {
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;

import flash.display.Sprite;
import flash.events.MouseEvent;

import kabam.rotmg.servers.api.Server;

public class ServerBoxes extends Sprite {

      private var boxes_:Vector.<ServerBox>;

      public function ServerBoxes(param1:Vector.<Server>) {
         var _local2:ServerBox = null;
         var _local3:int = 0;
         var _local4:Server = null;
         this.boxes_ = new Vector.<ServerBox>();
         super();
         _local2 = new ServerBox(null);
         _local2.setSelected(true);
         _local2.x = ServerBox.WIDTH / 2 + 2;
         _local2.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         addChild(_local2);
         this.boxes_.push(_local2);
         _local3 = 2;
         for each(_local4 in param1) {
            _local2 = new ServerBox(_local4);
            if(_local4.name == LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.preferredServer) {
               this.setSelected(_local2);
            }
            _local2.x = _local3 % 2 * (ServerBox.WIDTH + 4);
            _local2.y = int(_local3 / 2) * (ServerBox.HEIGHT + 4);
            _local2.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
            addChild(_local2);
            this.boxes_.push(_local2);
            _local3++;
         }
      }

      private function onMouseDown(param1:MouseEvent) : void {
         var _local2:ServerBox = param1.currentTarget as ServerBox;
         if(_local2 == null) {
            return;
         }
         this.setSelected(_local2);
         LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.preferredServer = _local2.value_;
         LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.save();
      }

      private function setSelected(param1:ServerBox) : void {
         var _local2:ServerBox = null;
         for each(_local2 in this.boxes_) {
            _local2.setSelected(false);
         }
         param1.setSelected(true);
      }
   }
}
