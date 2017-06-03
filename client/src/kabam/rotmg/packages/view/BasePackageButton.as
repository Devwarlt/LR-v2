package kabam.rotmg.packages.view {
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.AssetLibrary;
import com.company.util.BitmapUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.geom.Rectangle;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;

public class BasePackageButton extends Sprite {

      public static const IMAGE_NAME:String = "redLootBag";

      public static const IMAGE_ID:int = 0;

      public function BasePackageButton() {
         super();
      }

      protected static function makeIcon() : DisplayObject {
         var _local2:DisplayObject = null;
         var _local1:BitmapData = AssetLibrary.getImageFromSet(IMAGE_NAME,IMAGE_ID);
         _local1 = TextureRedrawer.redraw(_local1,40,true,0);
         _local1 = BitmapUtil.cropToBitmapData(_local1,10,10,_local1.width - 20,_local1.height - 20);
         _local2 = new Bitmap(_local1);
         _local2.x = 3;
         _local2.y = 3;
         return _local2;
      }

      protected function positionText(param1:DisplayObject, param2:TextFieldDisplayConcrete) : void {
         var _local4:Number = NaN;
         var _local3:Rectangle = param1.getBounds(this);
         _local4 = _local3.top + _local3.height / 2;
         param2.x = _local3.right;
         param2.y = _local4 - param2.height / 2;
      }
   }
}
