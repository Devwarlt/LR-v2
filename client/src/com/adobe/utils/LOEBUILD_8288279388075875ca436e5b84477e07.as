package com.adobe.utils {
import flash.utils.Dictionary;

public class LOEBUILD_8288279388075875ca436e5b84477e07 {

      public function LOEBUILD_8288279388075875ca436e5b84477e07() {
         super();
      }

      public static function getKeys(param1:Dictionary) : Array {
         var _local3:* = null;
         var _local2:Array = new Array();
         for(_local3 in param1) {
            _local2.push(_local3);
         }
         return _local2;
      }

      public static function getValues(param1:Dictionary) : Array {
         var _local3:Object = null;
         var _local2:Array = new Array();
         for each(_local3 in param1) {
            _local2.push(_local3);
         }
         return _local2;
      }
   }
}
