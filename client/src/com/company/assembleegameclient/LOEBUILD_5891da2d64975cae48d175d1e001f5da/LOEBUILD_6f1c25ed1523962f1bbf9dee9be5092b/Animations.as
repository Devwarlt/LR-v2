package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_6f1c25ed1523962f1bbf9dee9be5092b {
import flash.display.BitmapData;

public class Animations {

      public var animationsData_:LOEBUILD_b98058c639863689a15a54bd69990a3b;

      public var nextRun_:Vector.<int> = null;

      public var running_:RunningAnimation = null;

      public function Animations(param1:LOEBUILD_b98058c639863689a15a54bd69990a3b) {
         super();
         this.animationsData_ = param1;
      }

      public function getTexture(param1:int) : BitmapData {
         var _local2:LOEBUILD_adcfc1509a27774281fc0bb13e68643a = null;
         var _local4:BitmapData = null;
         var _local5:int = 0;
         if(this.nextRun_ == null) {
            this.nextRun_ = new Vector.<int>();
            for each(_local2 in this.animationsData_.animations) {
               this.nextRun_.push(_local2.getLastRun(param1));
            }
         }
         if(this.running_ != null) {
            _local4 = this.running_.getTexture(param1);
            if(_local4 != null) {
               return _local4;
            }
            this.running_ = null;
         }
         var _local3:int = 0;
         while(_local3 < this.nextRun_.length) {
            if(param1 > this.nextRun_[_local3]) {
               _local5 = this.nextRun_[_local3];
               _local2 = this.animationsData_.animations[_local3];
               this.nextRun_[_local3] = _local2.getNextRun(param1);
               if(!(_local2.prob_ != 1 && Math.random() > _local2.prob_)) {
                  this.running_ = new RunningAnimation(_local2,_local5);
                  return this.running_.getTexture(param1);
               }
            }
            _local3++;
         }
         return null;
      }
   }
}

import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_6f1c25ed1523962f1bbf9dee9be5092b.LOEBUILD_adcfc1509a27774281fc0bb13e68643a;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_6f1c25ed1523962f1bbf9dee9be5092b.LOEBUILD_d6e408b692f1e72c58127dbaed95ebe4;

import flash.display.BitmapData;

class RunningAnimation {

   public var animationData_:LOEBUILD_adcfc1509a27774281fc0bb13e68643a;

   public var start_:int;

   public var frameId_:int;

   public var frameStart_:int;

   public var texture_:BitmapData;

   function RunningAnimation(param1:LOEBUILD_adcfc1509a27774281fc0bb13e68643a, param2:int) {
      super();
      this.animationData_ = param1;
      this.start_ = param2;
      this.frameId_ = 0;
      this.frameStart_ = param2;
      this.texture_ = null;
   }

   public function getTexture(param1:int) : BitmapData {
      var _local2:LOEBUILD_d6e408b692f1e72c58127dbaed95ebe4 = this.animationData_.frames[this.frameId_];
      while(param1 - this.frameStart_ > _local2.time_) {
         if(this.frameId_ >= this.animationData_.frames.length - 1) {
            return null;
         }
         this.frameStart_ = this.frameStart_ + _local2.time_;
         this.frameId_++;
         _local2 = this.animationData_.frames[this.frameId_];
         this.texture_ = null;
      }
      if(this.texture_ == null) {
         this.texture_ = _local2.textureData_.getTexture(Math.random() * 100);
      }
      return this.texture_;
   }
}
