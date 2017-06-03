package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da {
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.GameSprite;
import com.company.assembleegameclient.ui.panels.Panel;

import kabam.rotmg.game.view.NameChangerPanel;

public class LOEBUILD_83c7af17e580756c4c914e5fc723c63c extends GameObject implements LOEBUILD_5e926ae2981199c65b99066bd9e14d29 {

      public var rankRequired_:int = 0;

      public function LOEBUILD_83c7af17e580756c4c914e5fc723c63c(param1:XML) {
         super(param1);
         isInteractive_ = true;
      }

      public function setRankRequired(param1:int) : void {
         this.rankRequired_ = param1;
      }

      public function getPanel(param1:GameSprite) : Panel {
         return new NameChangerPanel(param1,this.rankRequired_);
      }
   }
}
