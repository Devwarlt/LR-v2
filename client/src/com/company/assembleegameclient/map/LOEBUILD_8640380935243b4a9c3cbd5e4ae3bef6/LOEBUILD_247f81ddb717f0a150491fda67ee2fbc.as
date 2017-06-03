package com.company.assembleegameclient.map.LOEBUILD_8640380935243b4a9c3cbd5e4ae3bef6 {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.map.Quest;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.assembleegameclient.ui.tooltip.PortraitToolTip;
import com.company.assembleegameclient.ui.tooltip.QuestToolTip;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.events.MouseEvent;
import flash.utils.getTimer;

public class LOEBUILD_247f81ddb717f0a150491fda67ee2fbc extends LOEBUILD_4a59873dd40437adf7708a4430a17690 {

      public var map_:Map;

      public function LOEBUILD_247f81ddb717f0a150491fda67ee2fbc(param1:Map) {
         super(16352321,12919330,true);
         this.map_ = param1;
      }

      public function refreshToolTip() : void {
         setToolTip(this.getToolTip(go_,getTimer()));
      }

      override protected function onMouseOver(param1:MouseEvent) : void {
         super.onMouseOver(param1);
         this.refreshToolTip();
      }

      override protected function onMouseOut(param1:MouseEvent) : void {
         super.onMouseOut(param1);
         this.refreshToolTip();
      }

      private function getToolTip(param1:GameObject, param2:int) : ToolTip {
         if(param1 == null || param1.texture_ == null) {
            return null;
         }
         if(this.shouldShowFullQuest(param2)) {
            return new QuestToolTip(go_);
         }
         if(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.showQuestPortraits) {
            return new PortraitToolTip(param1);
         }
         return null;
      }

      private function shouldShowFullQuest(param1:int) : Boolean {
         var _local2:Quest = this.map_.quest_;
         return Boolean(mouseOver_) || Boolean(_local2.isNew(param1));
      }

      override public function draw(param1:int, param2:Camera) : void {
         var _local4:* = false;
         var _local5:Boolean = false;
         var _local3:GameObject = this.map_.quest_.getObject(param1);
         if(_local3 != go_) {
            setGameObject(_local3);
            setToolTip(this.getToolTip(_local3,param1));
         } else if(go_ != null) {
            _local4 = tooltip_ is QuestToolTip;
            _local5 = this.shouldShowFullQuest(param1);
            if(_local4 != _local5) {
               setToolTip(this.getToolTip(_local3,param1));
            }
         }
         super.draw(param1,param2);
      }
   }
}
