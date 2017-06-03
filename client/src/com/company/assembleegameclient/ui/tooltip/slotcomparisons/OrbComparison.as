package com.company.assembleegameclient.ui.tooltip.slotcomparisons {
import com.company.assembleegameclient.ui.tooltip.TooltipHelper;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class OrbComparison extends SlotComparison {

      public function OrbComparison() {
         super();
      }

      override protected function compareSlots(param1:XML, param2:XML) : void {
         var _local3:XML = null;
         var _local4:XML = null;
         var _local5:int = 0;
         var _local6:int = 0;
         var _local7:uint = 0;
         _local3 = this.getStasisBlastTag(param1);
         _local4 = this.getStasisBlastTag(param2);
         comparisonStringBuilder = new AppendingLineBuilder();
         if(_local3 != null && _local4 != null) {
            _local5 = int(_local3.@duration);
            _local6 = int(_local4.@duration);
            _local7 = getTextColor(_local5 - _local6);
            comparisonStringBuilder.pushParams(TextKey.STASIS_GROUP,{"stasis":new LineBuilder().setParams(TextKey.SEC_COUNT,{"duration":_local5}).setPrefix(TooltipHelper.getOpenTag(_local7)).setPostfix(TooltipHelper.getCloseTag())});
            processedTags[_local3.toXMLString()] = true;
            this.handleExceptions(param1);
         }
      }

      private function getStasisBlastTag(param1:XML) : XML {
         var matches:XMLList = null;
         var orbXML:XML = param1;
         matches = orbXML.Activate.(text() == "StasisBlast");
         return matches.length() == 1?matches[0]:null;
      }

      private function handleExceptions(param1:XML) : void {
         var selfTags:XMLList = null;
         var speedy:XML = null;
         var damaging:XML = null;
         var itemXML:XML = param1;
         if(itemXML.@id == "Orb of Conflict") {
            selfTags = itemXML.Activate.(text() == "ConditionEffectSelf");
            speedy = selfTags.(@effect == "Speedy")[0];
            damaging = selfTags.(@effect == "Damaging")[0];
            comparisonStringBuilder.pushParams(TextKey.EFFECT_ON_SELF,{"effect":""});
            comparisonStringBuilder.pushParams(TextKey.EFFECT_FOR_DURATION,{
               "effect":TextKey.wrapForTokenResolution(TextKey.ACTIVE_EFFECT_SPEEDY),
               "duration":speedy.@duration
            },TooltipHelper.getOpenTag(UNTIERED_COLOR),TooltipHelper.getCloseTag());
            comparisonStringBuilder.pushParams(TextKey.EFFECT_ON_SELF,{"effect":""});
            comparisonStringBuilder.pushParams(TextKey.EFFECT_FOR_DURATION,{
               "effect":TextKey.wrapForTokenResolution(TextKey.ACTIVE_EFFECT_DAMAGING),
               "duration":damaging.@duration
            },TooltipHelper.getOpenTag(UNTIERED_COLOR),TooltipHelper.getCloseTag());
            processedTags[speedy.toXMLString()] = true;
            processedTags[damaging.toXMLString()] = true;
         }
      }
   }
}
