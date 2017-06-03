package com.company.util {
import flash.utils.ByteArray;

public class MoreStringUtil {

      public function MoreStringUtil() {
         super();
      }

      public static function hexStringToByteArray(param1:String) : ByteArray {
         var _local2:ByteArray = new ByteArray();
         var _local3:int = 0;
         while(_local3 < param1.length) {
            _local2.writeByte(parseInt(param1.substr(_local3,2),16));
            _local3 = _local3 + 2;
         }
         return _local2;
      }

      public static function cmp(param1:String, param2:String) : Number {
         return param1.localeCompare(param2);
      }
   }
}
