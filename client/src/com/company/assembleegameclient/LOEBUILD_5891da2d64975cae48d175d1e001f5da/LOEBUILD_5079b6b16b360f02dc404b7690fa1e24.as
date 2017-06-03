package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da {
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.GameSprite;
import com.company.assembleegameclient.ui.panels.GuildBoardPanel;
import com.company.assembleegameclient.ui.panels.Panel;

public class LOEBUILD_5079b6b16b360f02dc404b7690fa1e24 extends GameObject implements LOEBUILD_5e926ae2981199c65b99066bd9e14d29 {

      public function LOEBUILD_5079b6b16b360f02dc404b7690fa1e24(param1:XML) {
         super(param1);
         isInteractive_ = true;
      }

      public function getPanel(param1:GameSprite) : Panel {
         return new GuildBoardPanel(param1);
      }
   }
}
