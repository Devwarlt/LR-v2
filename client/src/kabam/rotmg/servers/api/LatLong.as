package kabam.rotmg.servers.api {
   public final class LatLong {

      private static const TO_DEGREES:Number = 180 / Math.PI;

      private static const TO_RADIANS:Number = Math.PI / 180;

      private static const DISTANCE_SCALAR:Number = 60 * 1.1515 * 1.609344 * 1000;

      public var latitude:Number;

      public var longitude:Number;

      public function LatLong(param1:Number, param2:Number) {
         super();
         this.latitude = param1;
         this.longitude = param2;
      }

      public static function distance(param1:LatLong, param2:LatLong) : Number {
         var _local3:Number = TO_RADIANS * (param1.longitude - param2.longitude);
         var _local4:Number = TO_RADIANS * param1.latitude;
         var _local5:Number = TO_RADIANS * param2.latitude;
         var _local6:Number = Math.sin(_local4) * Math.sin(_local5) + Math.cos(_local4) * Math.cos(_local5) * Math.cos(_local3);
         _local6 = TO_DEGREES * Math.acos(_local6) * DISTANCE_SCALAR;
         return _local6;
      }

      public function toString() : String {
         return "(" + this.latitude + ", " + this.longitude + ")";
      }
   }
}
