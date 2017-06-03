package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;

import flash.geom.Point;

import kabam.rotmg.messaging.impl.data.WorldPosData;

public class FlowEffect extends ParticleEffect {

      public var start_:Point;

      public var go_:GameObject;

      public var color_:int;

      public function FlowEffect(param1:WorldPosData, param2:GameObject, param3:int) {
         super();
         this.start_ = new Point(param1.x_,param1.y_);
         this.go_ = param2;
         this.color_ = param3;
      }

      override public function runNormalRendering(param1:int, param2:int) : Boolean {
         var _local5:int = 0;
         var _local6:Particle = null;
         if(FlowParticle.total_ > 200) {
            return false;
         }
         x_ = this.start_.x;
         y_ = this.start_.y;
         var _local3:int = 5;
         var _local4:int = 0;
         while(_local4 < _local3) {
            _local5 = (3 + int(Math.random() * 5)) * 20;
            _local6 = new FlowParticle(0.5,_local5,this.color_,this.start_,this.go_);
            map_.addObj(_local6,x_,y_);
            _local4++;
         }
         return false;
      }

      override public function runEasyRendering(param1:int, param2:int) : Boolean {
         var _local5:int = 0;
         var _local6:Particle = null;
         if(FlowParticle.total_ > 200) {
            return false;
         }
         x_ = this.start_.x;
         y_ = this.start_.y;
         var _local3:int = 3;
         var _local4:int = 0;
         while(_local4 < _local3) {
            _local5 = (3 + int(Math.random() * 5)) * 10;
            _local6 = new FlowParticle(0.5,_local5,this.color_,this.start_,this.go_);
            map_.addObj(_local6,x_,y_);
            _local4++;
         }
         return false;
      }
   }
}

import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles.Particle;

import flash.geom.Point;

class FlowParticle extends Particle {

   public static var total_:int = 0;

   public var start_:Point;

   public var go_:GameObject;

   public var maxDist_:Number;

   public var flowSpeed_:Number;

   function FlowParticle(param1:Number, param2:int, param3:int, param4:Point, param5:GameObject) {
      super(param3,param1,param2);
      this.start_ = param4;
      this.go_ = param5;
      var _local6:Point = new Point(x_,y_);
      var _local7:Point = new Point(this.go_.x_,this.go_.y_);
      this.maxDist_ = Point.distance(_local6,_local7);
      this.flowSpeed_ = Math.random() * 5;
      total_++;
   }

   override public function update(param1:int, param2:int) : Boolean {
      var _local3:Number = 8;
      var _local4:Point = new Point(x_,y_);
      var _local5:Point = new Point(this.go_.x_,this.go_.y_);
      var _local6:Number = Point.distance(_local4,_local5);
      if(_local6 < 0.5) {
         total_--;
         return false;
      }
      this.flowSpeed_ = this.flowSpeed_ + _local3 * param2 / 1000;
      this.maxDist_ = this.maxDist_ - this.flowSpeed_ * param2 / 1000;
      var _local7:Number = _local6 - this.flowSpeed_ * param2 / 1000;
      if(_local7 > this.maxDist_) {
         _local7 = this.maxDist_;
      }
      var _local8:Number = this.go_.x_ - x_;
      var _local9:Number = this.go_.y_ - y_;
      _local8 = _local8 * (_local7 / _local6);
      _local9 = _local9 * (_local7 / _local6);
      moveTo(this.go_.x_ - _local8,this.go_.y_ - _local9);
      return true;
   }
}

class FlowParticle2 extends Particle {

   public var start_:Point;

   public var go_:GameObject;

   public var accel_:Number;

   public var dx_:Number;

   public var dy_:Number;

   function FlowParticle2(param1:Number, param2:int, param3:int, param4:Number, param5:Point, param6:GameObject) {
      super(param3,param1,param2);
      this.start_ = param5;
      this.go_ = param6;
      this.accel_ = param4;
      this.dx_ = Math.random() - 0.5;
      this.dy_ = Math.random() - 0.5;
   }

   override public function update(param1:int, param2:int) : Boolean {
      var _local3:Point = new Point(x_,y_);
      var _local4:Point = new Point(this.go_.x_,this.go_.y_);
      var _local5:Number = Point.distance(_local3,_local4);
      if(_local5 < 0.5) {
         return false;
      }
      var _local6:Number = Math.atan2(this.go_.y_ - y_,this.go_.x_ - x_);
      this.dx_ = this.dx_ + this.accel_ * Math.cos(_local6) * param2 / 1000;
      this.dy_ = this.dy_ + this.accel_ * Math.sin(_local6) * param2 / 1000;
      var _local7:Number = x_ + this.dx_ * param2 / 1000;
      var _local8:Number = y_ + this.dy_ * param2 / 1000;
      moveTo(_local7,_local8);
      return true;
   }
}
