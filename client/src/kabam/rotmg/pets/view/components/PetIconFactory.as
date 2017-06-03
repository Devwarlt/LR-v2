package kabam.rotmg.pets.view.components {
import com.company.assembleegameclient.util.BitmapDataSpy;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.assembleegameclient.util.redrawers.GlowRedrawer;

import flash.display.Bitmap;
import flash.display.BitmapData;

import kabam.rotmg.pets.data.PetVO;

public class PetIconFactory {

      public var outlineSize:Number = 1.4;

      public function PetIconFactory() {
         super();
      }

      public function create(param1:PetVO, param2:int) : PetIcon {
         var _local3:BitmapData = this.getPetSkinTexture(param1,param2);
         var _local4:Bitmap = new Bitmap(_local3);
         var _local5:PetIcon = new PetIcon(param1);
         _local5.setBitmap(_local4);
         return _local5;
      }

      public function getPetSkinTexture(param1:PetVO, param2:int) : BitmapData {
         var _local4:Number = NaN;
         var _local5:BitmapData = null;
         var _local3:BitmapData = !!param1.getSkinMaskedImage()?param1.getSkinMaskedImage().image_:null;
         if(_local3) {
            _local4 = (param2 - TextureRedrawer.minSize) / _local3.width;
            _local5 = TextureRedrawer.resize(_local3,param1.getSkinMaskedImage().mask_,100,true,0,0,_local4);
            _local5 = GlowRedrawer.outlineGlow(_local5,0,this.outlineSize);
            return _local5;
         }
         return new BitmapDataSpy(param2,param2);
      }
   }
}
