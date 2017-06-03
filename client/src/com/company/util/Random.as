package com.company.util {
public class Random {

   public var seed:uint;

   public function Random(param1:uint = 1) {
      super();
      this.seed = param1;
   }

   public static function randomSeed() : uint {
      return Math.round(Math.random() * (uint.MAX_VALUE - 1) + 1);
   }

   public function nextInt() : uint {
      return this.gen();
   }

   public function nextDouble() : Number {
      return this.gen() / 2147483647;
   }

   public function nextNormal(param1:Number = 0.0, param2:Number = 1.0) : Number {
      var _local3:Number = this.gen() / 2147483647;
      var _local4:Number = this.gen() / 2147483647;
      var _local5:Number = Math.sqrt(-2 * Math.log(_local3)) * Math.cos(2 * _local4 * Math.PI);
      return param1 + _local5 * param2;
   }

   public function nextIntRange(param1:uint, param2:uint) : uint {
      return param1 == param2?uint(param1):uint(param1 + this.gen() % (param2 - param1));
   }

   public function nextDoubleRange(param1:Number, param2:Number) : Number {
      return param1 + (param2 - param1) * this.nextDouble();
   }

   private function gen() : uint {
      var _local1:uint = 0;
      var _local2:uint = 0;
      _local2 = 16807 * (this.seed & 65535);
      _local1 = 16807 * (this.seed >> 16);
      _local2 = _local2 + ((_local1 & 32767) << 16);
      _local2 = _local2 + (_local1 >> 15);
      if(_local2 > 2147483647) {
         _local2 = _local2 - 2147483647;
      }
      return this.seed = _local2;
   }
}
}
