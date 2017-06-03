package robotlegs.bender.framework.impl {
import org.swiftsuspenders.Injector;

public function applyHooks(param1:Array, param2:Injector = null) : void {
      var _local3:Object = null;
      for each(_local3 in param1) {
         if(_local3 is Function) {
            (_local3 as Function)();
         } else {
            if(_local3 is Class) {
               _local3 = !!param2?param2.getInstance(_local3 as Class):new (_local3 as Class)();
            }
            _local3.hook();
         }
      }
   }
}
