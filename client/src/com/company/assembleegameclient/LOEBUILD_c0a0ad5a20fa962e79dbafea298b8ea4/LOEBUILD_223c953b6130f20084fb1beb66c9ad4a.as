package com.company.assembleegameclient.LOEBUILD_c0a0ad5a20fa962e79dbafea298b8ea4 {
import flash.geom.Vector3D;

public class LOEBUILD_223c953b6130f20084fb1beb66c9ad4a {

      public var v0_:Vector3D;

      public var v1_:Vector3D;

      public function LOEBUILD_223c953b6130f20084fb1beb66c9ad4a(param1:Vector3D, param2:Vector3D) {
         super();
         this.v0_ = param1;
         this.v1_ = param2;
      }

      public static function unitTest() : Boolean {
         return UnitTest.run();
      }

      public function crossZ(param1:LOEBUILD_223c953b6130f20084fb1beb66c9ad4a) : int {
         var _local2:Number = (param1.v1_.y - param1.v0_.y) * (this.v1_.x - this.v0_.x) - (param1.v1_.x - param1.v0_.x) * (this.v1_.y - this.v0_.y);
         if(_local2 < 0.001 && _local2 > -0.001) {
            return LOEBUILD_a240fa27925a635b08dc28c9e4f9216d.NEITHER;
         }
         var _local3:Number = (param1.v1_.x - param1.v0_.x) * (this.v0_.y - param1.v0_.y) - (param1.v1_.y - param1.v0_.y) * (this.v0_.x - param1.v0_.x);
         var _local4:Number = (this.v1_.x - this.v0_.x) * (this.v0_.y - param1.v0_.y) - (this.v1_.y - this.v0_.y) * (this.v0_.x - param1.v0_.x);
         if(_local3 < 0.001 && _local3 > -0.001 && _local4 < 0.001 && _local4 > -0.001) {
            return LOEBUILD_a240fa27925a635b08dc28c9e4f9216d.NEITHER;
         }
         var _local5:Number = _local3 / _local2;
         var _local6:Number = _local4 / _local2;
         if(_local5 > 1 || _local5 < 0 || _local6 > 1 || _local6 < 0) {
            return LOEBUILD_a240fa27925a635b08dc28c9e4f9216d.NEITHER;
         }
         var _local7:Number = this.v0_.z + _local5 * (this.v1_.z - this.v0_.z) - (param1.v0_.z + _local6 * (param1.v1_.z - param1.v0_.z));
         if(_local7 < 0.001 && _local7 > -0.001) {
            return LOEBUILD_a240fa27925a635b08dc28c9e4f9216d.NEITHER;
         }
         if(_local7 > 0) {
            return LOEBUILD_a240fa27925a635b08dc28c9e4f9216d.IN_FRONT;
         }
         return LOEBUILD_a240fa27925a635b08dc28c9e4f9216d.BEHIND;
      }

      public function lerp(param1:Number) : Vector3D {
         return new Vector3D(this.v0_.x + (this.v1_.x - this.v0_.x) * param1,this.v0_.y + (this.v1_.y - this.v0_.y) * param1,this.v0_.z + (this.v1_.z - this.v0_.z) * param1);
      }

      public function toString() : String {
         return "(" + this.v0_ + ", " + this.v1_ + ")";
      }
   }
}

import com.company.assembleegameclient.LOEBUILD_c0a0ad5a20fa962e79dbafea298b8ea4.LOEBUILD_223c953b6130f20084fb1beb66c9ad4a;
import com.company.assembleegameclient.LOEBUILD_c0a0ad5a20fa962e79dbafea298b8ea4.LOEBUILD_a240fa27925a635b08dc28c9e4f9216d;

import flash.geom.Vector3D;

class UnitTest {

   function UnitTest() {
      super();
   }

   private static function testCrossZ() : Boolean {
      var _local1:LOEBUILD_223c953b6130f20084fb1beb66c9ad4a = new LOEBUILD_223c953b6130f20084fb1beb66c9ad4a(new Vector3D(0,0,0),new Vector3D(0,100,0));
      var _local2:LOEBUILD_223c953b6130f20084fb1beb66c9ad4a = new LOEBUILD_223c953b6130f20084fb1beb66c9ad4a(new Vector3D(10,0,10),new Vector3D(-10,100,-100));
      if(_local1.crossZ(_local2) != LOEBUILD_a240fa27925a635b08dc28c9e4f9216d.IN_FRONT) {
         return false;
      }
      if(_local2.crossZ(_local1) != LOEBUILD_a240fa27925a635b08dc28c9e4f9216d.BEHIND) {
         return false;
      }
      _local1 = new LOEBUILD_223c953b6130f20084fb1beb66c9ad4a(new Vector3D(1,1,200),new Vector3D(6,6,200));
      _local2 = new LOEBUILD_223c953b6130f20084fb1beb66c9ad4a(new Vector3D(3,1,-100),new Vector3D(1,3,-100));
      if(_local1.crossZ(_local2) != LOEBUILD_a240fa27925a635b08dc28c9e4f9216d.IN_FRONT) {
         return false;
      }
      if(_local2.crossZ(_local1) != LOEBUILD_a240fa27925a635b08dc28c9e4f9216d.BEHIND) {
         return false;
      }
      return true;
   }

   public static function run() : Boolean {
      if(!testCrossZ()) {
         return false;
      }
      return true;
   }
}
