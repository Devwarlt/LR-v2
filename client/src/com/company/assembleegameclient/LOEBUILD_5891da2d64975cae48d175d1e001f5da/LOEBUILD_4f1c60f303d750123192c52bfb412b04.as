package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da {
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.GameSprite;
import com.company.assembleegameclient.ui.panels.Panel;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.display.BitmapData;

import kabam.rotmg.game.view.SellableObjectPanel;

public class LOEBUILD_4f1c60f303d750123192c52bfb412b04 extends GameObject implements LOEBUILD_5e926ae2981199c65b99066bd9e14d29 {

      public var price_:int = 0;

      public var currency_:int = -1;

      public var rankReq_:int = 0;

      public var guildRankReq_:int = -1;

      public var quantity_:int = 1;

      public function LOEBUILD_4f1c60f303d750123192c52bfb412b04(param1:XML) {
         super(param1);
         isInteractive_ = true;
      }

      public function setPrice(param1:int) : void {
         this.price_ = param1;
      }

      public function setCurrency(param1:int) : void {
         this.currency_ = param1;
      }

      public function setRankReq(param1:int) : void {
         this.rankReq_ = param1;
      }

      public function soldObjectName() : String {
         return null;
      }

      public function soldObjectInternalName() : String {
         return null;
      }

      public function getTooltip() : ToolTip {
         return null;
      }

      public function getIcon() : BitmapData {
         return null;
      }

      public function getSellableType() : int {
         return -1;
      }

      public function getQuantity() : int {
         return this.quantity_;
      }

      public function getPanel(param1:GameSprite) : Panel {
         return new SellableObjectPanel(param1,this);
      }
   }
}
