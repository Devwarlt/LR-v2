package com.company.util {
import flash.geom.Point;

public class LineSegmentUtil {

      public function LineSegmentUtil() {
         super();
      }

      public static function intersection(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : Point {
         var _local9:Number = (param8 - param6) * (param3 - param1) - (param7 - param5) * (param4 - param2);
         if(_local9 == 0) {
            return null;
         }
         var _local10:Number = ((param7 - param5) * (param2 - param6) - (param8 - param6) * (param1 - param5)) / _local9;
         var _local11:Number = ((param3 - param1) * (param2 - param6) - (param4 - param2) * (param1 - param5)) / _local9;
         if(_local10 > 1 || _local10 < 0 || _local11 > 1 || _local11 < 0) {
            return null;
         }
         var _local12:Point = new Point(param1 + _local10 * (param3 - param1),param2 + _local10 * (param4 - param2));
         return _local12;
      }

      public static function pointDistance(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : Number {
         var _local10:Number = NaN;
         var _local11:Number = NaN;
         var _local12:Number = NaN;
         var _local7:Number = param5 - param3;
         var _local8:Number = param6 - param4;
         var _local9:Number = _local7 * _local7 + _local8 * _local8;
         if(_local9 < 0.001) {
            _local10 = param3;
            _local11 = param4;
         } else {
            _local12 = ((param1 - param3) * _local7 + (param2 - param4) * _local8) / _local9;
            if(_local12 < 0) {
               _local10 = param3;
               _local11 = param4;
            } else if(_local12 > 1) {
               _local10 = param5;
               _local11 = param6;
            } else {
               _local10 = param3 + _local12 * _local7;
               _local11 = param4 + _local12 * _local8;
            }
         }
         _local7 = param1 - _local10;
         _local8 = param2 - _local11;
         return Math.sqrt(_local7 * _local7 + _local8 * _local8);
      }
   }
}
