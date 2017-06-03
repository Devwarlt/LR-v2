package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_357498e03a88a17f471aba561d9fe677 {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles.ParticleEffect;

import flash.geom.Point;

public class LOEBUILD_1c9fba6513bfdb9d6c091f95f1c141d4 extends ParticleEffect {

      public var start_:Point;

      public var end_:Point;

      public var id_:uint;

      public function LOEBUILD_1c9fba6513bfdb9d6c091f95f1c141d4(param1:int, param2:Point, param3:Point) {
         super();
         this.start_ = param2;
         this.end_ = param3;
         this.id_ = param1;
      }

      override public function update(param1:int, param2:int) : Boolean {
         x_ = this.start_.x;
         y_ = this.start_.y;
         var _local3:int = 10000;
         var _local4:LOEBUILD_570e0948fc87023c882549c593986f1f = new LOEBUILD_570e0948fc87023c882549c593986f1f(this.id_,1500,this.start_,this.end_);
         map_.addObj(_local4,x_,y_);
         return false;
      }
   }
}
