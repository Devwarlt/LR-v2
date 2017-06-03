package kabam.lib.ui.impl {
import flash.display.DisplayObject;

import kabam.lib.ui.api.Layout;

public class VerticalLayout implements Layout {

      private var padding:int = 0;

      public function VerticalLayout() {
         super();
      }

      public function getPadding() : int {
         return this.padding;
      }

      public function setPadding(param1:int) : void {
         this.padding = param1;
      }

      public function layout(param1:Vector.<DisplayObject>, param2:int = 0) : void {
         var _local6:DisplayObject = null;
         var _local3:int = param2;
         var _local4:int = param1.length;
         var _local5:int = 0;
         while(_local5 < _local4) {
            _local6 = param1[_local5];
            _local6.y = _local3;
            _local3 = _local3 + (_local6.height + this.padding);
            _local5++;
         }
      }
   }
}
