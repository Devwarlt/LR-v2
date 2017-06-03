package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;

import flash.geom.Point;

import kabam.rotmg.messaging.impl.data.WorldPosData;

public class CollapseEffect extends ParticleEffect {

      public var center_:Point;

      public var edgePoint_:Point;

      public var color_:int;

      public function CollapseEffect(param1:GameObject, param2:WorldPosData, param3:WorldPosData, param4:int) {
         super();
         this.center_ = new Point(param2.x_,param2.y_);
         this.edgePoint_ = new Point(param3.x_,param3.y_);
         this.color_ = param4;
      }

      override public function runNormalRendering(param1:int, param2:int) : Boolean {
         var _local8:Number = NaN;
         var _local9:Point = null;
         var _local10:Particle = null;
         x_ = this.center_.x;
         y_ = this.center_.y;
         var _local3:Number = Point.distance(this.center_,this.edgePoint_);
         var _local4:int = 300;
         var _local5:int = 200;
         var _local6:int = 24;
         var _local7:int = 0;
         while(_local7 < _local6) {
            _local8 = _local7 * 2 * Math.PI / _local6;
            _local9 = new Point(this.center_.x + _local3 * Math.cos(_local8),this.center_.y + _local3 * Math.sin(_local8));
            _local10 = new SparkerParticle(_local4,this.color_,_local5,_local9,this.center_);
            map_.addObj(_local10,x_,y_);
            _local7++;
         }
         return false;
      }

      override public function runEasyRendering(param1:int, param2:int) : Boolean {
         var _local8:Number = NaN;
         var _local9:Point = null;
         var _local10:Particle = null;
         x_ = this.center_.x;
         y_ = this.center_.y;
         var _local3:Number = Point.distance(this.center_,this.edgePoint_);
         var _local4:int = 50;
         var _local5:int = 150;
         var _local6:int = 8;
         var _local7:int = 0;
         while(_local7 < _local6) {
            _local8 = _local7 * 2 * Math.PI / _local6;
            _local9 = new Point(this.center_.x + _local3 * Math.cos(_local8),this.center_.y + _local3 * Math.sin(_local8));
            _local10 = new SparkerParticle(_local4,this.color_,_local5,_local9,this.center_);
            map_.addObj(_local10,x_,y_);
            _local7++;
         }
         return false;
      }
   }
}
