package kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_1bda80f2be4d3658e0baa43fbe7ae8c1 {
import flash.system.System;

import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_20f35e630daf44dbfa4c3f68f5399d8c.LOEBUILD_f20658650d987d31063b593c05980397;
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_a8420f8bebd6d9578b405b6bbaa813d9.LOEBUILD_dab203a4f7329bd82e535c4398bb2f8d;
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_a8420f8bebd6d9578b405b6bbaa813d9.LOEBUILD_1ae25a3912f1d8ee2661ddca73054356;
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_a8420f8bebd6d9578b405b6bbaa813d9.LOEBUILD_a8313d8a0bfd802186f653cedae79d44;
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_a8420f8bebd6d9578b405b6bbaa813d9.LOEBUILD_7d62542c1c71a1fbf448efe308736a48;
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_a8420f8bebd6d9578b405b6bbaa813d9.LOEBUILD_ff5ec2a325f6d3ae2ab72452213469a8;

import robotlegs.bender.bundles.mvcs.Mediator;

public final class LOEBUILD_cf6c732542a15de093394524cbd02d31 extends Mediator {

      [Inject]
      public var log:LOEBUILD_1ae25a3912f1d8ee2661ddca73054356;

      [Inject]
      public var watch:LOEBUILD_7d62542c1c71a1fbf448efe308736a48;

      [Inject]
      public var unwatch:LOEBUILD_a8313d8a0bfd802186f653cedae79d44;

      [Inject]
      public var clear:LOEBUILD_dab203a4f7329bd82e535c4398bb2f8d;

      [Inject]
      public var copy:LOEBUILD_ff5ec2a325f6d3ae2ab72452213469a8;

      [Inject]
      public var view:LOEBUILD_fa9ade1087f150c60fd066c273595b44;

      public function LOEBUILD_cf6c732542a15de093394524cbd02d31() {
         super();
      }

      override public function initialize() : void {
         this.log.add(this.onLog);
         this.watch.add(this.onWatch);
         this.unwatch.add(this.onUnwatch);
         this.clear.add(this.onClear);
         this.copy.add(this.onCopy);
      }

      override public function destroy() : void {
         this.log.remove(this.onLog);
         this.watch.remove(this.onWatch);
         this.unwatch.remove(this.onUnwatch);
         this.clear.remove(this.onClear);
         this.copy.remove(this.onCopy);
      }

      private function onLog(param1:String) : void {
         this.view.log(param1);
      }

      private function onWatch(param1:LOEBUILD_f20658650d987d31063b593c05980397) : void {
         this.view.watch(param1);
      }

      private function onUnwatch(param1:String) : void {
         this.view.unwatch(param1);
      }

      private function onClear() : void {
         this.view.clear();
      }

      private function onCopy() : void {
         System.setClipboard(this.view.getText());
      }
   }
}
