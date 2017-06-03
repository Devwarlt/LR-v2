package com.company.assembleegameclient.ui.tooltip {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;
import com.company.util.BitmapUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;

public class PortraitToolTip extends ToolTip {

      private var portrait_:Bitmap;

      public function PortraitToolTip(param1:GameObject) {
         super(6036765,1,16549442,1,false);
         this.portrait_ = new Bitmap();
         this.portrait_.x = 0;
         this.portrait_.y = 0;
         var _local2:BitmapData = param1.getPortrait();
         _local2 = BitmapUtil.cropToBitmapData(_local2,10,10,_local2.width - 20,_local2.height - 20);
         this.portrait_.bitmapData = _local2;
         addChild(this.portrait_);
         filters = [];
      }
   }
}
