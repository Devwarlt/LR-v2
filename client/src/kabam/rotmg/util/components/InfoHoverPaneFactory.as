package kabam.rotmg.util.components {
import flash.display.DisplayObject;
import flash.display.Sprite;

import kabam.rotmg.pets.view.components.PopupWindowBackground;

public class InfoHoverPaneFactory extends Sprite {

      public function InfoHoverPaneFactory() {
         super();
      }

      public static function make(param1:DisplayObject) : Sprite {
         var _local4:PopupWindowBackground = null;
         if(param1 == null) {
            return null;
         }
         var _local2:Sprite = new Sprite();
         var _local3:int = 8;
         param1.width = 291 - _local3;
         param1.height = 598 - _local3 * 2 - 2;
         _local2.addChild(param1);
         _local4 = new PopupWindowBackground();
         _local4.draw(param1.width,param1.height + 2,PopupWindowBackground.TYPE_TRANSPARENT_WITHOUT_HEADER);
         _local4.x = param1.x;
         _local4.y = param1.y - 1;
         _local2.addChild(_local4);
         return _local2;
      }
   }
}
