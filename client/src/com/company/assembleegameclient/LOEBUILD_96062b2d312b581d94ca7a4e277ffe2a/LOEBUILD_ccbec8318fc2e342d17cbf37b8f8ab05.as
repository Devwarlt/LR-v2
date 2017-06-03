package com.company.assembleegameclient.LOEBUILD_96062b2d312b581d94ca7a4e277ffe2a {
import com.company.util.IntPoint;

import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;

public class LOEBUILD_ccbec8318fc2e342d17cbf37b8f8ab05 extends Sprite {

      public var tiles_:Vector.<IntPoint>;

      private var darkBox_:Shape;

      private var frame_:LOEBUILD_17906286b53fee5844d8279e0564b742;

      public function LOEBUILD_ccbec8318fc2e342d17cbf37b8f8ab05(param1:Vector.<IntPoint>, param2:String) {
         super();
         this.tiles_ = param1;
         this.darkBox_ = new Shape();
         var _local3:Graphics = this.darkBox_.graphics;
         _local3.clear();
         _local3.beginFill(0,0.8);
         _local3.drawRect(0,0,800,600);
         _local3.endFill();
         addChild(this.darkBox_);
         this.frame_ = new LOEBUILD_17906286b53fee5844d8279e0564b742(param2);
         this.frame_.addEventListener(Event.COMPLETE,this.onComplete);
         this.frame_.addEventListener(Event.CANCEL,this.onCancel);
         addChild(this.frame_);
      }

      public function getObjectName() : String {
         if(this.frame_.objectName_.text() == "") {
            return null;
         }
         return this.frame_.objectName_.text();
      }

      public function onComplete(param1:Event) : void {
         dispatchEvent(new Event(Event.COMPLETE));
         parent.removeChild(this);
      }

      public function onCancel(param1:Event) : void {
         parent.removeChild(this);
      }
   }
}
