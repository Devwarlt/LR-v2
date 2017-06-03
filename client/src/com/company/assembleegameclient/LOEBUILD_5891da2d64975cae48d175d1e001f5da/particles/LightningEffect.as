package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;
import com.company.assembleegameclient.util.RandomUtil;

import flash.geom.Point;

import kabam.rotmg.messaging.impl.data.WorldPosData;

public class LightningEffect extends ParticleEffect {

      public var start_:Point;

      public var end_:Point;

      public var color_:int;

      public var particleSize_:int;

      public var lifetimeMultiplier_:Number;

      public function LightningEffect(param1:GameObject, param2:WorldPosData, param3:int, param4:int, param5:* = 1.0) {
         super();
         this.start_ = new Point(param1.x_,param1.y_);
         this.end_ = new Point(param2.x_,param2.y_);
         this.color_ = param3;
         this.particleSize_ = param4;
         this.lifetimeMultiplier_ = param5;
      }

      override public function runNormalRendering(param1:int, param2:int) : Boolean {
         var _local6:Point = null;
         var _local7:Particle = null;
         var _local8:Number = NaN;
         x_ = this.start_.x;
         y_ = this.start_.y;
         var _local3:Number = Point.distance(this.start_,this.end_);
         var _local4:int = _local3 * 3;
         var _local5:int = 0;
         while(_local5 < _local4) {
            _local6 = Point.interpolate(this.start_,this.end_,_local5 / _local4);
            _local7 = new SparkParticle(this.particleSize_,this.color_,1000 * this.lifetimeMultiplier_ - _local5 / _local4 * 900 * this.lifetimeMultiplier_,0.5,0,0);
            _local8 = Math.min(_local5,_local4 - _local5);
            map_.addObj(_local7,_local6.x + RandomUtil.plusMinus(_local3 / 200 * _local8),_local6.y + RandomUtil.plusMinus(_local3 / 200 * _local8));
            _local5++;
         }
         return false;
      }

      override public function runEasyRendering(param1:int, param2:int) : Boolean {
         var _local6:Point = null;
         var _local7:Particle = null;
         var _local8:Number = NaN;
         x_ = this.start_.x;
         y_ = this.start_.y;
         var _local3:Number = Point.distance(this.start_,this.end_);
         var _local4:int = _local3 * 2;
         this.particleSize_ = 80;
         var _local5:int = 0;
         while(_local5 < _local4) {
            _local6 = Point.interpolate(this.start_,this.end_,_local5 / _local4);
            _local7 = new SparkParticle(this.particleSize_,this.color_,750 * this.lifetimeMultiplier_ - _local5 / _local4 * 675 * this.lifetimeMultiplier_,0.5,0,0);
            _local8 = Math.min(_local5,_local4 - _local5);
            map_.addObj(_local7,_local6.x + RandomUtil.plusMinus(_local3 / 200 * _local8),_local6.y + RandomUtil.plusMinus(_local3 / 200 * _local8));
            _local5++;
         }
         return false;
      }
   }
}
