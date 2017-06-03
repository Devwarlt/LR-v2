package com.company.assembleegameclient.LOEBUILD_96062b2d312b581d94ca7a4e277ffe2a {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.display.Bitmap;
import flash.display.BitmapData;

class LOEBUILD_6b2a19f9efe051a753df4dbf1c22af39 extends LOEBUILD_231afe47f3f37d3808096b36c28b4ded {

      public var objXML_:XML;

      function LOEBUILD_6b2a19f9efe051a753df4dbf1c22af39(param1:XML) {
         var _local3:Bitmap = null;
         super(int(param1.@type));
         this.objXML_ = param1;
         var _local2:BitmapData = LOEBUILD_efda783509bc93eea698457c87bbee3f.getRedrawnTextureFromType(type_,100,true,false);
         _local3 = new Bitmap(_local2);
         var _local4:Number = (WIDTH - 4) / Math.max(_local3.width,_local3.height);
         _local3.scaleX = _local3.scaleY = _local4;
         _local3.x = WIDTH / 2 - _local3.width / 2;
         _local3.y = HEIGHT / 2 - _local3.height / 2;
         addChild(_local3);
      }

      override protected function getToolTip() : ToolTip {
         return new LOEBUILD_2cd8ef38079f92043aece0726158bb30(this.objXML_);
      }
   }
}
