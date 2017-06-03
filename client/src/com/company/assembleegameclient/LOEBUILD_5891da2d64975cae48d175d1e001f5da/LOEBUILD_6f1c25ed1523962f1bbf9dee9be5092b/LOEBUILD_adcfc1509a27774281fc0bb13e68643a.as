package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_6f1c25ed1523962f1bbf9dee9be5092b {
   public class LOEBUILD_adcfc1509a27774281fc0bb13e68643a {

      public var prob_:Number = 1.0;

      public var period_:int;

      public var periodJitter_:int;

      public var sync_:Boolean = false;

      public var frames:Vector.<LOEBUILD_d6e408b692f1e72c58127dbaed95ebe4>;

      public function LOEBUILD_adcfc1509a27774281fc0bb13e68643a(param1:XML) {
         var _local2:XML = null;
         this.frames = new Vector.<LOEBUILD_d6e408b692f1e72c58127dbaed95ebe4>();
         super();
         if("@prob" in param1) {
            this.prob_ = Number(param1.@prob);
         }
         this.period_ = int(Number(param1.@period) * 1000);
         this.periodJitter_ = int(Number(param1.@periodJitter) * 1000);
         this.sync_ = String(param1.@sync) == "true";
         for each(_local2 in param1.Frame) {
            this.frames.push(new LOEBUILD_d6e408b692f1e72c58127dbaed95ebe4(_local2));
         }
      }

      private function getPeriod() : int {
         if(this.periodJitter_ == 0) {
            return this.period_;
         }
         return this.period_ - this.periodJitter_ + 2 * Math.random() * this.periodJitter_;
      }

      public function getLastRun(param1:int) : int {
         if(this.sync_) {
            return int(param1 / this.period_) * this.period_;
         }
         return param1 + this.getPeriod() + 200 * Math.random();
      }

      public function getNextRun(param1:int) : int {
         if(this.sync_) {
            return int(param1 / this.period_) * this.period_ + this.period_;
         }
         return param1 + this.getPeriod();
      }
   }
}
