package org.swiftsuspenders.reflection {
import flash.utils.Proxy;
import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedClassName;

public class ReflectorBase {

      public function ReflectorBase() {
         super();
      }

      public function getClass(param1:Object) : Class {
         if(param1 is Proxy || param1 is Number || param1 is XML || param1 is XMLList) {
            return Class(getDefinitionByName(getQualifiedClassName(param1)));
         }
         return param1.constructor;
      }

      public function getFQCN(param1:*, param2:Boolean = false) : String {
         var _local3:String = null;
         var _local4:int = 0;
         if(param1 is String) {
            _local3 = param1;
            if(!param2 && _local3.indexOf("::") == -1) {
               _local4 = _local3.lastIndexOf(".");
               if(_local4 == -1) {
                  return _local3;
               }
               return _local3.substring(0,_local4) + "::" + _local3.substring(_local4 + 1);
            }
         } else {
            _local3 = getQualifiedClassName(param1);
         }
         return !!param2?_local3.replace("::","."):_local3;
      }
   }
}
