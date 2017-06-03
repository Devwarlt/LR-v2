package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_6f1c25ed1523962f1bbf9dee9be5092b {
   public class LOEBUILD_b98058c639863689a15a54bd69990a3b {

      public var animations:Vector.<LOEBUILD_adcfc1509a27774281fc0bb13e68643a>;

      public function LOEBUILD_b98058c639863689a15a54bd69990a3b(param1:XML) {
         var _local2:XML = null;
         this.animations = new Vector.<LOEBUILD_adcfc1509a27774281fc0bb13e68643a>();
         super();
         for each(_local2 in param1.Animation) {
            this.animations.push(new LOEBUILD_adcfc1509a27774281fc0bb13e68643a(_local2));
         }
      }
   }
}
