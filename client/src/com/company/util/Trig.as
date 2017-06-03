package com.company.util {
   public class Trig {

      public static const toDegrees:Number = 180 / Math.PI;

      public static const toRadians:Number = Math.PI / 180;

      public function Trig(param1:StaticEnforcer) {
         super();
      }

      public static function slerp(param1:Number, param2:Number, param3:Number) : Number {
         var _local4:Number = Number.MAX_VALUE;
         if(param1 > param2) {
            if(param1 - param2 > Math.PI) {
               _local4 = param1 * (1 - param3) + (param2 + 2 * Math.PI) * param3;
            } else {
               _local4 = param1 * (1 - param3) + param2 * param3;
            }
         } else if(param2 - param1 > Math.PI) {
            _local4 = (param1 + 2 * Math.PI) * (1 - param3) + param2 * param3;
         } else {
            _local4 = param1 * (1 - param3) + param2 * param3;
         }
         if(_local4 < -Math.PI || _local4 > Math.PI) {
            _local4 = boundToPI(_local4);
         }
         return _local4;
      }

      public static function angleDiff(param1:Number, param2:Number) : Number {
         if(param1 > param2) {
            if(param1 - param2 > Math.PI) {
               return param2 + 2 * Math.PI - param1;
            }
            return param1 - param2;
         }
         if(param2 - param1 > Math.PI) {
            return param1 + 2 * Math.PI - param2;
         }
         return param2 - param1;
      }

      public static function sin(param1:Number) : Number {
         var _local2:Number = NaN;
         if(param1 < -Math.PI || param1 > Math.PI) {
            param1 = boundToPI(param1);
         }
         if(param1 < 0) {
            _local2 = 1.27323954 * param1 + 0.405284735 * param1 * param1;
            if(_local2 < 0) {
               _local2 = 0.225 * (_local2 * -_local2 - _local2) + _local2;
            } else {
               _local2 = 0.225 * (_local2 * _local2 - _local2) + _local2;
            }
         } else {
            _local2 = 1.27323954 * param1 - 0.405284735 * param1 * param1;
            if(_local2 < 0) {
               _local2 = 0.225 * (_local2 * -_local2 - _local2) + _local2;
            } else {
               _local2 = 0.225 * (_local2 * _local2 - _local2) + _local2;
            }
         }
         return _local2;
      }

      public static function cos(param1:Number) : Number {
         return sin(param1 + Math.PI / 2);
      }

      public static function atan2(param1:Number, param2:Number) : Number {
         var _local3:Number = NaN;
         if(param2 == 0) {
            if(param1 < 0) {
               return -Math.PI / 2;
            }
            if(param1 > 0) {
               return Math.PI / 2;
            }
            return undefined;
         }
         if(param1 == 0) {
            if(param2 < 0) {
               return Math.PI;
            }
            return 0;
         }
         if((param2 > 0?param2:-param2) > (param1 > 0?param1:-param1)) {
            _local3 = (param2 < 0?-Math.PI:0) + atan2Helper(param1,param2);
         } else {
            _local3 = (param1 > 0?Math.PI / 2:-Math.PI / 2) - atan2Helper(param2,param1);
         }
         if(_local3 < -Math.PI || _local3 > Math.PI) {
            _local3 = boundToPI(_local3);
         }
         return _local3;
      }

      public static function atan2Helper(param1:Number, param2:Number) : Number {
         var _local3:Number = param1 / param2;
         var _local4:Number = _local3;
         var _local5:Number = _local3;
         var _local6:Number = 1;
         var _local7:int = 1;
         do {
            _local6 = _local6 + 2;
            _local7 = _local7 > 0?-1:1;
            _local5 = _local5 * _local3 * _local3;
            _local4 = _local4 + _local7 * _local5 / _local6;
         }
         while((_local5 > 0.01 || _local5 < -0.01) && _local6 <= 11);

         return _local4;
      }

      public static function boundToPI(param1:Number) : Number {
         var _local2:int = 0;
         if(param1 < -Math.PI) {
            _local2 = (int(param1 / -Math.PI) + 1) / 2;
            param1 = param1 + _local2 * 2 * Math.PI;
         } else if(param1 > Math.PI) {
            _local2 = (int(param1 / Math.PI) + 1) / 2;
            param1 = param1 - _local2 * 2 * Math.PI;
         }
         return param1;
      }

      public static function boundTo180(param1:Number) : Number {
         var _local2:int = 0;
         if(param1 < -180) {
            _local2 = (int(param1 / -180) + 1) / 2;
            param1 = param1 + _local2 * 360;
         } else if(param1 > 180) {
            _local2 = (int(param1 / 180) + 1) / 2;
            param1 = param1 - _local2 * 360;
         }
         return param1;
      }

      public static function unitTest() : Boolean {
         trace("STARTING UNITTEST: Trig");
         var _local1:Boolean = Boolean(testFunc1(Math.sin,sin)) && Boolean(testFunc1(Math.cos,cos)) && Boolean(testFunc2(Math.atan2,atan2));
         if(!_local1) {
            trace("Trig Unit Test FAILED!");
         }
         trace("FINISHED UNITTEST: Trig");
         return _local1;
      }

      public static function testFunc1(param1:Function, param2:Function) : Boolean {
         var _local5:Number = NaN;
         var _local6:Number = NaN;
         var _local3:Random = new Random();
         var _local4:int = 0;
         while(_local4 < 1000) {
            _local5 = _local3.nextInt() % 2000 - 1000 + _local3.nextDouble();
            _local6 = Math.abs(param1(_local5) - param2(_local5));
            if(_local6 > 0.1) {
               return false;
            }
            _local4++;
         }
         return true;
      }

      public static function testFunc2(param1:Function, param2:Function) : Boolean {
         var _local5:Number = NaN;
         var _local6:Number = NaN;
         var _local7:Number = NaN;
         var _local3:Random = new Random();
         var _local4:int = 0;
         while(_local4 < 1000) {
            _local5 = _local3.nextInt() % 2000 - 1000 + _local3.nextDouble();
            _local6 = _local3.nextInt() % 2000 - 1000 + _local3.nextDouble();
            _local7 = Math.abs(param1(_local5,_local6) - param2(_local5,_local6));
            if(_local7 > 0.1) {
               return false;
            }
            _local4++;
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
