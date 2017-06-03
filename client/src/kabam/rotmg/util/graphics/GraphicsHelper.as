package kabam.rotmg.util.graphics {
import flash.display.Graphics;

public class GraphicsHelper {

      public function GraphicsHelper() {
         super();
      }

      public function drawBevelRect(param1:int, param2:int, param3:BevelRect, param4:Graphics) : void {
         var _local5:int = param1 + param3.width;
         var _local6:int = param2 + param3.height;
         var _local7:int = param3.bevel;
         if(param3.topLeftBevel) {
            param4.moveTo(param1,param2 + _local7);
            param4.lineTo(param1 + _local7,param2);
         } else {
            param4.moveTo(param1,param2);
         }
         if(param3.topRightBevel) {
            param4.lineTo(_local5 - _local7,param2);
            param4.lineTo(_local5,param2 + _local7);
         } else {
            param4.lineTo(_local5,param2);
         }
         if(param3.bottomRightBevel) {
            param4.lineTo(_local5,_local6 - _local7);
            param4.lineTo(_local5 - _local7,_local6);
         } else {
            param4.lineTo(_local5,_local6);
         }
         if(param3.bottomLeftBevel) {
            param4.lineTo(param1 + _local7,_local6);
            param4.lineTo(param1,_local6 - _local7);
         } else {
            param4.lineTo(param1,_local6);
         }
      }
   }
}
