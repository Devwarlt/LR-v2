package robotlegs.bender.extensions.logging.impl {
   public class LogMessageParser {

      public function LogMessageParser() {
         super();
      }

      public function parseMessage(param1:String, param2:Array) : String {
         var _local3:int = 0;
         var _local4:int = 0;
         if(param2) {
            _local3 = param2.length;
            _local4 = 0;
            while(_local4 < _local3) {
               param1 = param1.split("{" + _local4 + "}").join(param2[_local4]);
               _local4++;
            }
         }
         return param1;
      }
   }
}
