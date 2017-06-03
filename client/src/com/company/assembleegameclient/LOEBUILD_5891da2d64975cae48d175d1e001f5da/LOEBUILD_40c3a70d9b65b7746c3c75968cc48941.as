package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da {
import com.company.assembleegameclient.util.BitmapDataSpy;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.AssetLibrary;

import flash.display.BitmapData;

public class LOEBUILD_40c3a70d9b65b7746c3c75968cc48941 {

      public function LOEBUILD_40c3a70d9b65b7746c3c75968cc48941() {
         super();
      }

      public function getImageFromSet(param1:String, param2:int) : BitmapData {
         return AssetLibrary.getImageFromSet(param1,param2);
      }

      public function getTexture(param1:int, param2:int) : BitmapData {
         var _local4:Number = NaN;
         var _local5:BitmapData = null;
         var _local3:BitmapData = LOEBUILD_efda783509bc93eea698457c87bbee3f.getBitmapData(param1);
         if(_local3) {
            _local4 = (param2 - TextureRedrawer.minSize) / _local3.width;
            _local5 = LOEBUILD_efda783509bc93eea698457c87bbee3f.getRedrawnTextureFromType(param1,100,true,false,_local4);
            return _local5;
         }
         return new BitmapDataSpy(param2,param2);
      }
   }
}
