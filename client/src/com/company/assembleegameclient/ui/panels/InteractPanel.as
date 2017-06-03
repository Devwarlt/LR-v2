package com.company.assembleegameclient.ui.panels {
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.GameSprite;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_5e926ae2981199c65b99066bd9e14d29;
import kabam.rotmg.assets.model.Player;
import com.company.assembleegameclient.ui.panels.itemgrids.ItemGrid;

import flash.display.Sprite;
import flash.events.Event;

public class InteractPanel extends Sprite {

      public static const MAX_DIST:Number = 1;

      public var gs_:GameSprite;

      public var player_:Player;

      public var w_:int;

      public var h_:int;

      public var currentPanel:Panel = null;

      public var currObj_:LOEBUILD_5e926ae2981199c65b99066bd9e14d29 = null;

      public var partyPanel_:PartyPanel;

      private var overridePanel_:Panel;

      public var requestInteractive:Function;

      public function InteractPanel(param1:GameSprite, param2:Player, param3:int, param4:int) {
         super();
         this.gs_ = param1;
         this.player_ = param2;
         this.w_ = param3;
         this.h_ = param4;
         this.partyPanel_ = new PartyPanel(param1);
      }

      public function setOverride(param1:Panel) : void {
         if(this.overridePanel_ != null) {
            this.overridePanel_.removeEventListener(Event.COMPLETE,this.onComplete);
         }
         this.overridePanel_ = param1;
         this.overridePanel_.addEventListener(Event.COMPLETE,this.onComplete);
      }

      public function redraw() : void {
         this.currentPanel.draw();
      }

      public function draw() : void {
         var _local1:LOEBUILD_5e926ae2981199c65b99066bd9e14d29 = null;
         var _local2:Panel = null;
         if(this.overridePanel_ != null) {
            this.setPanel(this.overridePanel_);
            this.currentPanel.draw();
            return;
         }
         _local1 = this.requestInteractive();
         if(this.currentPanel == null || _local1 != this.currObj_) {
            this.currObj_ = _local1;
            if(this.currObj_ != null) {
               _local2 = this.currObj_.getPanel(this.gs_);
               this.partyPanel_ = new PartyPanel(this.gs_);
            } else {
               _local2 = this.partyPanel_;
            }
            this.setPanel(_local2);
         }
         if(this.currentPanel) {
            this.currentPanel.draw();
         }
      }

      private function onComplete(param1:Event) : void {
         if(this.overridePanel_ != null) {
            this.overridePanel_.removeEventListener(Event.COMPLETE,this.onComplete);
            this.overridePanel_ = null;
         }
         this.setPanel(null);
         this.draw();
      }

      public function setPanel(param1:Panel) : void {
         if(param1 != this.currentPanel) {
            this.currentPanel && removeChild(this.currentPanel);
            this.currentPanel = param1;
            this.currentPanel && this.positionPanelAndAdd();
         }
      }

      private function positionPanelAndAdd() : void {
         if(this.currentPanel is ItemGrid) {
            this.currentPanel.x = (this.w_ - this.currentPanel.width) * 0.5;
            this.currentPanel.y = 8;
         } else {
            this.currentPanel.x = 6;
            this.currentPanel.y = 8;
         }
         addChild(this.currentPanel);
      }
   }
}
