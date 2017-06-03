package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da {
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.GameSprite;
import com.company.assembleegameclient.ui.panels.Panel;
import com.company.assembleegameclient.ui.tooltip.TextToolTip;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import kabam.rotmg.pets.view.components.PetInteractionPanel;
import kabam.rotmg.text.model.TextKey;

public class PetUpgrader extends GameObject implements LOEBUILD_5e926ae2981199c65b99066bd9e14d29 {

      public function PetUpgrader(param1:XML) {
         super(param1);
         isInteractive_ = true;
      }

      public function getTooltip() : ToolTip {
         var _local1:ToolTip = new TextToolTip(3552822,10197915,TextKey.CLOSEDGIFTCHEST_TITLE,TextKey.TEXTPANEL_GIFTCHESTISEMPTY,200);
         return _local1;
      }

      public function getPanel(param1:GameSprite) : Panel {
         return new PetInteractionPanel(param1,objectType_);
      }
   }
}
