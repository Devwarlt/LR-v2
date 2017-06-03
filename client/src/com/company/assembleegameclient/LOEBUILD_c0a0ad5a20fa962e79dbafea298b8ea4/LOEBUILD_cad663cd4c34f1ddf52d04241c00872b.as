package com.company.assembleegameclient.LOEBUILD_c0a0ad5a20fa962e79dbafea298b8ea4 {
import flash.geom.Vector3D;

public class LOEBUILD_cad663cd4c34f1ddf52d04241c00872b {

      public static const NONE:int = 0;

      public static const POSITIVE:int = 1;

      public static const NEGATIVE:int = 2;

      public static const EQUAL:int = 3;

      public var normal_:Vector3D;

      public var d_:Number;

      public function LOEBUILD_cad663cd4c34f1ddf52d04241c00872b(param1:Vector3D = null, param2:Vector3D = null, param3:Vector3D = null) {
         super();
         if(param1 != null && param2 != null && param3 != null) {
            this.normal_ = new Vector3D();
            computeNormal(param1,param2,param3,this.normal_);
            this.d_ = -this.normal_.dotProduct(param1);
         }
      }

      public static function computeNormal(param1:Vector3D, param2:Vector3D, param3:Vector3D, param4:Vector3D) : void {
         var _local5:Number = param2.x - param1.x;
         var _local6:Number = param2.y - param1.y;
         var _local7:Number = param2.z - param1.z;
         var _local8:Number = param3.x - param1.x;
         var _local9:Number = param3.y - param1.y;
         var _local10:Number = param3.z - param1.z;
         param4.x = _local6 * _local10 - _local7 * _local9;
         param4.y = _local7 * _local8 - _local5 * _local10;
         param4.z = _local5 * _local9 - _local6 * _local8;
         param4.normalize();
      }

      public static function computeNormalVec(param1:Vector.<Number>, param2:Vector3D) : void {
         var _local3:Number = param1[3] - param1[0];
         var _local4:Number = param1[4] - param1[1];
         var _local5:Number = param1[5] - param1[2];
         var _local6:Number = param1[6] - param1[0];
         var _local7:Number = param1[7] - param1[1];
         var _local8:Number = param1[8] - param1[2];
         param2.x = _local4 * _local8 - _local5 * _local7;
         param2.y = _local5 * _local6 - _local3 * _local8;
         param2.z = _local3 * _local7 - _local4 * _local6;
         param2.normalize();
      }

      public function testPoint(param1:Vector3D) : int {
         var _local2:Number = this.normal_.dotProduct(param1) + this.d_;
         if(_local2 > 0.001) {
            return POSITIVE;
         }
         if(_local2 < -0.001) {
            return NEGATIVE;
         }
         return EQUAL;
      }

      public function lineIntersect(param1:LOEBUILD_223c953b6130f20084fb1beb66c9ad4a) : Number {
         var _local2:Number = -this.d_ - this.normal_.x * param1.v0_.x - this.normal_.y * param1.v0_.y - this.normal_.z * param1.v0_.z;
         var _local3:Number = this.normal_.x * (param1.v1_.x - param1.v0_.x) + this.normal_.y * (param1.v1_.y - param1.v0_.y) + this.normal_.z * (param1.v1_.z - param1.v0_.z);
         if(_local3 == 0) {
            return NaN;
         }
         return _local2 / _local3;
      }

      public function zAtXY(param1:Number, param2:Number) : Number {
         return -(this.d_ + this.normal_.x * param1 + this.normal_.y * param2) / this.normal_.z;
      }

      public function toString() : String {
         return "Plane(n = " + this.normal_ + ", d = " + this.d_ + ")";
      }
   }
}
