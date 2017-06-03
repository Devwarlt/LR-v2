package kabam.rotmg.arena.component {
import com.company.assembleegameclient.ui.GuildText;
import com.company.assembleegameclient.ui.panels.itemgrids.EquippedGrid;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.display.Bitmap;

import kabam.rotmg.arena.model.ArenaLeaderboardEntry;
import kabam.rotmg.text.view.StaticTextDisplay;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class AbridgedPlayerTooltip extends ToolTip {

      public function AbridgedPlayerTooltip(param1:ArenaLeaderboardEntry) {
         var _local3:StaticTextDisplay = null;
         var _local5:GuildText = null;
         var _local2:Bitmap = new Bitmap();
         _local2.bitmapData = param1.playerBitmap;
         _local2.scaleX = 0.75;
         _local2.scaleY = 0.75;
         _local2.y = 5;
         addChild(_local2);
         _local3 = new StaticTextDisplay();
         _local3.setSize(14).setBold(true).setColor(16777215);
         _local3.setStringBuilder(new StaticStringBuilder(param1.name));
         _local3.x = 40;
         _local3.y = 5;
         addChild(_local3);
         if(param1.guildName) {
            _local5 = new GuildText(param1.guildName,param1.guildRank);
            _local5.x = 40;
            _local5.y = 20;
            addChild(_local5);
         }
         super(3552822,0.5,16777215,1);
         var _local4:EquippedGrid = new EquippedGrid(null,param1.slotTypes,null);
         _local4.x = 5;
         _local4.y = !!_local5?Number(_local5.y + _local5.height - 5):Number(55);
         _local4.setItems(param1.equipment);
         addChild(_local4);
      }
   }
}
