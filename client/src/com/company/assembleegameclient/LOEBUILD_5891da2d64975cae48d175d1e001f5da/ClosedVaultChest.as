package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da {
import com.company.assembleegameclient.ui.tooltip.TextToolTip;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.display.BitmapData;

import kabam.rotmg.text.model.TextKey;

public class ClosedVaultChest extends LOEBUILD_4f1c60f303d750123192c52bfb412b04 {

      public function ClosedVaultChest(param1:XML) {
         super(param1);
      }

      override public function soldObjectName() : String {
         return TextKey.VAULT_CHEST;
      }

      override public function soldObjectInternalName() : String {
         return "Vault Chest";
      }

      override public function getTooltip() : ToolTip {
         var _local1:ToolTip = new TextToolTip(3552822,10197915,this.soldObjectName(),TextKey.VAULT_CHEST_DESCRIPTION,200);
         return _local1;
      }

      override public function getSellableType() : int {
         return LOEBUILD_efda783509bc93eea698457c87bbee3f.idToType_["Vault Chest"];
      }

      override public function getIcon() : BitmapData {
         return LOEBUILD_efda783509bc93eea698457c87bbee3f.getRedrawnTextureFromType(LOEBUILD_efda783509bc93eea698457c87bbee3f.idToType_["Vault Chest"],80,true);
      }
   }
}
