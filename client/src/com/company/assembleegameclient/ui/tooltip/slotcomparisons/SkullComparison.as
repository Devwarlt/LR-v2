package com.company.assembleegameclient.ui.tooltip.slotcomparisons {
import com.company.assembleegameclient.ui.tooltip.TooltipHelper;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class SkullComparison extends SlotComparison {

      public function SkullComparison() {
         super();
      }

      override protected function compareSlots(param1:XML, param2:XML) : void {
         var _local3:XML = null;
         var _local4:XML = null;
         var _local5:Number = NaN;
         var _local6:Number = NaN;
         var _local7:int = 0;
         var _local8:int = 0;
         var _local9:Number = NaN;
         var _local10:Number = NaN;
         _local3 = this.getVampireBlastTag(param1);
         _local4 = this.getVampireBlastTag(param2);
         comparisonStringBuilder = new AppendingLineBuilder();
         if(_local3 != null && _local4 != null) {
            _local5 = Number(_local3.@radius);
            _local6 = Number(_local4.@radius);
            _local7 = int(_local3.@totalDamage);
            _local8 = int(_local4.@totalDamage);
            _local9 = 0.5 * _local5 + 0.5 * _local7;
            _local10 = 0.5 * _local6 + 0.5 * _local8;
            comparisonStringBuilder.pushParams(TextKey.STEAL,{"effect":new LineBuilder().setParams(TextKey.HP_WITHIN_SQRS,{
               "amount":_local7,
               "range":_local5
            }).setPrefix(TooltipHelper.getOpenTag(getTextColor(_local9 - _local10))).setPostfix(TooltipHelper.getCloseTag())});
            processedTags[_local3.toXMLString()] = true;
         }
      }

      private function getVampireBlastTag(param1:XML) : XML {
         var matches:XMLList = null;
         var xml:XML = param1;
         matches = xml.Activate.(text() == "VampireBlast");
         return matches.length() >= 1?matches[0]:null;
      }
   }
}
