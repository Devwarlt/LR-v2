package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;
import com.company.assembleegameclient.util.RandomUtil;

import flash.geom.Point;

import kabam.rotmg.messaging.impl.data.WorldPosData;

public class LineEffect extends ParticleEffect {

      public var start_:Point;

      public var end_:Point;

      public var color_:int;

      public function LineEffect(param1:GameObject, param2:WorldPosData, param3:int) {
         super();
         this.start_ = new Point(param1.x_,param1.y_);
         this.end_ = new Point(param2.x_,param2.y_);
         this.color_ = param3;
      }

      override public function runNormalRendering(param1:int, param2:int) : Boolean {
         var _local5:Point = null;
         var _local6:Particle = null;
         x_ = this.start_.x;
         y_ = this.start_.y;
         var _local3:int = 30;
         var _local4:int = 0;
         while(_local4 < _local3) {
            _local5 = Point.interpolate(this.start_,this.end_,_local4 / _local3);
            _local6 = new SparkParticle(100,this.color_,700,0.5,RandomUtil.plusMinus(1),RandomUtil.plusMinus(1));
            map_.addObj(_local6,_local5.x,_local5.y);
            _local4++;
         }
         return false;
      }

      override public function runEasyRendering(param1:int, param2:int) : Boolean {
         var _local5:Point = null;
         var _local6:Particle = null;
         x_ = this.start_.x;
         y_ = this.start_.y;
         var _local3:int = 5;
         var _local4:int = 0;
         while(_local4 < _local3) {
            _local5 = Point.interpolate(this.start_,this.end_,_local4 / _local3);
            _local6 = new SparkParticle(100,this.color_,200,0.5,RandomUtil.plusMinus(1),RandomUtil.plusMinus(1));
            map_.addObj(_local6,_local5.x,_local5.y);
            _local4++;
         }
         return false;
      }
   }
}
