package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da {
import com.company.assembleegameclient.LOEBUILD_c0a0ad5a20fa962e79dbafea298b8ea4.Object3D;
import com.company.assembleegameclient.LOEBUILD_c0a0ad5a20fa962e79dbafea298b8ea4.LOEBUILD_1466625a8b6887d3e91cda3e12e5a036;

public class Stalagmite extends GameObject {

      private static const bs:Number = Math.PI / 6;

      private static const cs:Number = Math.PI / 3;

      public function Stalagmite(param1:XML) {
         super(param1);
         var _local2:Number = bs + cs * Math.random();
         var _local3:Number = 2 * cs + bs + cs * Math.random();
         var _local4:Number = 4 * cs + bs + cs * Math.random();
         obj3D_ = new Object3D();
         obj3D_.vL_.push(Math.cos(_local2) * 0.3,Math.sin(_local2) * 0.3,0,Math.cos(_local3) * 0.3,Math.sin(_local3) * 0.3,0,Math.cos(_local4) * 0.3,Math.sin(_local4) * 0.3,0,0,0,0.6 + 0.6 * Math.random());
         obj3D_.faces_.push(new LOEBUILD_1466625a8b6887d3e91cda3e12e5a036(obj3D_,new <int>[0,1,3]),new LOEBUILD_1466625a8b6887d3e91cda3e12e5a036(obj3D_,new <int>[1,2,3]),new LOEBUILD_1466625a8b6887d3e91cda3e12e5a036(obj3D_,new <int>[2,0,3]));
         obj3D_.uvts_.push(0,1,0,0.5,1,0,1,1,0,0.5,0,0);
      }
   }
}
