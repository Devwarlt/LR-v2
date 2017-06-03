package com.company.assembleegameclient.LOEBUILD_96062b2d312b581d94ca7a4e277ffe2a {
import com.company.assembleegameclient.map.LOEBUILD_463df66a32ccee700fe56a1531ecc43e;
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5;
import com.company.assembleegameclient.map.LOEBUILD_c4f34d70d961150ec58669f7728743a4;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.display.BitmapData;
import flash.display.IGraphicsData;
import flash.display.Shape;
import flash.geom.Rectangle;

class LOEBUILD_825952f3c03896b4449907b17896e209 extends LOEBUILD_231afe47f3f37d3808096b36c28b4ded {

      private static const VIN:Vector.<Number> = new <Number>[0,0,0,1,0,0,1,1,0,0,1,0];

      private static const SCALE:Number = 0.6;

      public var groundXML_:XML;

      private var tileShape_:Shape;

      function LOEBUILD_825952f3c03896b4449907b17896e209(param1:XML) {
         super(int(param1.@type));
         this.groundXML_ = param1;
         var _local2:Vector.<IGraphicsData> = new Vector.<IGraphicsData>();
         var _local3:Camera = new Camera();
         _local3.configure(0.5,0.5,12,Math.PI / 4,new Rectangle(-100,-100,200,200));
         var _local4:BitmapData = LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5.getBitmapData(type_);
         var _local5:LOEBUILD_c4f34d70d961150ec58669f7728743a4 = new LOEBUILD_c4f34d70d961150ec58669f7728743a4(_local4,VIN,0,0,LOEBUILD_463df66a32ccee700fe56a1531ecc43e.NO_ANIMATE,0,0);
         _local5.draw(_local2,_local3,0);
         this.tileShape_ = new Shape();
         this.tileShape_.graphics.drawGraphicsData(_local2);
         this.tileShape_.scaleX = this.tileShape_.scaleY = SCALE;
         this.tileShape_.x = WIDTH / 2;
         this.tileShape_.y = HEIGHT / 2;
         addChild(this.tileShape_);
      }

      override protected function getToolTip() : ToolTip {
         return new LOEBUILD_84466b0dc8feac86b981d7141ae8ff81(this.groundXML_);
      }
   }
}
