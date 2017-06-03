package kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_1bda80f2be4d3658e0baa43fbe7ae8c1 {
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_a8420f8bebd6d9578b405b6bbaa813d9.LOEBUILD_088c13bb3ec60be2dbf0d6fb5453c1be;
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_a8420f8bebd6d9578b405b6bbaa813d9.LOEBUILD_14610e3ed07565b22f1716c951cb036c;
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_a8420f8bebd6d9578b405b6bbaa813d9.LOEBUILD_96e2a3033da7e2da5c5c4a5155803e9e;
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_a8420f8bebd6d9578b405b6bbaa813d9.LOEBUILD_9491a6e26c94608edb8a15286c77736f;

import robotlegs.bender.bundles.mvcs.Mediator;

public class LOEBUILD_3c8d154a8eea40f987987c141b646520 extends Mediator {

      [Inject]
      public var view:LOEBUILD_2953fa62bcfb4f9a6c931a6b7ca746c3;

      [Inject]
      public var toggle:LOEBUILD_9491a6e26c94608edb8a15286c77736f;

      [Inject]
      public var show:LOEBUILD_96e2a3033da7e2da5c5c4a5155803e9e;

      [Inject]
      public var hide:LOEBUILD_088c13bb3ec60be2dbf0d6fb5453c1be;

      [Inject]
      public var remove:LOEBUILD_14610e3ed07565b22f1716c951cb036c;

      public function LOEBUILD_3c8d154a8eea40f987987c141b646520() {
         super();
      }

      override public function initialize() : void {
         this.remove.add(this.onRemoveConsole);
         this.toggle.add(this.onToggleConsole);
         this.show.add(this.onShowConsole);
         this.hide.add(this.onHideConsole);
         this.view.visible = false;
      }

      override public function destroy() : void {
         this.remove.remove(this.onRemoveConsole);
         this.toggle.remove(this.onToggleConsole);
         this.show.remove(this.onShowConsole);
         this.hide.remove(this.onHideConsole);
      }

      private function onRemoveConsole() : void {
         this.view.parent.removeChild(this.view);
      }

      private function onToggleConsole() : void {
         this.view.visible = !this.view.visible;
      }

      private function onShowConsole() : void {
         this.view.visible = true;
      }

      private function onHideConsole() : void {
         this.view.visible = false;
      }
   }
}
