package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;
import com.company.assembleegameclient.util.FreeList;

public class BubbleEffect extends ParticleEffect {

      private static const PERIOD_MAX:Number = 400;

      private var poolID:String;

      public var go_:GameObject;

      public var lastUpdate_:int = -1;

      public var rate_:Number;

      private var fxProps:EffectProperties;

      public function BubbleEffect(param1:GameObject, param2:EffectProperties) {
         super();
         this.go_ = param1;
         this.fxProps = param2;
         this.rate_ = (1 - param2.rate) * PERIOD_MAX + 1;
         this.poolID = "BubbleEffect_" + Math.random();
      }

      override public function update(param1:int, param2:int) : Boolean {
         var _local3:int = 0;
         var _local5:int = 0;
         var _local6:Number = NaN;
         var _local7:Number = NaN;
         var _local8:Number = NaN;
         var _local9:Number = NaN;
         var _local11:BubbleParticle = null;
         var _local12:Number = NaN;
         var _local13:Number = NaN;
         if(this.go_.map_ == null) {
            return false;
         }
         if(!this.lastUpdate_) {
            this.lastUpdate_ = param1;
            return true;
         }
         _local3 = int(this.lastUpdate_ / this.rate_);
         var _local4:int = int(param1 / this.rate_);
         _local8 = this.go_.x_;
         _local9 = this.go_.y_;
         if(this.lastUpdate_ < 0) {
            this.lastUpdate_ = Math.max(0,param1 - PERIOD_MAX);
         }
         x_ = _local8;
         y_ = _local9;
         var _local10:int = _local3;
         while(_local10 < _local4) {
            _local5 = _local10 * this.rate_;
            _local11 = BubbleParticle.create(this.poolID,this.fxProps.color,this.fxProps.speed,this.fxProps.life,this.fxProps.lifeVariance,this.fxProps.speedVariance,this.fxProps.spread);
            _local11.restart(_local5,param1);
            _local6 = Math.random() * Math.PI;
            _local7 = Math.random() * 0.4;
            _local12 = _local8 + _local7 * Math.cos(_local6);
            _local13 = _local9 + _local7 * Math.sin(_local6);
            map_.addObj(_local11,_local12,_local13);
            _local10++;
         }
         this.lastUpdate_ = param1;
         return true;
      }

      override public function removeFromMap() : void {
         super.removeFromMap();
         FreeList.dump(this.poolID);
      }
   }
}
