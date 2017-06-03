package kabam.rotmg.stage3D.Object3D {
import flash.geom.Matrix3D;
import flash.utils.ByteArray;

public class Util {

      public function Util() {
         super();
      }

      public static function perspectiveProjection(param1:Number = 90, param2:Number = 1, param3:Number = 1, param4:Number = 2048) : Matrix3D {
         var _local5:Number = param3 * Math.tan(param1 * Math.PI / 360);
         var _local6:Number = -_local5;
         var _local7:Number = _local6 * param2;
         var _local8:Number = _local5 * param2;
         var _local9:Number = 2 * param3 / (_local8 - _local7);
         var _local10:Number = 2 * param3 / (_local5 - _local6);
         var _local11:Number = (_local8 + _local7) / (_local8 - _local7);
         var _local12:Number = (_local5 + _local6) / (_local5 - _local6);
         var _local13:Number = -(param4 + param3) / (param4 - param3);
         var _local14:Number = -2 * (param4 * param3) / (param4 - param3);
         return new Matrix3D(Vector.<Number>([_local9,0,0,0,0,_local10,0,0,_local11,_local12,_local13,-1,0,0,_local14,0]));
      }

      public static function readString(param1:ByteArray, param2:int) : String {
         var _local5:uint = 0;
         var _local3:String = "";
         var _local4:int = 0;
         while(_local4 < param2) {
            _local5 = param1.readUnsignedByte();
            if(_local5 === 0) {
               param1.position = param1.position + Math.max(0,param2 - (_local4 + 1));
               break;
            }
            _local3 = _local3 + String.fromCharCode(_local5);
            _local4++;
         }
         return _local3;
      }

      public static function upperPowerOfTwo(param1:uint) : uint {
         param1--;
         param1 = param1 | param1 >> 1;
         param1 = param1 | param1 >> 2;
         param1 = param1 | param1 >> 4;
         param1 = param1 | param1 >> 8;
         param1 = param1 | param1 >> 16;
         param1++;
         return param1;
      }
   }
}
