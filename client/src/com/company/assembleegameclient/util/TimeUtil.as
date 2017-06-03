package com.company.assembleegameclient.util {
   public class TimeUtil {

      public static const DAY_IN_MS:int = 86400000;

      public static const DAY_IN_S:int = 86400;

      public static const HOUR_IN_S:int = 3600;

      public static const MIN_IN_S:int = 60;

      public function TimeUtil() {
         super();
      }

      public static function secondsToDays(param1:Number) : Number {
         return param1 / DAY_IN_S;
      }

      public static function secondsToHours(param1:Number) : Number {
         return param1 / HOUR_IN_S;
      }

      public static function secondsToMins(param1:Number) : Number {
         return param1 / MIN_IN_S;
      }

      public static function parseUTCDate(param1:String) : Date {
         var _local2:Array = param1.match(new RegExp("(\\d\\d\\d\\d)-(\\d\\d)-(\\d\\d) (\\d\\d):(\\d\\d):(\\d\\d)"));
         var _local3:Date = new Date();
         _local3.setUTCFullYear(int(_local2[1]),int(_local2[2]) - 1,int(_local2[3]));
         _local3.setUTCHours(int(_local2[4]),int(_local2[5]),int(_local2[6]),0);
         return _local3;
      }
   }
}
