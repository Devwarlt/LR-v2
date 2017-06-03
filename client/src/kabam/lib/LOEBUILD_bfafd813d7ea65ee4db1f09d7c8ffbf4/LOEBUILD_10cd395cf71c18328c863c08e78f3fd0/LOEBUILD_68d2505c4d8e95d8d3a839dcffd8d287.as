package kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_10cd395cf71c18328c863c08e78f3fd0 {
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_a8420f8bebd6d9578b405b6bbaa813d9.LOEBUILD_1ae25a3912f1d8ee2661ddca73054356;

import robotlegs.bender.extensions.logging.impl.LogMessageParser;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.ILogTarget;
import robotlegs.bender.framework.api.LogLevel;

public class LOEBUILD_68d2505c4d8e95d8d3a839dcffd8d287 implements ILogTarget {

      private var consoleLog:LOEBUILD_1ae25a3912f1d8ee2661ddca73054356;

      private var messageParser:LogMessageParser;

      public function LOEBUILD_68d2505c4d8e95d8d3a839dcffd8d287(param1:IContext) {
         super();
         this.consoleLog = param1.injector.getInstance(LOEBUILD_1ae25a3912f1d8ee2661ddca73054356);
         this.messageParser = new LogMessageParser();
      }

      public function log(param1:Object, param2:uint, param3:int, param4:String, param5:Array = null) : void {
         var _local6:String = LogLevel.NAME[param2] + " " + param1 + " " + this.messageParser.parseMessage(param4,param5);
         this.consoleLog.dispatch(_local6);
      }
   }
}
