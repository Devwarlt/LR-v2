package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles {
import flash.geom.Point;

import kabam.rotmg.messaging.impl.data.WorldPosData;

public class ConfettiEffect extends ParticleEffect {

      public var start_:Point;

      public var end_:Point;

      public var color_:int;

      public var lifetime_:int;

      public var confettiColor_:Boolean = false;

      public function ConfettiEffect(param1:WorldPosData, param2:WorldPosData, param3:int, param4:int, param5:Boolean = false) {
         super();
         this.start_ = new Point(param1.x_,param1.y_);
         this.end_ = new Point(param2.x_,param2.y_);
         this.color_ = param3;
         this.lifetime_ = param4;
         this.confettiColor_ = param5;
      }

      override public function update(param1:int, param2:int) : Boolean {
         var _local4:int = 0;
         var _local7:int = 0;
         var _local8:ConfettiParticle = null;
         x_ = this.start_.x;
         y_ = this.start_.y;
         var _local3:int = 5;
         var _local5:Array = [65535,16711935,16776960,16777215];
         var _local6:int = 0;
         while(_local6 < _local3) {
            if(this.confettiColor_) {
               _local4 = _local5[int(Math.floor(Math.random() * (_local5.length + 1)))];
            } else {
               _local4 = this.color_;
            }
            _local7 = (3 + int(Math.random() * 5)) * 20;
            _local8 = new ConfettiParticle(1.85,_local7,_local4,500 * this.lifetime_ + Math.random() * 500 * this.lifetime_,0.1 + Math.random() * 0.1,this.start_,this.end_);
            map_.addObj(_local8,x_,y_);
            _local6++;
         }
         return false;
      }
   }
}

import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles.Particle;

import flash.geom.Point;
import flash.geom.Vector3D;

class ConfettiParticle extends Particle {

   public var timeLeft_:int;

   protected var moveVec_:Vector3D;

   public var start_:Point;

   public var end_:Point;

   public var dx_:Number;

   public var dy_:Number;

   public var pathX_:Number;

   public var pathY_:Number;

   public var xDeflect_:Number;

   public var yDeflect_:Number;

   public var period_:Number;

   function ConfettiParticle(param1:Number, param2:int, param3:int, param4:int, param5:Number, param6:Point, param7:Point) {
      this.moveVec_ = new Vector3D();
      super(param3,param1,param2);
      this.moveVec_.z = param5;
      this.timeLeft_ = param4;
      this.start_ = param6;
      this.end_ = param7;
      this.dx_ = (this.end_.x - this.start_.x) / this.timeLeft_;
      this.dy_ = (this.end_.y - this.start_.y) / this.timeLeft_;
      var _local8:Number = Point.distance(param6,param7) / this.timeLeft_;
      var _local9:Number = 0.25;
      this.xDeflect_ = this.dy_ / _local8 * _local9;
      this.yDeflect_ = -this.dx_ / _local8 * _local9;
      this.pathX_ = x_ = this.start_.x;
      this.pathY_ = y_ = this.start_.y;
      this.period_ = 0.25 + Math.random() * 0.5;
   }

   override public function update(param1:int, param2:int) : Boolean {
      this.timeLeft_ = this.timeLeft_ - param2;
      if(this.timeLeft_ <= 0) {
         return false;
      }
      this.pathX_ = this.pathX_ + this.dx_ * param2;
      this.pathY_ = this.pathY_ + this.dy_ * param2;
      var _local3:Number = Math.sin(this.timeLeft_ / 1000 / this.period_);
      moveToInModal(this.pathX_ + this.xDeflect_ * _local3,this.pathY_ + this.yDeflect_ * _local3);
      return true;
   }
}
