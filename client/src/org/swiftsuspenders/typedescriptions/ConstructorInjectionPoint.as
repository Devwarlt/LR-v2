package org.swiftsuspenders.typedescriptions {
import flash.utils.Dictionary;

import org.swiftsuspenders.Injector;

public class ConstructorInjectionPoint extends MethodInjectionPoint {

      public function ConstructorInjectionPoint(param1:Array, param2:uint, param3:Dictionary) {
         super("ctor",param1,param2,false,param3);
      }

      public function createInstance(param1:Class, param2:Injector) : Object {
         var _local4:Object = null;
         var _local3:Array = gatherParameterValues(param1,param1,param2);
         switch(_local3.length) {
            case 1:
               _local4 = new param1(_local3[0]);
               break;
            case 2:
               _local4 = new param1(_local3[0],_local3[1]);
               break;
            case 3:
               _local4 = new param1(_local3[0],_local3[1],_local3[2]);
               break;
            case 4:
               _local4 = new param1(_local3[0],_local3[1],_local3[2],_local3[3]);
               break;
            case 5:
               _local4 = new param1(_local3[0],_local3[1],_local3[2],_local3[3],_local3[4]);
               break;
            case 6:
               _local4 = new param1(_local3[0],_local3[1],_local3[2],_local3[3],_local3[4],_local3[5]);
               break;
            case 7:
               _local4 = new param1(_local3[0],_local3[1],_local3[2],_local3[3],_local3[4],_local3[5],_local3[6]);
               break;
            case 8:
               _local4 = new param1(_local3[0],_local3[1],_local3[2],_local3[3],_local3[4],_local3[5],_local3[6],_local3[7]);
               break;
            case 9:
               _local4 = new param1(_local3[0],_local3[1],_local3[2],_local3[3],_local3[4],_local3[5],_local3[6],_local3[7],_local3[8]);
               break;
            case 10:
               _local4 = new param1(_local3[0],_local3[1],_local3[2],_local3[3],_local3[4],_local3[5],_local3[6],_local3[7],_local3[8],_local3[9]);
         }
         _local3.length = 0;
         return _local4;
      }
   }
}
