package com.adobe.serialization.json {
import flash.utils.describeType;

public class LOEBUILD_6aa344864113105c99f1aae12b0b3804 {

      private var jsonString:String;

      public function LOEBUILD_6aa344864113105c99f1aae12b0b3804(param1:*) {
         super();
         this.jsonString = this.convertToString(param1);
      }

      public function getString() : String {
         return this.jsonString;
      }

      private function convertToString(param1:*) : String {
         if(param1 is String) {
            return this.escapeString(param1 as String);
         }
         if(param1 is Number) {
            return !!isFinite(param1 as Number)?param1.toString():"null";
         }
         if(param1 is Boolean) {
            return !!param1?"true":"false";
         }
         if(param1 is Array) {
            return this.arrayToString(param1 as Array);
         }
         if(param1 is Object && param1 != null) {
            return this.objectToString(param1);
         }
         return "null";
      }

      private function escapeString(param1:String) : String {
         var _local3:String = null;
         var _local6:String = null;
         var _local7:String = null;
         var _local2:* = "";
         var _local4:Number = param1.length;
         var _local5:int = 0;
         while(_local5 < _local4) {
            _local3 = param1.charAt(_local5);
            switch(_local3) {
               case "\"":
                  _local2 = _local2 + "\\\"";
                  break;
               case "\\":
                  _local2 = _local2 + "\\\\";
                  break;
               case "\b":
                  _local2 = _local2 + "\\b";
                  break;
               case "\f":
                  _local2 = _local2 + "\\f";
                  break;
               case "\n":
                  _local2 = _local2 + "\\n";
                  break;
               case "\r":
                  _local2 = _local2 + "\\r";
                  break;
               case "\t":
                  _local2 = _local2 + "\\t";
                  break;
               default:
                  if(_local3 < " ") {
                     _local6 = _local3.charCodeAt(0).toString(16);
                     _local7 = _local6.length == 2?"00":"000";
                     _local2 = _local2 + ("\\u" + _local7 + _local6);
                  } else {
                     _local2 = _local2 + _local3;
                  }
            }
            _local5++;
         }
         return "\"" + _local2 + "\"";
      }

      private function arrayToString(param1:Array) : String {
         var _local2:* = "";
         var _local3:int = 0;
         while(_local3 < param1.length) {
            if(_local2.length > 0) {
               _local2 = _local2 + ",";
            }
            _local2 = _local2 + this.convertToString(param1[_local3]);
            _local3++;
         }
         return "[" + _local2 + "]";
      }

      private function objectToString(param1:Object) : String {
         var value:Object = null;
         var key:String = null;
         var v:XML = null;
         var o:Object = param1;
         var s:String = "";
         var classInfo:XML = describeType(o);
         if(classInfo.@name.toString() == "Object") {
            for(key in o) {
               value = o[key];
               if(!(value is Function)) {
                  if(s.length > 0) {
                     s = s + ",";
                  }
                  s = s + (this.escapeString(key) + ":" + this.convertToString(value));
               }
            }
         } else {
            for each(v in classInfo..*.(name() == "variable" || name() == "accessor")) {
               if(s.length > 0) {
                  s = s + ",";
               }
               s = s + (this.escapeString(v.@name.toString()) + ":" + this.convertToString(o[v.@name]));
            }
         }
         return "{" + s + "}";
      }
   }
}
