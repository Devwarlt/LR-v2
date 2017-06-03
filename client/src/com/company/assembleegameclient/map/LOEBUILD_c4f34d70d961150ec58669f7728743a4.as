package com.company.assembleegameclient.map {
import com.company.assembleegameclient.LOEBUILD_c0a0ad5a20fa962e79dbafea298b8ea4.LOEBUILD_f09b627d212c86ff198f3f77f532cdf5;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;

import flash.display.BitmapData;
import flash.display.IGraphicsData;

import kabam.rotmg.stage3D.GraphicsFillExtra;

public class LOEBUILD_c4f34d70d961150ec58669f7728743a4 {

      public var animate_:int;

      public var face_:LOEBUILD_f09b627d212c86ff198f3f77f532cdf5;

      public var xOffset_:Number = 0;

      public var yOffset_:Number = 0;

      public var animateDx_:Number = 0;

      public var animateDy_:Number = 0;

      public function LOEBUILD_c4f34d70d961150ec58669f7728743a4(param1:BitmapData, param2:Vector.<Number>, param3:Number, param4:Number, param5:int, param6:Number, param7:Number) {
         super();
         this.face_ = new LOEBUILD_f09b627d212c86ff198f3f77f532cdf5(param1,param2,Square.UVT.concat());
         this.xOffset_ = param3;
         this.yOffset_ = param4;
         if(this.xOffset_ != 0 || this.yOffset_ != 0) {
            this.face_.bitmapFill_.repeat = true;
         }
         this.animate_ = param5;
         if(this.animate_ != LOEBUILD_463df66a32ccee700fe56a1531ecc43e.NO_ANIMATE) {
            this.face_.bitmapFill_.repeat = true;
         }
         this.animateDx_ = param6;
         this.animateDy_ = param7;
      }

      public function dispose() : void {
         this.face_.dispose();
         this.face_ = null;
      }

      public function draw(param1:Vector.<IGraphicsData>, param2:Camera, param3:int) : Boolean {
         var _local4:Number = NaN;
         var _local5:Number = NaN;
         if(this.animate_ != LOEBUILD_463df66a32ccee700fe56a1531ecc43e.NO_ANIMATE) {
            switch(this.animate_) {
               case LOEBUILD_463df66a32ccee700fe56a1531ecc43e.WAVE_ANIMATE:
                  _local4 = this.xOffset_ + Math.sin(this.animateDx_ * param3 / 1000);
                  _local5 = this.yOffset_ + Math.sin(this.animateDy_ * param3 / 1000);
                  break;
               case LOEBUILD_463df66a32ccee700fe56a1531ecc43e.FLOW_ANIMATE:
                  _local4 = this.xOffset_ + this.animateDx_ * param3 / 1000;
                  _local5 = this.yOffset_ + this.animateDy_ * param3 / 1000;
            }
         } else {
            _local4 = this.xOffset_;
            _local5 = this.yOffset_;
         }
         if(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.isGpuRender()) {
            GraphicsFillExtra.setOffsetUV(this.face_.bitmapFill_,_local4,_local5);
            _local4 = _local5 = 0;
         }
         this.face_.uvt_.length = 0;
         this.face_.uvt_.push(0 + _local4,0 + _local5,0,1 + _local4,0 + _local5,0,1 + _local4,1 + _local5,0,0 + _local4,1 + _local5,0);
         this.face_.setUVT(this.face_.uvt_);
         return this.face_.draw(param1,param2);
      }
   }
}
