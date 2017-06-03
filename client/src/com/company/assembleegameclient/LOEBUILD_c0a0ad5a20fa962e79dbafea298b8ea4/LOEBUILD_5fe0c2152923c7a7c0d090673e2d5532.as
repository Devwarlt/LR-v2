package com.company.assembleegameclient.LOEBUILD_c0a0ad5a20fa962e79dbafea298b8ea4 {
import flash.geom.Vector3D;

public class LOEBUILD_5fe0c2152923c7a7c0d090673e2d5532 {

      public static const LIGHT_VECTOR:Vector3D = createLightVector();

      public function LOEBUILD_5fe0c2152923c7a7c0d090673e2d5532() {
         super();
      }

      public static function shadeValue(param1:Vector3D, param2:Number) : Number {
         var _local3:Number = Math.max(0,param1.dotProduct(LOEBUILD_5fe0c2152923c7a7c0d090673e2d5532.LIGHT_VECTOR));
         return param2 + (1 - param2) * _local3;
      }

      private static function createLightVector() : Vector3D {
         var _local1:Vector3D = new Vector3D(1,3,2);
         _local1.normalize();
         return _local1;
      }
   }
}
