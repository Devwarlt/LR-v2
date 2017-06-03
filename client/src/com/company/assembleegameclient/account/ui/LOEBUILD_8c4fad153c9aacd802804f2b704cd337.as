package com.company.assembleegameclient.account.ui {
import com.company.assembleegameclient.account.ui.LOEBUILD_4725dcf446a342f1473a8228e42dfa48.LOEBUILD_8318ce1c96df6ce21eb2ed428c6d0f85;
import com.company.assembleegameclient.account.ui.LOEBUILD_4725dcf446a342f1473a8228e42dfa48.LOEBUILD_8ba219ec2bd30c58b2939423aa97781b;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import kabam.lib.ui.api.Layout;
import kabam.lib.ui.impl.HorizontalLayout;
import kabam.rotmg.ui.view.SignalWaiter;

public class LOEBUILD_8c4fad153c9aacd802804f2b704cd337 extends Sprite {

      private var labels:Vector.<String>;

      private var boxes:Vector.<LOEBUILD_f72c2c64e5a1d244b8b6bc0373b73ff1>;

      private var group:LOEBUILD_8ba219ec2bd30c58b2939423aa97781b;

      private const waiter:SignalWaiter = new SignalWaiter();

      public function LOEBUILD_8c4fad153c9aacd802804f2b704cd337(param1:Vector.<String>) {
         super();
         this.labels = param1;
         this.waiter.complete.add(this.alignRadioButtons);
         this.makeRadioButtons();
         this.alignRadioButtons();
         this.makeSelectionGroup();
      }

      public function setSelected(param1:String) : void {
         this.group.setSelected(param1);
      }

      public function getSelected() : String {
         return this.group.getSelected().getValue();
      }

      private function makeRadioButtons() : void {
         var _local1:int = this.labels.length;
         this.boxes = new Vector.<LOEBUILD_f72c2c64e5a1d244b8b6bc0373b73ff1>(_local1,true);
         var _local2:int = 0;
         while(_local2 < _local1) {
            this.boxes[_local2] = this.makeRadioButton(this.labels[_local2]);
            _local2++;
         }
      }

      private function makeRadioButton(param1:String) : LOEBUILD_f72c2c64e5a1d244b8b6bc0373b73ff1 {
         var _local2:LOEBUILD_f72c2c64e5a1d244b8b6bc0373b73ff1 = new LOEBUILD_f72c2c64e5a1d244b8b6bc0373b73ff1(param1);
         _local2.addEventListener(MouseEvent.CLICK,this.onSelected);
         this.waiter.push(_local2.textSet);
         addChild(_local2);
         return _local2;
      }

      private function onSelected(param1:Event) : void {
         var _local2:LOEBUILD_8318ce1c96df6ce21eb2ed428c6d0f85 = param1.currentTarget as LOEBUILD_8318ce1c96df6ce21eb2ed428c6d0f85;
         this.group.setSelected(_local2.getValue());
      }

      private function alignRadioButtons() : void {
         var _local1:Vector.<DisplayObject> = this.castBoxesToDisplayObjects();
         var _local2:Layout = new HorizontalLayout();
         _local2.setPadding(20);
         _local2.layout(_local1);
      }

      private function castBoxesToDisplayObjects() : Vector.<DisplayObject> {
         var _local1:int = this.boxes.length;
         var _local2:Vector.<DisplayObject> = new Vector.<DisplayObject>(0);
         var _local3:int = 0;
         while(_local3 < _local1) {
            _local2[_local3] = this.boxes[_local3];
            _local3++;
         }
         return _local2;
      }

      private function makeSelectionGroup() : void {
         var _local1:Vector.<LOEBUILD_8318ce1c96df6ce21eb2ed428c6d0f85> = this.castBoxesToSelectables();
         this.group = new LOEBUILD_8ba219ec2bd30c58b2939423aa97781b(_local1);
         this.group.setSelected(this.boxes[0].getValue());
      }

      private function castBoxesToSelectables() : Vector.<LOEBUILD_8318ce1c96df6ce21eb2ed428c6d0f85> {
         var _local1:int = this.boxes.length;
         var _local2:Vector.<LOEBUILD_8318ce1c96df6ce21eb2ed428c6d0f85> = new Vector.<LOEBUILD_8318ce1c96df6ce21eb2ed428c6d0f85>(0);
         var _local3:int = 0;
         while(_local3 < _local1) {
            _local2[_local3] = this.boxes[_local3];
            _local3++;
         }
         return _local2;
      }
   }
}
