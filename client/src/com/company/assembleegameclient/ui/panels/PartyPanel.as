package com.company.assembleegameclient.ui.panels {
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.GameSprite;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_094a173d3b32f44f5b5c996e8710ae28;
import kabam.rotmg.assets.model.Player;
import com.company.assembleegameclient.ui.GameObjectListItem;
import com.company.assembleegameclient.ui.PlayerGameObjectListItem;
import com.company.assembleegameclient.ui.menu.PlayerMenu;
import com.company.util.MoreColorUtil;

import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import flash.utils.getTimer;

public class PartyPanel extends Panel {

      public var menuLayer:DisplayObjectContainer;

      public var memberPanels:Vector.<PlayerGameObjectListItem>;

      public var mouseOver_:Boolean;

      public var menu:PlayerMenu;

      public function PartyPanel(param1:GameSprite) {
         this.memberPanels = new Vector.<PlayerGameObjectListItem>(LOEBUILD_094a173d3b32f44f5b5c996e8710ae28.NUM_MEMBERS,true);
         super(param1);
         this.memberPanels[0] = this.createPartyMemberPanel(0,0);
         this.memberPanels[1] = this.createPartyMemberPanel(100,0);
         this.memberPanels[2] = this.createPartyMemberPanel(0,32);
         this.memberPanels[3] = this.createPartyMemberPanel(100,32);
         this.memberPanels[4] = this.createPartyMemberPanel(0,64);
         this.memberPanels[5] = this.createPartyMemberPanel(100,64);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }

      private function createPartyMemberPanel(param1:int, param2:int) : PlayerGameObjectListItem {
         var _local3:PlayerGameObjectListItem = new PlayerGameObjectListItem(16777215,false,null);
         addChild(_local3);
         _local3.x = param1;
         _local3.y = param2;
         return _local3;
      }

      private function onAddedToStage(param1:Event) : void {
         var _local2:PlayerGameObjectListItem = null;
         for each(_local2 in this.memberPanels) {
            _local2.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
            _local2.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
            _local2.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         }
      }

      private function onRemovedFromStage(param1:Event) : void {
         var _local2:PlayerGameObjectListItem = null;
         this.removeMenu();
         for each(_local2 in this.memberPanels) {
            _local2.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
            _local2.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
            _local2.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         }
      }

      private function onMouseOver(param1:MouseEvent) : void {
         if(this.menu != null && this.menu.parent != null) {
            return;
         }
         var _local2:PlayerGameObjectListItem = param1.currentTarget as PlayerGameObjectListItem;
         var _local3:Player = _local2.go as Player;
         if(_local3 == null || _local3.texture_ == null) {
            return;
         }
         this.mouseOver_ = true;
      }

      private function onMouseOut(param1:MouseEvent) : void {
         this.mouseOver_ = false;
      }

      private function onMouseDown(param1:MouseEvent) : void {
         this.removeMenu();
         var _local2:PlayerGameObjectListItem = param1.currentTarget as PlayerGameObjectListItem;
         _local2.setEnabled(false);
         this.menu = new PlayerMenu();
         this.menu.init(gs_,_local2.go as Player);
         this.menuLayer.addChild(this.menu);
         this.menu.addEventListener(Event.REMOVED_FROM_STAGE,this.onMenuRemoved);
      }

      private function onMenuRemoved(param1:Event) : void {
         var _local2:GameObjectListItem = null;
         var _local3:PlayerGameObjectListItem = null;
         for each(_local2 in this.memberPanels) {
            _local3 = _local2 as PlayerGameObjectListItem;
            if(_local3) {
               _local3.setEnabled(true);
            }
         }
         param1.currentTarget.removeEventListener(Event.REMOVED_FROM_STAGE,this.onMenuRemoved);
      }

      private function removeMenu() : void {
         if(this.menu != null) {
            this.menu.remove();
            this.menu = null;
         }
      }

      override public function draw() : void {
         var _local4:GameObjectListItem = null;
         var _local5:Player = null;
         var _local6:ColorTransform = null;
         var _local7:Number = NaN;
         var _local8:int = 0;
         var _local1:LOEBUILD_094a173d3b32f44f5b5c996e8710ae28 = gs_.map.party_;
         if(_local1 == null) {
            for each(_local4 in this.memberPanels) {
               _local4.clear();
            }
            return;
         }
         var _local2:int = 0;
         var _local3:int = 0;
         while(_local3 < LOEBUILD_094a173d3b32f44f5b5c996e8710ae28.NUM_MEMBERS) {
            if(Boolean(this.mouseOver_) || this.menu != null && this.menu.parent != null) {
               _local5 = this.memberPanels[_local3].go as Player;
            } else {
               _local5 = _local1.members_[_local3];
            }
            if(_local5 != null && _local5.map_ == null) {
               _local5 = null;
            }
            _local6 = null;
            if(_local5 != null) {
               if(_local5.hp_ < _local5.maxHP_ * 0.2) {
                  if(_local2 == 0) {
                     _local2 = getTimer();
                  }
                  _local7 = int(Math.abs(Math.sin(_local2 / 200)) * 10) / 10;
                  _local8 = 128;
                  _local6 = new ColorTransform(1,1,1,1,_local7 * _local8,-_local7 * _local8,-_local7 * _local8);
               }
               if(!_local5.starred_) {
                  if(_local6 != null) {
                     _local6.concat(MoreColorUtil.darkCT);
                  } else {
                     _local6 = MoreColorUtil.darkCT;
                  }
               }
            }
            this.memberPanels[_local3].draw(_local5,_local6);
            _local3++;
         }
      }
   }
}
