package com.company.util {
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

public class RectangleUtil {

      public function RectangleUtil() {
         super();
      }

      public static function pointDist(param1:Rectangle, param2:Number, param3:Number) : Number {
         var _local4:Number = param2;
         var _local5:Number = param3;
         if(_local4 < param1.x) {
            _local4 = param1.x;
         } else if(_local4 > param1.right) {
            _local4 = param1.right;
         }
         if(_local5 < param1.y) {
            _local5 = param1.y;
         } else if(_local5 > param1.bottom) {
            _local5 = param1.bottom;
         }
         if(_local4 == param2 && _local5 == param3) {
            return 0;
         }
         return PointUtil.distanceXY(_local4,_local5,param2,param3);
      }

      public static function closestPoint(param1:Rectangle, param2:Number, param3:Number) : Point {
         var _local4:Number = param2;
         var _local5:Number = param3;
         if(_local4 < param1.x) {
            _local4 = param1.x;
         } else if(_local4 > param1.right) {
            _local4 = param1.right;
         }
         if(_local5 < param1.y) {
            _local5 = param1.y;
         } else if(_local5 > param1.bottom) {
            _local5 = param1.bottom;
         }
         return new Point(_local4,_local5);
      }

      public static function lineSegmentIntersectsXY(param1:Rectangle, param2:Number, param3:Number, param4:Number, param5:Number) : Boolean {
         var _local8:Number = NaN;
         var _local9:Number = NaN;
         var _local10:Number = NaN;
         var _local11:Number = NaN;
         if(param1.left > param2 && param1.left > param4 || param1.right < param2 && param1.right < param4 || param1.top > param3 && param1.top > param5 || param1.bottom < param3 && param1.bottom < param5) {
            return false;
         }
         if(param1.left < param2 && param2 < param1.right && param1.top < param3 && param3 < param1.bottom || param1.left < param4 && param4 < param1.right && param1.top < param5 && param5 < param1.bottom) {
            return true;
         }
         var _local6:Number = (param5 - param3) / (param4 - param2);
         var _local7:Number = param3 - _local6 * param2;
         if(_local6 > 0) {
            _local8 = _local6 * param1.left + _local7;
            _local9 = _local6 * param1.right + _local7;
         } else {
            _local8 = _local6 * param1.right + _local7;
            _local9 = _local6 * param1.left + _local7;
         }
         if(param3 < param5) {
            _local11 = param3;
            _local10 = param5;
         } else {
            _local11 = param5;
            _local10 = param3;
         }
         var _local12:Number = _local8 > _local11?Number(_local8):Number(_local11);
         var _local13:Number = _local9 < _local10?Number(_local9):Number(_local10);
         return _local12 < _local13 && !(_local13 < param1.top || _local12 > param1.bottom);
      }

      public static function lineSegmentIntersectXY(param1:Rectangle, param2:Number, param3:Number, param4:Number, param5:Number, param6:Point) : Boolean {
         var _local7:Number = NaN;
         var _local8:Number = NaN;
         var _local9:Number = NaN;
         var _local10:Number = NaN;
         if(param4 <= param1.x) {
            _local7 = (param5 - param3) / (param4 - param2);
            _local8 = param3 - param2 * _local7;
            _local9 = _local7 * param1.x + _local8;
            if(_local9 >= param1.y && _local9 <= param1.y + param1.height) {
               param6.x = param1.x;
               param6.y = _local9;
               return true;
            }
         } else if(param4 >= param1.x + param1.width) {
            _local7 = (param5 - param3) / (param4 - param2);
            _local8 = param3 - param2 * _local7;
            _local9 = _local7 * (param1.x + param1.width) + _local8;
            if(_local9 >= param1.y && _local9 <= param1.y + param1.height) {
               param6.x = param1.x + param1.width;
               param6.y = _local9;
               return true;
            }
         }
         if(param5 <= param1.y) {
            _local7 = (param4 - param2) / (param5 - param3);
            _local8 = param2 - param3 * _local7;
            _local10 = _local7 * param1.y + _local8;
            if(_local10 >= param1.x && _local10 <= param1.x + param1.width) {
               param6.x = _local10;
               param6.y = param1.y;
               return true;
            }
         } else if(param5 >= param1.y + param1.height) {
            _local7 = (param4 - param2) / (param5 - param3);
            _local8 = param2 - param3 * _local7;
            _local10 = _local7 * (param1.y + param1.height) + _local8;
            if(_local10 >= param1.x && _local10 <= param1.x + param1.width) {
               param6.x = _local10;
               param6.y = param1.y + param1.height;
               return true;
            }
         }
         return false;
      }

      public static function lineSegmentIntersect(param1:Rectangle, param2:IntPoint, param3:IntPoint) : Point {
         var _local4:Number = NaN;
         var _local5:Number = NaN;
         var _local6:Number = NaN;
         var _local7:Number = NaN;
         if(param3.x() <= param1.x) {
            _local4 = (param3.y() - param2.y()) / (param3.x() - param2.x());
            _local5 = param2.y() - param2.x() * _local4;
            _local6 = _local4 * param1.x + _local5;
            if(_local6 >= param1.y && _local6 <= param1.y + param1.height) {
               return new Point(param1.x,_local6);
            }
         } else if(param3.x() >= param1.x + param1.width) {
            _local4 = (param3.y() - param2.y()) / (param3.x() - param2.x());
            _local5 = param2.y() - param2.x() * _local4;
            _local6 = _local4 * (param1.x + param1.width) + _local5;
            if(_local6 >= param1.y && _local6 <= param1.y + param1.height) {
               return new Point(param1.x + param1.width,_local6);
            }
         }
         if(param3.y() <= param1.y) {
            _local4 = (param3.x() - param2.x()) / (param3.y() - param2.y());
            _local5 = param2.x() - param2.y() * _local4;
            _local7 = _local4 * param1.y + _local5;
            if(_local7 >= param1.x && _local7 <= param1.x + param1.width) {
               return new Point(_local7,param1.y);
            }
         } else if(param3.y() >= param1.y + param1.height) {
            _local4 = (param3.x() - param2.x()) / (param3.y() - param2.y());
            _local5 = param2.x() - param2.y() * _local4;
            _local7 = _local4 * (param1.y + param1.height) + _local5;
            if(_local7 >= param1.x && _local7 <= param1.x + param1.width) {
               return new Point(_local7,param1.y + param1.height);
            }
         }
         return null;
      }

      public static function getRotatedRectExtents2D(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Extents2D {
         var _local9:Point = null;
         var _local11:int = 0;
         var _local6:Matrix = new Matrix();
         _local6.translate(-param4 / 2,-param5 / 2);
         _local6.rotate(param3);
         _local6.translate(param1,param2);
         var _local7:Extents2D = new Extents2D();
         var _local8:Point = new Point();
         var _local10:int = 0;
         while(_local10 <= 1) {
            _local11 = 0;
            while(_local11 <= 1) {
               _local8.x = _local10 * param4;
               _local8.y = _local11 * param5;
               _local9 = _local6.transformPoint(_local8);
               _local7.add(_local9.x,_local9.y);
               _local11++;
            }
            _local10++;
         }
         return _local7;
      }
   }
}
