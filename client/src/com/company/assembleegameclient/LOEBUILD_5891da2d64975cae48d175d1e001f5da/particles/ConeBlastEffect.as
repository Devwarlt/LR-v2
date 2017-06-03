package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;

import flash.geom.Point;

import kabam.rotmg.messaging.impl.data.WorldPosData;

public class ConeBlastEffect extends ParticleEffect {

      public var start_:Point;

      public var target_:WorldPosData;

      public var blastRadius_:Number;

      public var color_:int;

      public function ConeBlastEffect(param1:GameObject, param2:WorldPosData, param3:Number, param4:int) {
         super();
         this.start_ = new Point(param1.x_,param1.y_);
         this.target_ = param2;
         this.blastRadius_ = param3;
         this.color_ = param4;
      }

      override public function runNormalRendering(param1:int, param2:int) : Boolean {
         var _local9:Number = NaN;
         var _local10:Point = null;
         var _local11:Particle = null;
         x_ = this.start_.x;
         y_ = this.start_.y;
         var _local3:int = 200;
         var _local4:int = 100;
         var _local5:Number = Math.PI / 3;
         var _local6:int = 7;
         var _local7:Number = Math.atan2(this.target_.y_ - this.start_.y,this.target_.x_ - this.start_.x);
         var _local8:int = 0;
         while(_local8 < _local6) {
            _local9 = _local7 - _local5 / 2 + _local8 * _local5 / _local6;
            _local10 = new Point(this.start_.x + this.blastRadius_ * Math.cos(_local9),this.start_.y + this.blastRadius_ * Math.sin(_local9));
            _local11 = new SparkerParticle(_local3,this.color_,_local4,this.start_,_local10);
            map_.addObj(_local11,x_,y_);
            _local8++;
         }
         return false;
      }

      override public function runEasyRendering(param1:int, param2:int) : Boolean {
         var _local9:Number = NaN;
         var _local10:Point = null;
         var _local11:Particle = null;
         x_ = this.start_.x;
         y_ = this.start_.y;
         var _local3:int = 50;
         var _local4:int = 10;
         var _local5:Number = Math.PI / 3;
         var _local6:int = 5;
         var _local7:Number = Math.atan2(this.target_.y_ - this.start_.y,this.target_.x_ - this.start_.x);
         var _local8:int = 0;
         while(_local8 < _local6) {
            _local9 = _local7 - _local5 / 2 + _local8 * _local5 / _local6;
            _local10 = new Point(this.start_.x + this.blastRadius_ * Math.cos(_local9),this.start_.y + this.blastRadius_ * Math.sin(_local9));
            _local11 = new SparkerParticle(_local3,this.color_,_local4,this.start_,_local10);
            map_.addObj(_local11,x_,y_);
            _local8++;
         }
         return false;
      }
   }
}
