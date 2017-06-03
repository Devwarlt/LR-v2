package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da {
import com.company.assembleegameclient.LOEBUILD_c0a0ad5a20fa962e79dbafea298b8ea4.LOEBUILD_f09b627d212c86ff198f3f77f532cdf5;
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Square;
import com.company.util.BitmapUtil;

import flash.display.BitmapData;
import flash.display.IGraphicsData;

public class Wall extends GameObject {

      private static const UVT:Vector.<Number> = new <Number>[0,0,0,1,0,0,1,1,0,0,1,0];

      private static const sqX:Vector.<int> = new <int>[0,1,0,-1];

      private static const sqY:Vector.<int> = new <int>[-1,0,1,0];

      public var faces_:Vector.<LOEBUILD_f09b627d212c86ff198f3f77f532cdf5>;

      private var topFace_:LOEBUILD_f09b627d212c86ff198f3f77f532cdf5 = null;

      private var topTexture_:BitmapData = null;

      public function Wall(param1:XML) {
         this.faces_ = new Vector.<LOEBUILD_f09b627d212c86ff198f3f77f532cdf5>();
         super(param1);
         hasShadow_ = false;
         var _local2:TextureData = LOEBUILD_efda783509bc93eea698457c87bbee3f.typeToTopTextureData_[objectType_];
         this.topTexture_ = _local2.getTexture(0);
      }

      override public function setObjectId(param1:int) : void {
         super.setObjectId(param1);
         var _local2:TextureData = LOEBUILD_efda783509bc93eea698457c87bbee3f.typeToTopTextureData_[objectType_];
         this.topTexture_ = _local2.getTexture(param1);
      }

      override public function getColor() : uint {
         return BitmapUtil.mostCommonColor(this.topTexture_);
      }

      override public function draw(param1:Vector.<IGraphicsData>, param2:Camera, param3:int) : void {
         var _local6:BitmapData = null;
         var _local7:LOEBUILD_f09b627d212c86ff198f3f77f532cdf5 = null;
         var _local8:Square = null;
         if(texture_ == null) {
            return;
         }
         if(this.faces_.length == 0) {
            this.rebuild3D();
         }
         var _local4:BitmapData = texture_;
         if(animations_ != null) {
            _local6 = animations_.getTexture(param3);
            if(_local6 != null) {
               _local4 = _local6;
            }
         }
         var _local5:int = 0;
         while(_local5 < this.faces_.length) {
            _local7 = this.faces_[_local5];
            _local8 = map_.lookupSquare(x_ + sqX[_local5],y_ + sqY[_local5]);
            if(_local8 == null || _local8.texture_ == null || _local8 != null && _local8.obj_ is Wall && !_local8.obj_.dead_) {
               _local7.blackOut_ = true;
            } else {
               _local7.blackOut_ = false;
               if(animations_ != null) {
                  _local7.setTexture(_local4);
               }
            }
            _local7.draw(param1,param2);
            _local5++;
         }
         this.topFace_.draw(param1,param2);
      }

      public function rebuild3D() : void {
         this.faces_.length = 0;
         var _local1:int = x_;
         var _local2:int = y_;
         var _local3:Vector.<Number> = new <Number>[_local1,_local2,1,_local1 + 1,_local2,1,_local1 + 1,_local2 + 1,1,_local1,_local2 + 1,1];
         this.topFace_ = new LOEBUILD_f09b627d212c86ff198f3f77f532cdf5(this.topTexture_,_local3,UVT,false,true);
         this.topFace_.bitmapFill_.repeat = true;
         this.addWall(_local1,_local2,1,_local1 + 1,_local2,1);
         this.addWall(_local1 + 1,_local2,1,_local1 + 1,_local2 + 1,1);
         this.addWall(_local1 + 1,_local2 + 1,1,_local1,_local2 + 1,1);
         this.addWall(_local1,_local2 + 1,1,_local1,_local2,1);
      }

      private function addWall(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void {
         var _local7:Vector.<Number> = new <Number>[param1,param2,param3,param4,param5,param6,param4,param5,param6 - 1,param1,param2,param3 - 1];
         var _local8:LOEBUILD_f09b627d212c86ff198f3f77f532cdf5 = new LOEBUILD_f09b627d212c86ff198f3f77f532cdf5(texture_,_local7,UVT,true,true);
         _local8.bitmapFill_.repeat = true;
         this.faces_.push(_local8);
      }
   }
}
