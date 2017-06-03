package com.google.analytics.debug {
import flash.display.Graphics;

public class Background {

      public function Background() {
         super();
      }

      public static function drawRounded(param1:*, param2:Graphics, param3:uint = 0, param4:uint = 0) : void {
         var _local5:uint = 0;
         var _local6:uint = 0;
         var _local7:uint = Style.roundedCorner;
         if(param3 > 0 && param4 > 0) {
            _local5 = param3;
            _local6 = param4;
         } else {
            _local5 = param1.width;
            _local6 = param1.height;
         }
         if(Boolean(param1.stickToEdge) && param1.alignement != Align.none) {
            switch(param1.alignement) {
               case Align.top:
                  param2.drawRoundRectComplex(0,0,_local5,_local6,0,0,_local7,_local7);
                  break;
               case Align.topLeft:
                  param2.drawRoundRectComplex(0,0,_local5,_local6,0,0,0,_local7);
                  break;
               case Align.topRight:
                  param2.drawRoundRectComplex(0,0,_local5,_local6,0,0,_local7,0);
                  break;
               case Align.bottom:
                  param2.drawRoundRectComplex(0,0,_local5,_local6,_local7,_local7,0,0);
                  break;
               case Align.bottomLeft:
                  param2.drawRoundRectComplex(0,0,_local5,_local6,0,_local7,0,0);
                  break;
               case Align.bottomRight:
                  param2.drawRoundRectComplex(0,0,_local5,_local6,_local7,0,0,0);
                  break;
               case Align.left:
                  param2.drawRoundRectComplex(0,0,_local5,_local6,0,_local7,0,_local7);
                  break;
               case Align.right:
                  param2.drawRoundRectComplex(0,0,_local5,_local6,_local7,0,_local7,0);
                  break;
               case Align.center:
                  param2.drawRoundRect(0,0,_local5,_local6,_local7,_local7);
            }
         } else {
            param2.drawRoundRect(0,0,_local5,_local6,_local7,_local7);
         }
      }
   }
}
