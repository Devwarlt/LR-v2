package com.company.util {
import flash.geom.ColorTransform;

public class MoreColorUtil {

      public static const greyscaleFilterMatrix:Array = [0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0];

      public static const redFilterMatrix:Array = [0.3,0.59,0.11,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0];

      public static const identity:ColorTransform = new ColorTransform();

      public static const invisible:ColorTransform = new ColorTransform(1,1,1,0,0,0,0,0);

      public static const transparentCT:ColorTransform = new ColorTransform(1,1,1,0.3,0,0,0,0);

      public static const slightlyTransparentCT:ColorTransform = new ColorTransform(1,1,1,0.7,0,0,0,0);

      public static const greenCT:ColorTransform = new ColorTransform(0.6,1,0.6,1,0,0,0,0);

      public static const lightGreenCT:ColorTransform = new ColorTransform(0.8,1,0.8,1,0,0,0,0);

      public static const veryGreenCT:ColorTransform = new ColorTransform(0.2,1,0.2,1,0,100,0,0);

      public static const transparentGreenCT:ColorTransform = new ColorTransform(0.5,1,0.5,0.3,0,0,0,0);

      public static const transparentVeryGreenCT:ColorTransform = new ColorTransform(0.3,1,0.3,0.5,0,0,0,0);

      public static const redCT:ColorTransform = new ColorTransform(1,0.5,0.5,1,0,0,0,0);

      public static const lightRedCT:ColorTransform = new ColorTransform(1,0.7,0.7,1,0,0,0,0);

      public static const veryRedCT:ColorTransform = new ColorTransform(1,0.2,0.2,1,100,0,0,0);

      public static const transparentRedCT:ColorTransform = new ColorTransform(1,0.5,0.5,0.3,0,0,0,0);

      public static const transparentVeryRedCT:ColorTransform = new ColorTransform(1,0.3,0.3,0.5,0,0,0,0);

      public static const blueCT:ColorTransform = new ColorTransform(0.5,0.5,1,1,0,0,0,0);

      public static const lightBlueCT:ColorTransform = new ColorTransform(0.7,0.7,1,1,0,0,100,0);

      public static const veryBlueCT:ColorTransform = new ColorTransform(0.3,0.3,1,1,0,0,100,0);

      public static const transparentBlueCT:ColorTransform = new ColorTransform(0.5,0.5,1,0.3,0,0,0,0);

      public static const transparentVeryBlueCT:ColorTransform = new ColorTransform(0.3,0.3,1,0.5,0,0,0,0);

      public static const purpleCT:ColorTransform = new ColorTransform(1,0.5,1,1,0,0,0,0);

      public static const veryPurpleCT:ColorTransform = new ColorTransform(1,0.2,1,1,100,0,100,0);

      public static const darkCT:ColorTransform = new ColorTransform(0.6,0.6,0.6,1,0,0,0,0);

      public static const veryDarkCT:ColorTransform = new ColorTransform(0.4,0.4,0.4,1,0,0,0,0);

      public static const makeWhiteCT:ColorTransform = new ColorTransform(1,1,1,1,255,255,255,0);

      public function MoreColorUtil(param1:StaticEnforcer) {
         super();
      }

      public static function hsvToRgb(param1:Number, param2:Number, param3:Number) : int {
         var _local9:Number = NaN;
         var _local10:Number = NaN;
         var _local11:Number = NaN;
         var _local4:int = int(param1 / 60) % 6;
         var _local5:Number = param1 / 60 - Math.floor(param1 / 60);
         var _local6:Number = param3 * (1 - param2);
         var _local7:Number = param3 * (1 - _local5 * param2);
         var _local8:Number = param3 * (1 - (1 - _local5) * param2);
         switch(_local4) {
            case 0:
               _local9 = param3;
               _local10 = _local8;
               _local11 = _local6;
               break;
            case 1:
               _local9 = _local7;
               _local10 = param3;
               _local11 = _local6;
               break;
            case 2:
               _local9 = _local6;
               _local10 = param3;
               _local11 = _local8;
               break;
            case 3:
               _local9 = _local6;
               _local10 = _local7;
               _local11 = param3;
               break;
            case 4:
               _local9 = _local8;
               _local10 = _local6;
               _local11 = param3;
               break;
            case 5:
               _local9 = param3;
               _local10 = _local6;
               _local11 = _local7;
         }
         return int(Math.min(255,Math.floor(_local9 * 255))) << 16 | int(Math.min(255,Math.floor(_local10 * 255))) << 8 | int(Math.min(255,Math.floor(_local11 * 255)));
      }

      public static function randomColor() : uint {
         return uint(16777215 * Math.random());
      }

      public static function randomColor32() : uint {
         return uint(16777215 * Math.random()) | 4278190080;
      }

      public static function transformColor(param1:ColorTransform, param2:uint) : uint {
         var _local3:int = ((param2 & 16711680) >> 16) * param1.redMultiplier + param1.redOffset;
         _local3 = _local3 < 0?0:_local3 > 255?255:int(_local3);
         var _local4:int = ((param2 & 65280) >> 8) * param1.greenMultiplier + param1.greenOffset;
         _local4 = _local4 < 0?0:_local4 > 255?255:int(_local4);
         var _local5:int = (param2 & 255) * param1.blueMultiplier + param1.blueOffset;
         _local5 = _local5 < 0?0:_local5 > 255?255:int(_local5);
         return _local3 << 16 | _local4 << 8 | _local5;
      }

      public static function copyColorTransform(param1:ColorTransform) : ColorTransform {
         return new ColorTransform(param1.redMultiplier,param1.greenMultiplier,param1.blueMultiplier,param1.alphaMultiplier,param1.redOffset,param1.greenOffset,param1.blueOffset,param1.alphaOffset);
      }

      public static function lerpColorTransform(param1:ColorTransform, param2:ColorTransform, param3:Number) : ColorTransform {
         if(param1 == null) {
            param1 = identity;
         }
         if(param2 == null) {
            param2 = identity;
         }
         var _local4:Number = 1 - param3;
         var _local5:ColorTransform = new ColorTransform(param1.redMultiplier * _local4 + param2.redMultiplier * param3,param1.greenMultiplier * _local4 + param2.greenMultiplier * param3,param1.blueMultiplier * _local4 + param2.blueMultiplier * param3,param1.alphaMultiplier * _local4 + param2.alphaMultiplier * param3,param1.redOffset * _local4 + param2.redOffset * param3,param1.greenOffset * _local4 + param2.greenOffset * param3,param1.blueOffset * _local4 + param2.blueOffset * param3,param1.alphaOffset * _local4 + param2.alphaOffset * param3);
         return _local5;
      }

      public static function lerpColor(param1:uint, param2:uint, param3:Number) : uint {
         var _local4:Number = 1 - param3;
         var _local5:uint = param1 >> 24 & 255;
         var _local6:uint = param1 >> 16 & 255;
         var _local7:uint = param1 >> 8 & 255;
         var _local8:uint = param1 & 255;
         var _local9:uint = param2 >> 24 & 255;
         var _local10:uint = param2 >> 16 & 255;
         var _local11:uint = param2 >> 8 & 255;
         var _local12:uint = param2 & 255;
         var _local13:uint = _local5 * _local4 + _local9 * param3;
         var _local14:uint = _local6 * _local4 + _local10 * param3;
         var _local15:uint = _local7 * _local4 + _local11 * param3;
         var _local16:uint = _local8 * _local4 + _local12 * param3;
         var _local17:uint = _local13 << 24 | _local14 << 16 | _local15 << 8 | _local16;
         return _local17;
      }

      public static function transformAlpha(param1:ColorTransform, param2:Number) : Number {
         var _local3:uint = param2 * 255;
         var _local4:uint = _local3 * param1.alphaMultiplier + param1.alphaOffset;
         _local4 = _local4 < 0?uint(0):_local4 > 255?uint(255):uint(_local4);
         return _local4 / 255;
      }

      public static function multiplyColor(param1:uint, param2:Number) : uint {
         var _local3:int = ((param1 & 16711680) >> 16) * param2;
         _local3 = _local3 < 0?0:_local3 > 255?255:int(_local3);
         var _local4:int = ((param1 & 65280) >> 8) * param2;
         _local4 = _local4 < 0?0:_local4 > 255?255:int(_local4);
         var _local5:int = (param1 & 255) * param2;
         _local5 = _local5 < 0?0:_local5 > 255?255:int(_local5);
         return _local3 << 16 | _local4 << 8 | _local5;
      }

      public static function adjustBrightness(param1:uint, param2:Number) : uint {
         var _local3:uint = param1 & 4278190080;
         var _local4:int = ((param1 & 16711680) >> 16) + param2 * 255;
         _local4 = _local4 < 0?0:_local4 > 255?255:int(_local4);
         var _local5:int = ((param1 & 65280) >> 8) + param2 * 255;
         _local5 = _local5 < 0?0:_local5 > 255?255:int(_local5);
         var _local6:int = (param1 & 255) + param2 * 255;
         _local6 = _local6 < 0?0:_local6 > 255?255:int(_local6);
         return _local3 | _local4 << 16 | _local5 << 8 | _local6;
      }

      public static function colorToShaderParameter(param1:uint) : Array {
         var _local2:Number = (param1 >> 24 & 255) / 256;
         return [_local2 * ((param1 >> 16 & 255) / 256),_local2 * ((param1 >> 8 & 255) / 256),_local2 * ((param1 & 255) / 256),_local2];
      }

      public static function rgbToGreyscale(param1:uint) : uint {
         var _local2:uint = ((param1 & 16711680) >> 16) * 0.3 + ((param1 & 65280) >> 8) * 0.59 + (param1 & 255) * 0.11;
         return (param1 && 4278190080) | _local2 << 16 | _local2 << 8 | _local2;
      }

      public static function singleColorFilterMatrix(param1:uint) : Array {
         return [0,0,0,0,(param1 & 16711680) >> 16,0,0,0,0,(param1 & 65280) >> 8,0,0,0,0,param1 & 255,0,0,0,1,0];
      }
   }
}

class StaticEnforcer {

   function StaticEnforcer() {
      super();
   }
}
