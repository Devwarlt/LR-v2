package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles {
import flash.geom.Point;

import kabam.rotmg.messaging.impl.data.WorldPosData;

public class StreamEffect extends ParticleEffect {

      public var start_:Point;

      public var end_:Point;

      public var color_:int;

      public function StreamEffect(param1:WorldPosData, param2:WorldPosData, param3:int) {
         super();
         this.start_ = new Point(param1.x_,param1.y_);
         this.end_ = new Point(param2.x_,param2.y_);
         this.color_ = param3;
      }

      override public function update(param1:int, param2:int) : Boolean {
         var _local5:int = 0;
         var _local6:StreamParticle = null;
         x_ = this.start_.x;
         y_ = this.start_.y;
         var _local3:int = 5;
         var _local4:int = 0;
         while(_local4 < _local3) {
            _local5 = (3 + int(Math.random() * 5)) * 20;
            _local6 = new StreamParticle(1.85,_local5,this.color_,1500 + Math.random() * 3000,0.1 + Math.random() * 0.1,this.start_,this.end_);
            map_.addObj(_local6,x_,y_);
            _local4++;
         }
         return false;
      }
   }
}

import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles.Particle;

import flash.geom.Point;
import flash.geom.Vector3D;

class StreamParticle extends Particle {

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

   function StreamParticle(param1:Number, param2:int, param3:int, param4:int, param5:Number, param6:Point, param7:Point) {
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
      moveTo(this.pathX_ + this.xDeflect_ * _local3,this.pathY_ + this.yDeflect_ * _local3);
      return true;
   }
}
