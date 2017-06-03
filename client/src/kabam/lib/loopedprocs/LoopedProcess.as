package kabam.lib.loopedprocs {
import flash.utils.Dictionary;
import flash.utils.getTimer;

public class LoopedProcess {

      private static var maxId:uint;

      private static var loopProcs:Dictionary = new Dictionary();

      public var id:uint;

      public var paused:Boolean;

      public var interval:uint;

      public var lastRun:int;

      public function LoopedProcess(param1:uint) {
         super();
         this.interval = param1;
      }

      public static function addProcess(param1:LoopedProcess) : uint {
         if(loopProcs[param1.id] == param1) {
            return param1.id;
         }
         var _local2:* = ++maxId;
         loopProcs[_local2] = param1;
         param1.lastRun = getTimer();
         return maxId;
      }

      public static function runProcesses(param1:int) : void {
         var _local2:LoopedProcess;
         var _local3:int = 0;
         for each(_local2 in loopProcs) {
            if(!_local2.paused) {
               _local3 = param1 - _local2.lastRun;
               if(_local3 >= _local2.interval) {
                  _local2.lastRun = param1;
                  _local2.run();
               }
            }
         }
      }

      public static function destroyProcess(param1:LoopedProcess) : void {
         delete loopProcs[param1.id];
         param1.onDestroyed();
      }

      public static function destroyAll() : void {
         var _local1:LoopedProcess;
         for each(_local1 in loopProcs) {
            _local1.destroy();
         }
         loopProcs = new Dictionary();
      }

      public final function add() : void {
         addProcess(this);
      }

      public final function destroy() : void {
         destroyProcess(this);
      }

      protected function run() : void {
      }

      protected function onDestroyed() : void {
      }
   }
}
