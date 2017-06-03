package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles {
   public class EffectProperties {

      public var id:String;

      public var particle:String;

      public var cooldown:Number;

      public var color:uint;

      public var rate:Number;

      public var speed:Number;

      public var speedVariance:Number;

      public var spread:Number;

      public var life:Number;

      public var lifeVariance:Number;

      public var size:int;

      public var friction:Number;

      public var rise:Number;

      public var riseVariance:Number;

      public var riseAcc:Number;

      public var rangeX:int;

      public var rangeY:int;

      public var zOffset:Number;

      public var bitmapFile:String;

      public var bitmapIndex:uint;

      public function EffectProperties(param1:XML) {
         super();
         this.id = param1.toString();
         this.particle = param1.@particle;
         this.cooldown = param1.@cooldown;
         this.color = param1.@color;
         this.rate = Number(param1.@rate) || Number(5);
         this.speed = Number(param1.@speed) || Number(0);
         this.speedVariance = Number(param1.@speedVariance) || Number(0.5);
         this.spread = Number(param1.@spread) || Number(0);
         this.life = Number(param1.@life) || Number(1);
         this.lifeVariance = Number(param1.@lifeVariance) || Number(0);
         this.size = int(param1.@size) || 3;
         this.rise = Number(param1.@rise) || Number(3);
         this.riseVariance = Number(param1.@riseVariance) || Number(0);
         this.riseAcc = Number(param1.@riseAcc) || Number(0);
         this.rangeX = int(param1.@rangeX) || 0;
         this.rangeY = int(param1.@rangeY) || 0;
         this.zOffset = Number(param1.@zOffset) || Number(0);
         this.bitmapFile = param1.@bitmapFile;
         this.bitmapIndex = param1.@bitmapIndex;
      }
   }
}
