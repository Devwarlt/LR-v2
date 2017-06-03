package com.company.assembleegameclient.LOEBUILD_96062b2d312b581d94ca7a4e277ffe2a {
import com.company.assembleegameclient.map.LOEBUILD_bc44e55f2b7833506dc8a2b0246803f4;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.display.Shape;

public class LOEBUILD_7d669779d60814024bf08c128a84e965 extends LOEBUILD_231afe47f3f37d3808096b36c28b4ded {

      public var regionXML_:XML;

      public function LOEBUILD_7d669779d60814024bf08c128a84e965(param1:XML) {
         super(int(param1.@type));
         this.regionXML_ = param1;
         var _local2:Shape = new Shape();
         _local2.graphics.beginFill(LOEBUILD_bc44e55f2b7833506dc8a2b0246803f4.getColor(type_),0.5);
         _local2.graphics.drawRect(0,0,WIDTH - 8,HEIGHT - 8);
         _local2.graphics.endFill();
         _local2.x = WIDTH / 2 - _local2.width / 2;
         _local2.y = HEIGHT / 2 - _local2.height / 2;
         addChild(_local2);
      }

      override protected function getToolTip() : ToolTip {
         return new LOEBUILD_f5fe978051621f27d77bddef90b81530(this.regionXML_);
      }
   }
}
