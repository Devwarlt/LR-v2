package kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_1bda80f2be4d3658e0baa43fbe7ae8c1 {
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_20f35e630daf44dbfa4c3f68f5399d8c.Console;
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_a8420f8bebd6d9578b405b6bbaa813d9.LOEBUILD_1ae25a3912f1d8ee2661ddca73054356;

import robotlegs.bender.bundles.mvcs.Mediator;

public final class LOEBUILD_7dec199b1158dce2c7f7793087295ba6 extends Mediator {

      private static const ERROR_PATTERN:String = "[0xFF3333:error - \"${value}\" not found]";

      private static const ACTION_PATTERN:String = "[0xFFEE00:${value}]";

      [Inject]
      public var view:LOEBUILD_9a1afe308cb8a3976519f048fad72e19;

      [Inject]
      public var console:Console;

      [Inject]
      public var log:LOEBUILD_1ae25a3912f1d8ee2661ddca73054356;

      public function LOEBUILD_7dec199b1158dce2c7f7793087295ba6() {
         super();
      }

      override public function initialize() : void {
         addViewListener(ConsoleEvent.INPUT,this.onInput,ConsoleEvent);
         addViewListener(ConsoleEvent.GET_PREVIOUS,this.onGetPrevious,ConsoleEvent);
         addViewListener(ConsoleEvent.GET_NEXT,this.onGetNext,ConsoleEvent);
      }

      override public function destroy() : void {
         removeViewListener(ConsoleEvent.INPUT,this.onInput,ConsoleEvent);
         removeViewListener(ConsoleEvent.GET_PREVIOUS,this.onGetPrevious,ConsoleEvent);
         removeViewListener(ConsoleEvent.GET_NEXT,this.onGetNext,ConsoleEvent);
      }

      private function onInput(param1:ConsoleEvent) : void {
         var _local2:String = param1.data;
         this.logInput(_local2);
         this.console.execute(_local2);
      }

      private function logInput(param1:String) : void {
         if(this.console.hasAction(param1)) {
            this.logAction(param1);
         } else {
            this.logError(param1);
         }
      }

      private function logAction(param1:String) : void {
         var _local2:Array = param1.split(" ");
         _local2[0] = ACTION_PATTERN.replace("${value}",_local2[0]);
         this.log.dispatch(_local2.join(" "));
      }

      private function logError(param1:String) : void {
         var _local2:String = ERROR_PATTERN.replace("${value}",param1);
         this.log.dispatch(_local2);
      }

      private function onGetPrevious(param1:ConsoleEvent) : void {
         this.view.text = this.console.getPreviousAction();
      }

      private function onGetNext(param1:ConsoleEvent) : void {
         this.view.text = this.console.getNextAction();
      }
   }
}
