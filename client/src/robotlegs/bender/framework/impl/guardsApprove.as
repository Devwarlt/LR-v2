package robotlegs.bender.framework.impl {
import org.swiftsuspenders.Injector;

public function guardsApprove(param1:Array, param2:Injector = null) : Boolean {
      var _local3:Object;
      for each(_local3 in param1) {
         if(_local3 is Function) {
            if((_local3 as Function)()) {
               continue;
            }
            return false;
         }
         if(_local3 is Class) {
            _local3 = !!param2?param2.getInstance(_local3 as Class):new (_local3 as Class)();
         }
         if(_local3.approve() == false) {
            return false;
         }
      }
      return true;
   }
}
