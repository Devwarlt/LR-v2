package kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_1bda80f2be4d3658e0baa43fbe7ae8c1 {
import flash.display.DisplayObjectContainer;
import flash.events.KeyboardEvent;

import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_a8420f8bebd6d9578b405b6bbaa813d9.LOEBUILD_9491a6e26c94608edb8a15286c77736f;

import robotlegs.bender.bundles.mvcs.Mediator;

public class LOEBUILD_ced433ff203d8e2ff98913366a6b4c51 extends Mediator {

      private const TRIGGER:uint = 27;

      [Inject]
      public var view:DisplayObjectContainer;

      [Inject]
      public var toggle:LOEBUILD_9491a6e26c94608edb8a15286c77736f;

      public function LOEBUILD_ced433ff203d8e2ff98913366a6b4c51() {
         super();
      }

      override public function initialize() : void {
         this.view.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }

      override public function destroy() : void {
         this.view.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }

      private function onKeyDown(param1:KeyboardEvent) : void {
         if(param1.keyCode == this.TRIGGER) {
            this.toggle.dispatch();
         }
      }
   }
}
