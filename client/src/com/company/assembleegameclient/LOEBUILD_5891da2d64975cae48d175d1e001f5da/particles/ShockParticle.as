package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_357498e03a88a17f471aba561d9fe677.LOEBUILD_36a1e9f17e9ea841bd8f16369ecd212e;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;

import flash.display.BitmapData;
import flash.geom.Point;

public class ShockParticle extends LOEBUILD_36a1e9f17e9ea841bd8f16369ecd212e {

      private var numFramesRemaining:int;

      private var dx_:Number;

      private var dy_:Number;

      private var originX:Number;

      private var originY:Number;

      private var radians:Number;

      private var frameUpdateModulator:uint = 0;

      private var currentFrame:uint = 0;

      private var numFrames:uint;

      private var go:GameObject;

      private var plusX:Number = 0;

      private var plusY:Number = 0;

      private var cameraAngle:Number;

      private var images:Vector.<BitmapData>;

      public function ShockParticle(param1:uint, param2:int, param3:uint, param4:Point, param5:Point, param6:Number, param7:GameObject, param8:Vector.<BitmapData>) {
         this.cameraAngle = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.cameraAngle;
         this.go = param7;
         this.radians = param6;
         this.images = param8;
         super(param8[0],0);
         this.numFrames = param8.length;
         this.numFramesRemaining = param2;
         this.dx_ = (param5.x - param4.x) / this.numFramesRemaining;
         this.dy_ = (param5.y - param4.y) / this.numFramesRemaining;
         this.originX = param4.x - param7.x_;
         this.originY = param4.y - param7.y_;
         _rotation = -param6 - this.cameraAngle;
      }

      override public function update(param1:int, param2:int) : Boolean {
         this.numFramesRemaining--;
         if(this.numFramesRemaining <= 0) {
            return false;
         }
         this.frameUpdateModulator++;
         if(this.frameUpdateModulator % 2) {
            this.currentFrame++;
         }
         _bitmapData = this.images[this.currentFrame % this.numFrames];
         this.plusX = this.plusX + this.dx_;
         this.plusY = this.plusY + this.dy_;
         if(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.cameraAngle != this.cameraAngle) {
            this.cameraAngle = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.cameraAngle;
            _rotation = -this.radians - this.cameraAngle;
         }
         moveTo(this.go.x_ + this.originX + this.plusX,this.go.y_ + this.originY + this.plusY);
         return true;
      }
   }
}
