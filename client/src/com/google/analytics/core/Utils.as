package com.google.analytics.core {
   public class Utils {

      public function Utils() {
         super();
      }

      public static function trim(param1:String, param2:Boolean = false) : String {
         var _local5:int = 0;
         var _local6:int = 0;
         var _local7:int = 0;
         if(param1 == "") {
            return "";
         }
         var _local3:Array = [" ","\n","\r","\t"];
         var _local4:String = param1;
         if(param2) {
            _local5 = 0;
            while(_local5 < _local3.length && _local4.indexOf(_local3[_local5]) > -1) {
               _local4 = _local4.split(_local3[_local5]).join("");
               _local5++;
            }
         } else {
            _local6 = 0;
            while(_local6 < _local4.length && _local3.indexOf(_local4.charAt(_local6)) > -1) {
               _local6++;
            }
            _local4 = _local4.substr(_local6);
            _local7 = _local4.length - 1;
            while(_local7 >= 0 && _local3.indexOf(_local4.charAt(_local7)) > -1) {
               _local7--;
            }
            _local4 = _local4.substring(0,_local7 + 1);
         }
         return _local4;
      }

      public static function generateHash(param1:String) : int {
         var _local4:int = 0;
         var _local5:int = 0;
         var _local2:* = 1;
         var _local3:* = 0;
         if(param1 != null && param1 != "") {
            _local2 = 0;
            _local4 = param1.length - 1;
            while(_local4 >= 0) {
               _local5 = param1.charCodeAt(_local4);
               _local2 = int((_local2 << 6 & 268435455) + _local5 + (_local5 << 14));
               _local3 = _local2 & 266338304;
               if(_local3 != 0) {
                  _local2 = _local2 ^ _local3 >> 21;
               }
               _local4--;
            }
         }
         return _local2;
      }

      public static function generate32bitRandom() : int {
         return Math.round(Math.random() * 2147483647);
      }

      public static function validateAccount(param1:String) : Boolean {
         var _local2:RegExp = new RegExp("^UA-[0-9]*-[0-9]*$");
         return _local2.test(param1);
      }
   }
}
