package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_357498e03a88a17f471aba561d9fe677 {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;
import com.company.assembleegameclient.util.TextureRedrawer;

import flash.display.BitmapData;
import flash.geom.Point;

public class LOEBUILD_570e0948fc87023c882549c593986f1f extends LOEBUILD_36a1e9f17e9ea841bd8f16369ecd212e {

      public var lifetime_:int;

      public var timeLeft_:int;

      public var start_:Point;

      public var end_:Point;

      public var dx_:Number;

      public var dy_:Number;

      public var pathX_:Number;

      public var pathY_:Number;

      private var bitmapData:BitmapData;

      public function LOEBUILD_570e0948fc87023c882549c593986f1f(param1:uint, param2:int, param3:Point, param4:Point) {
         this.bitmapData = LOEBUILD_efda783509bc93eea698457c87bbee3f.getTextureFromType(param1);
         this.bitmapData = TextureRedrawer.redraw(this.bitmapData,80,true,0,false);
         _rotationDelta = 0.2;
         super(this.bitmapData,0);
         this.lifetime_ = this.timeLeft_ = param2;
         this.start_ = param3;
         this.end_ = param4;
         this.dx_ = (this.end_.x - this.start_.x) / this.timeLeft_;
         this.dy_ = (this.end_.y - this.start_.y) / this.timeLeft_;
         var _local5:Number = Point.distance(param3,param4) / this.timeLeft_;
         this.pathX_ = x_ = this.start_.x;
         this.pathY_ = y_ = this.start_.y;
      }

      override public function update(param1:int, param2:int) : Boolean {
         this.timeLeft_ = this.timeLeft_ - param2;
         if(this.timeLeft_ <= 0) {
            return false;
         }
         z_ = Math.sin(this.timeLeft_ / this.lifetime_ * Math.PI) * 2;
         setSize(z_);
         this.pathX_ = this.pathX_ + this.dx_ * param2;
         this.pathY_ = this.pathY_ + this.dy_ * param2;
         moveTo(this.pathX_,this.pathY_);
         return true;
      }
   }
}
