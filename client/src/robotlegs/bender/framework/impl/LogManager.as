package robotlegs.bender.framework.impl {
import robotlegs.bender.framework.api.ILogTarget;
import robotlegs.bender.framework.api.ILogger;

public class LogManager implements ILogTarget {

      private var _logLevel:uint = 16;

      private const _targets:Vector.<ILogTarget> = new Vector.<ILogTarget>();

      public function LogManager() {
         super();
      }

      public function get logLevel() : uint {
         return this._logLevel;
      }

      public function set logLevel(param1:uint) : void {
         this._logLevel = param1;
      }

      public function getLogger(param1:Object) : ILogger {
         return new Logger(param1,this);
      }

      public function addLogTarget(param1:ILogTarget) : void {
         this._targets.push(param1);
      }

      public function log(param1:Object, param2:uint, param3:int, param4:String, param5:Array = null) : void {
         var _local6:ILogTarget = null;
         if(param2 > this._logLevel) {
            return;
         }
         for each(_local6 in this._targets) {
            _local6.log(param1,param2,param3,param4,param5);
         }
      }
   }
}
