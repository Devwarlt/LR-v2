package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da {
import flash.display.BitmapData;
import flash.geom.ColorTransform;

import kabam.rotmg.stage3D.GraphicsFillExtra;

public class FlashDescription {

      public var startTime_:int;

      public var color_:uint;

      public var periodMS_:int;

      public var repeats_:int;

      public var targetR:int;

      public var targetG:int;

      public var targetB:int;

      public function FlashDescription(param1:int, param2:uint, param3:Number, param4:int) {
         super();
         this.startTime_ = param1;
         this.color_ = param2;
         this.periodMS_ = param3 * 1000;
         this.repeats_ = param4;
         this.targetR = param2 >> 16 & 255;
         this.targetG = param2 >> 8 & 255;
         this.targetB = param2 & 255;
      }

      public function apply(param1:BitmapData, param2:int) : BitmapData {
         var _local3:int = (param2 - this.startTime_) % this.periodMS_;
         var _local4:Number = Math.sin(_local3 / this.periodMS_ * Math.PI);
         var _local5:Number = _local4 * 0.5;
         var _local6:ColorTransform = new ColorTransform(1 - _local5,1 - _local5,1 - _local5,1,_local5 * this.targetR,_local5 * this.targetG,_local5 * this.targetB,0);
         var _local7:BitmapData = param1.clone();
         _local7.colorTransform(_local7.rect,_local6);
         return _local7;
      }

      public function applyGPUTextureColorTransform(param1:BitmapData, param2:int) : void {
         var _local3:int = (param2 - this.startTime_) % this.periodMS_;
         var _local4:Number = Math.sin(_local3 / this.periodMS_ * Math.PI);
         var _local5:Number = _local4 * 0.5;
         var _local6:ColorTransform = new ColorTransform(1 - _local5,1 - _local5,1 - _local5,1,_local5 * this.targetR,_local5 * this.targetG,_local5 * this.targetB,0);
         GraphicsFillExtra.setColorTransform(param1,_local6);
      }

      public function doneAt(param1:int) : Boolean {
         return param1 > this.startTime_ + this.periodMS_ * this.repeats_;
      }
   }
}
