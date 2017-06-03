package com.company.assembleegameclient.LOEBUILD_c0a0ad5a20fa962e79dbafea298b8ea4 {
import flash.display.BitmapData;
import flash.geom.Matrix;

public class LOEBUILD_564a5d93991a252df798213e5b179eb8 {

      public var texture_:BitmapData = null;

      public var tToS_:Matrix;

      private var uvMatrix_:Matrix = null;

      private var tempMatrix_:Matrix;

      public function LOEBUILD_564a5d93991a252df798213e5b179eb8(param1:BitmapData, param2:Vector.<Number>) {
         this.tToS_ = new Matrix();
         this.tempMatrix_ = new Matrix();
         super();
         this.texture_ = param1;
         this.calculateUVMatrix(param2);
      }

      public function setUVT(param1:Vector.<Number>) : void {
         this.calculateUVMatrix(param1);
      }

      public function setVOut(param1:Vector.<Number>) : void {
         this.calculateTextureMatrix(param1);
      }

      public function calculateTextureMatrix(param1:Vector.<Number>) : void {
         this.tToS_.a = this.uvMatrix_.a;
         this.tToS_.b = this.uvMatrix_.b;
         this.tToS_.c = this.uvMatrix_.c;
         this.tToS_.d = this.uvMatrix_.d;
         this.tToS_.tx = this.uvMatrix_.tx;
         this.tToS_.ty = this.uvMatrix_.ty;
         var _local2:int = param1.length - 2;
         var _local3:int = _local2 + 1;
         this.tempMatrix_.a = param1[2] - param1[0];
         this.tempMatrix_.b = param1[3] - param1[1];
         this.tempMatrix_.c = param1[_local2] - param1[0];
         this.tempMatrix_.d = param1[_local3] - param1[1];
         this.tempMatrix_.tx = param1[0];
         this.tempMatrix_.ty = param1[1];
         this.tToS_.concat(this.tempMatrix_);
      }

      public function calculateUVMatrix(param1:Vector.<Number>) : void {
         if(this.texture_ == null) {
            this.uvMatrix_ = null;
            return;
         }
         var _local2:int = param1.length - 3;
         var _local3:Number = param1[0] * this.texture_.width;
         var _local4:Number = param1[1] * this.texture_.height;
         var _local5:Number = param1[3] * this.texture_.width;
         var _local6:Number = param1[4] * this.texture_.height;
         var _local7:Number = param1[_local2] * this.texture_.width;
         var _local8:Number = param1[_local2 + 1] * this.texture_.height;
         var _local9:Number = _local5 - _local3;
         var _local10:Number = _local6 - _local4;
         var _local11:Number = _local7 - _local3;
         var _local12:Number = _local8 - _local4;
         this.uvMatrix_ = new Matrix(_local9,_local10,_local11,_local12,_local3,_local4);
         this.uvMatrix_.invert();
      }
   }
}
