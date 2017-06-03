package com.company.assembleegameclient.util {
import flash.display.DisplayObject;

public class DisplayHierarchy {

      public function DisplayHierarchy() {
         super();
      }

      public static function getParentWithType(param1:DisplayObject, param2:Class) : DisplayObject {
         while(Boolean(param1) && !(param1 is param2)) {
            param1 = param1.parent;
         }
         return param1;
      }

      public static function getParentWithTypeArray(param1:DisplayObject, ... rest) : DisplayObject {
         var _local3:Class = null;
         while(param1) {
            for each(_local3 in rest) {
               if(param1 is _local3) {
                  return param1;
               }
            }
            param1 = param1.parent;
         }
         return param1;
      }
   }
}
