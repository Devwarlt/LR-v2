package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;
import com.company.assembleegameclient.util.RandomUtil;

public class GasEffect extends ParticleEffect {

      public var go_:GameObject;

      public var props:EffectProperties;

      public var color_:int;

      public var rate:Number;

      public var type:String;

      public function GasEffect(param1:GameObject, param2:EffectProperties) {
         super();
         this.go_ = param1;
         this.color_ = param2.color;
         this.rate = param2.rate;
         this.props = param2;
      }

      override public function update(param1:int, param2:int) : Boolean {
         var _local5:Number = NaN;
         var _local6:Number = NaN;
         var _local7:Number = NaN;
         var _local8:Number = NaN;
         var _local9:Number = NaN;
         var _local10:GasParticle = null;
         if(this.go_.map_ == null) {
            return false;
         }
         x_ = this.go_.x_;
         y_ = this.go_.y_;
         var _local3:int = 20;
         var _local4:int = 0;
         while(_local4 < this.rate) {
            _local5 = (Math.random() + 0.3) * 200;
            _local6 = Math.random();
            _local7 = RandomUtil.plusMinus(this.props.speed - this.props.speed * (_local6 * (1 - this.props.speedVariance)));
            _local8 = RandomUtil.plusMinus(this.props.speed - this.props.speed * (_local6 * (1 - this.props.speedVariance)));
            _local9 = this.props.life * 1000 - this.props.life * 1000 * (_local6 * this.props.lifeVariance);
            _local10 = new GasParticle(_local5,this.color_,_local9,this.props.spread,0.75,_local7,_local8);
            map_.addObj(_local10,x_,y_);
            _local4++;
         }
         return true;
      }
   }
}
