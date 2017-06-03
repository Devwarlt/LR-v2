package kabam.lib.json {
import com.hurlant.util.Base64;

public class Base64Decoder {

      public function Base64Decoder() {
         super();
      }

      public function decode(param1:String) : String {
         var _local2:RegExp = new RegExp("-","g");
         var _local3:RegExp = new RegExp("_","g");
         var _local4:int = 4 - param1.length % 4;
         while(_local4--) {
            param1 = param1 + "=";
         }
         param1 = param1.replace(_local2,"+").replace(_local3,"/");
         return Base64.decode(param1);
      }
   }
}
