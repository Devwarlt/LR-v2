package com.company.util {
import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Dictionary;

public class BitmapUtil {

      public function BitmapUtil(param1:StaticEnforcer) {
         super();
      }

      public static function mirror(param1:BitmapData, param2:int = 0) : BitmapData {
         var _local5:int = 0;
         if(param2 == 0) {
            param2 = param1.width;
         }
         var _local3:BitmapData = new BitmapData(param1.width,param1.height,true,0);
         var _local4:int = 0;
         while(_local4 < param2) {
            _local5 = 0;
            while(_local5 < param1.height) {
               _local3.setPixel32(param2 - _local4 - 1,_local5,param1.getPixel32(_local4,_local5));
               _local5++;
            }
            _local4++;
         }
         return _local3;
      }

      public static function rotateBitmapData(param1:BitmapData, param2:int) : BitmapData {
         var _local3:Matrix = new Matrix();
         _local3.translate(-param1.width / 2,-param1.height / 2);
         _local3.rotate(param2 * Math.PI / 2);
         _local3.translate(param1.height / 2,param1.width / 2);
         var _local4:BitmapData = new BitmapData(param1.height,param1.width,true,0);
         _local4.draw(param1,_local3);
         return _local4;
      }

      public static function cropToBitmapData(param1:BitmapData, param2:int, param3:int, param4:int, param5:int) : BitmapData {
         var _local6:BitmapData = new BitmapData(param4,param5);
         _local6.copyPixels(param1,new Rectangle(param2,param3,param4,param5),new Point(0,0));
         return _local6;
      }

      public static function amountTransparent(param1:BitmapData) : Number {
         var _local4:int = 0;
         var _local5:* = 0;
         var _local2:int = 0;
         var _local3:int = 0;
         while(_local3 < param1.width) {
            _local4 = 0;
            while(_local4 < param1.height) {
               _local5 = param1.getPixel32(_local3,_local4) & 4278190080;
               if(_local5 == 0) {
                  _local2++;
               }
               _local4++;
            }
            _local3++;
         }
         return _local2 / (param1.width * param1.height);
      }

      public static function mostCommonColor(param1:BitmapData) : uint {
         var _local3:uint = 0;
         var _local7:* = null;
         var _local8:int = 0;
         var _local9:int = 0;
         var _local2:Dictionary = new Dictionary();
         var _local4:int = 0;
         while(_local4 < param1.width) {
            _local8 = 0;
            while(_local8 < param1.width) {
               _local3 = param1.getPixel32(_local4,_local8);
               if((_local3 & 4278190080) != 0) {
                  if(!_local2.hasOwnProperty(_local3)) {
                     _local2[_local3] = 1;
                  } else {
                     _local2[_local3]++;
                  }
               }
               _local8++;
            }
            _local4++;
         }
         var _local5:uint = 0;
         var _local6:uint = 0;
         for(_local7 in _local2) {
            _local3 = uint(_local7);
            _local9 = _local2[_local7];
            if(_local9 > _local6 || _local9 == _local6 && _local3 > _local5) {
               _local5 = _local3;
               _local6 = _local9;
            }
         }
         return _local5;
      }

      public static function lineOfSight(param1:BitmapData, param2:IntPoint, param3:IntPoint) : Boolean {
         var _local11:int = 0;
         var _local19:int = 0;
         var _local20:int = 0;
         var _local21:int = 0;
         var _local4:int = param1.width;
         var _local5:int = param1.height;
         var _local6:int = param2.x();
         var _local7:int = param2.y();
         var _local8:int = param3.x();
         var _local9:int = param3.y();
         var _local10:* = (_local7 > _local9?_local7 - _local9:_local9 - _local7) > (_local6 > _local8?_local6 - _local8:_local8 - _local6);
         if(_local10) {
            _local11 = _local6;
            _local6 = _local7;
            _local7 = _local11;
            _local11 = _local8;
            _local8 = _local9;
            _local9 = _local11;
            _local11 = _local4;
            _local4 = _local5;
            _local5 = _local11;
         }
         if(_local6 > _local8) {
            _local11 = _local6;
            _local6 = _local8;
            _local8 = _local11;
            _local11 = _local7;
            _local7 = _local9;
            _local9 = _local11;
         }
         var _local12:int = _local8 - _local6;
         var _local13:int = _local7 > _local9?int(_local7 - _local9):int(_local9 - _local7);
         var _local14:int = -(_local12 + 1) / 2;
         var _local15:int = _local7 > _local9?-1:1;
         var _local16:int = _local8 > _local4 - 1?int(_local4 - 1):int(_local8);
         var _local17:int = _local7;
         var _local18:int = _local6;
         if(_local18 < 0) {
            _local14 = _local14 + _local13 * -_local18;
            if(_local14 >= 0) {
               _local19 = _local14 / _local12 + 1;
               _local17 = _local17 + _local15 * _local19;
               _local14 = _local14 - _local19 * _local12;
            }
            _local18 = 0;
         }
         if(_local15 > 0 && _local17 < 0 || _local15 < 0 && _local17 >= _local5) {
            _local20 = _local15 > 0?int(-_local17 - 1):int(_local17 - _local5);
            _local14 = _local14 - _local12 * _local20;
            _local21 = -_local14 / _local13;
            _local18 = _local18 + _local21;
            _local14 = _local14 + _local21 * _local13;
            _local17 = _local17 + _local20 * _local15;
         }
         while(_local18 <= _local16) {
            if(_local15 > 0 && _local17 >= _local5 || _local15 < 0 && _local17 < 0) {
               break;
            }
            if(_local10) {
               if(_local17 >= 0 && _local17 < _local5 && param1.getPixel(_local17,_local18) == 0) {
                  return false;
               }
            } else if(_local17 >= 0 && _local17 < _local5 && param1.getPixel(_local18,_local17) == 0) {
               return false;
            }
            _local14 = _local14 + _local13;
            if(_local14 >= 0) {
               _local17 = _local17 + _local15;
               _local14 = _local14 - _local12;
            }
            _local18++;
         }
         return true;
      }
   }
}

class StaticEnforcer {

   function StaticEnforcer() {
      super();
   }
}
