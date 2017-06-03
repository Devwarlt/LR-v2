package kabam.rotmg.arena.util {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;

import flash.display.Bitmap;
import flash.filters.DropShadowFilter;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;

public class ArenaViewAssetFactory {

      public function ArenaViewAssetFactory() {
         super();
      }

      public static function returnTextfield(param1:int, param2:int, param3:Boolean, param4:Boolean = false) : TextFieldDisplayConcrete {
         var _local5:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
         _local5.setSize(param2).setColor(param1).setBold(param3);
         _local5.setVerticalAlign(TextFieldDisplayConcrete.BOTTOM);
         _local5.filters = !!param4?[new DropShadowFilter(0,0,0)]:[];
         return _local5;
      }

      public static function returnHostBitmap(param1:uint) : Bitmap {
         return new Bitmap(LOEBUILD_efda783509bc93eea698457c87bbee3f.getRedrawnTextureFromType(param1,80,true));
      }
   }
}
