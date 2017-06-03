package kabam.lib.util {
   public class VectorAS3Util {

      public function VectorAS3Util() {
         super();
      }

      public static function toArray(param1:Object) : Array {
         var _local3:Object = null;
         var _local2:Array = [];
         for each(_local3 in param1) {
            _local2.push(_local3);
         }
         return _local2;
      }
   }
}
