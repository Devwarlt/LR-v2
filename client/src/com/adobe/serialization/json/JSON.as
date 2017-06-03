package com.adobe.serialization.json {
   public class JSON {

      public function JSON() {
         super();
      }

      public static function encode(param1:Object) : String {
         var _local2:LOEBUILD_6aa344864113105c99f1aae12b0b3804 = new LOEBUILD_6aa344864113105c99f1aae12b0b3804(param1);
         return _local2.getString();
      }

      public static function decode(param1:String) : * {
         var _local2:LOEBUILD_fae39bd0456c4d9aa7f5fd7a496e2ad0 = new LOEBUILD_fae39bd0456c4d9aa7f5fd7a496e2ad0(param1);
         return _local2.getValue();
      }
   }
}
