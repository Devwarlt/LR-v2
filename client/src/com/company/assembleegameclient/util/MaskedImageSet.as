package com.company.assembleegameclient.util {
import com.company.util.ImageSet;

import flash.display.BitmapData;

public class MaskedImageSet {

      public var images_:Vector.<MaskedImage>;

      public function MaskedImageSet() {
         this.images_ = new Vector.<MaskedImage>();
         super();
      }

      public function addFromBitmapData(param1:BitmapData, param2:BitmapData, param3:int, param4:int) : void {
         var _local5:ImageSet = new ImageSet();
         _local5.addFromBitmapData(param1,param3,param4);
         var _local6:ImageSet = null;
         if(param2 != null) {
            _local6 = new ImageSet();
            _local6.addFromBitmapData(param2,param3,param4);
         }
         var _local7:int = 0;
         while(_local7 < _local5.images_.length) {
            this.images_.push(new MaskedImage(_local5.images_[_local7],_local6 == null?null:_local6.images_[_local7]));
            _local7++;
         }
      }

      public function addFromMaskedImage(param1:MaskedImage, param2:int, param3:int) : void {
         this.addFromBitmapData(param1.image_,param1.mask_,param2,param3);
      }
   }
}
