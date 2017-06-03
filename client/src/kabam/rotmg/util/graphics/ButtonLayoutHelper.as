package kabam.rotmg.util.graphics {
import flash.display.DisplayObject;
import flash.errors.IllegalOperationError;
import flash.geom.Rectangle;

public class ButtonLayoutHelper {

      public function ButtonLayoutHelper() {
         super();
      }

      public function layout(param1:int, ... rest) : void {
         var _local3:int = rest.length;
         switch(_local3) {
            case 1:
               this.centerButton(param1,rest[0]);
               break;
            case 2:
               this.twoButtons(param1,rest[0],rest[1]);
               break;
            default:
               throw new IllegalOperationError("Currently unable to layout more than 2 buttons");
         }
      }

      private function centerButton(param1:int, param2:DisplayObject) : void {
         var _local3:Rectangle = param2.getRect(param2);
         param2.x = (param1 - _local3.width) * 0.5 - _local3.left;
      }

      private function twoButtons(param1:int, param2:DisplayObject, param3:DisplayObject) : void {
         var _local5:Rectangle = null;
         var _local4:Rectangle = param2.getRect(param2);
         _local5 = param3.getRect(param3);
         param2.x = (param1 - 2 * param2.width) * 0.25 - _local4.left;
         param3.x = (3 * param1 - 2 * param3.width) * 0.25 - _local5.left;
      }
   }
}
