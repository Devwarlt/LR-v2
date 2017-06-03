package com.company.assembleegameclient.LOEBUILD_96062b2d312b581d94ca7a4e277ffe2a {
import com.company.assembleegameclient.ui.tooltip.ToolTip;
import com.company.ui.BaseSimpleText;

import flash.filters.DropShadowFilter;

public class LOEBUILD_f5fe978051621f27d77bddef90b81530 extends ToolTip {

      private static const MAX_WIDTH:int = 180;

      private var titleText_:BaseSimpleText;

      public function LOEBUILD_f5fe978051621f27d77bddef90b81530(param1:XML) {
         super(3552822,1,10197915,1,true);
         this.titleText_ = new BaseSimpleText(16,16777215,false,MAX_WIDTH - 4,0);
         this.titleText_.setBold(true);
         this.titleText_.wordWrap = true;
         this.titleText_.text = String(param1.@id);
         this.titleText_.useTextDimensions();
         this.titleText_.filters = [new DropShadowFilter(0,0,0,0.5,12,12)];
         this.titleText_.x = 0;
         this.titleText_.y = 0;
         addChild(this.titleText_);
      }
   }
}
