package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da {
import com.company.assembleegameclient.ui.tooltip.TextToolTip;
import com.company.assembleegameclient.ui.tooltip.ToolTip;
import com.company.assembleegameclient.util.Currency;
import com.company.assembleegameclient.util.GuildUtil;

import flash.display.BitmapData;

public class GuildMerchant extends LOEBUILD_4f1c60f303d750123192c52bfb412b04 implements LOEBUILD_5e926ae2981199c65b99066bd9e14d29 {

      public var description_:String;

      public function GuildMerchant(param1:XML) {
         super(param1);
         price_ = int(param1.Price);
         currency_ = Currency.GUILD_FAME;
         this.description_ = param1.Description;
         guildRankReq_ = GuildUtil.LEADER;
      }

      override public function soldObjectName() : String {
         return LOEBUILD_efda783509bc93eea698457c87bbee3f.typeToDisplayId_[objectType_];
      }

      override public function soldObjectInternalName() : String {
         var _local1:XML = LOEBUILD_efda783509bc93eea698457c87bbee3f.xmlLibrary_[objectType_];
         return _local1.@id.toString();
      }

      override public function getTooltip() : ToolTip {
         var _local1:ToolTip = new TextToolTip(3552822,10197915,this.soldObjectName(),this.description_,200);
         return _local1;
      }

      override public function getSellableType() : int {
         return objectType_;
      }

      override public function getIcon() : BitmapData {
         return LOEBUILD_efda783509bc93eea698457c87bbee3f.getRedrawnTextureFromType(objectType_,80,true);
      }
   }
}
