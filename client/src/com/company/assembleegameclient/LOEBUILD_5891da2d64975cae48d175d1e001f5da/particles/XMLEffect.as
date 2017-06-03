package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;

public class XMLEffect extends ParticleEffect {

      private var go_:GameObject;

      private var partProps_:ParticleProperties;

      private var cooldown_:Number;

      private var cooldownLeft_:Number;

      public function XMLEffect(param1:GameObject, param2:EffectProperties) {
         super();
         this.go_ = param1;
         this.partProps_ = ParticleLibrary.propsLibrary_[param2.particle];
         this.cooldown_ = param2.cooldown;
         this.cooldownLeft_ = 0;
      }

      override public function update(param1:int, param2:int) : Boolean {
         if(this.go_.map_ == null) {
            return false;
         }
         var _local3:Number = param2 / 1000;
         this.cooldownLeft_ = this.cooldownLeft_ - _local3;
         if(this.cooldownLeft_ >= 0) {
            return true;
         }
         this.cooldownLeft_ = this.cooldown_;
         map_.addObj(new XMLParticle(this.partProps_),this.go_.x_,this.go_.y_);
         return true;
      }
   }
}
