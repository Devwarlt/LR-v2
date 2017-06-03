package com.company.assembleegameclient.ui.menu {
import com.company.assembleegameclient.map.LOEBUILD_fa44c2f4ed610d0a29b25a8fff9d67e7;
import kabam.rotmg.assets.model.Player;
import com.company.assembleegameclient.ui.GameObjectListItem;
import com.company.assembleegameclient.ui.LineBreakDesign;

import flash.events.Event;
import flash.events.MouseEvent;

import org.osflash.signals.Signal;

public class PlayerGroupMenu extends Menu {

      private var playerPanels_:Vector.<GameObjectListItem>;

      private var posY:uint = 4;

      public var map_:LOEBUILD_fa44c2f4ed610d0a29b25a8fff9d67e7;

      public var players_:Vector.<Player>;

      public var teleportOption_:MenuOption;

      public var lineBreakDesign_:LineBreakDesign;

      public var unableToTeleport:Signal;

      public function PlayerGroupMenu(param1:LOEBUILD_fa44c2f4ed610d0a29b25a8fff9d67e7, param2:Vector.<Player>) {
         this.playerPanels_ = new Vector.<GameObjectListItem>();
         this.unableToTeleport = new Signal();
         super(3552822,16777215);
         this.map_ = param1;
         this.players_ = param2.concat();
         this.createHeader();
         this.createPlayerList();
      }

      private function createPlayerList() : void {
         var _local1:Player = null;
         var _local2:GameObjectListItem = null;
         for each(_local1 in this.players_) {
            _local2 = new GameObjectListItem(11776947,true,_local1);
            _local2.x = 0;
            _local2.y = this.posY;
            addChild(_local2);
            this.playerPanels_.push(_local2);
            this.posY = this.posY + 32;
         }
      }

      private function createHeader() : void {
         if(this.map_.allowPlayerTeleport()) {
            this.teleportOption_ = new TeleportMenuOption(this.map_.player_);
            this.teleportOption_.x = 8;
            this.teleportOption_.y = 8;
            this.teleportOption_.addEventListener(MouseEvent.CLICK,this.onTeleport);
            addChild(this.teleportOption_);
            this.lineBreakDesign_ = new LineBreakDesign(150,1842204);
            this.lineBreakDesign_.x = 6;
            this.lineBreakDesign_.y = 40;
            addChild(this.lineBreakDesign_);
            this.posY = 52;
         }
      }

      private function onTeleport(param1:Event) : void {
         var _local4:Player = null;
         var _local2:Player = this.map_.player_;
         var _local3:Player = null;
         for each(_local4 in this.players_) {
            if(Player.isTeleportEligible(_local4)) {
               _local3 = _local4;
               if(_local4.isFellowGuild_) {
                  break;
               }
            }
         }
         if(_local3 != null) {
            _local2.teleportTo(_local3);
         } else {
            this.unableToTeleport.dispatch();
         }
         remove();
      }
   }
}
