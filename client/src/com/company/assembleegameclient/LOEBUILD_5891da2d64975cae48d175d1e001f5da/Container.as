package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da {
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.GameSprite;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.sound.SoundEffectLibrary;
import com.company.assembleegameclient.ui.panels.Panel;
import com.company.assembleegameclient.ui.panels.itemgrids.ContainerGrid;
import com.company.util.PointUtil;

import kabam.rotmg.assets.model.Player;

public class Container extends GameObject implements LOEBUILD_5e926ae2981199c65b99066bd9e14d29 {

      public var isLoot_:Boolean;

      public var ownerId_:String;

      public function Container(param1:XML) {
         super(param1);
         isInteractive_ = true;
         this.isLoot_ = param1.hasOwnProperty("Loot");
         this.ownerId_ = "";
      }

      public function setOwnerId(param1:String) : void {
         this.ownerId_ = param1;
         isInteractive_ = this.ownerId_ == "" || Boolean(this.isBoundToCurrentAccount());
      }

      public function isBoundToCurrentAccount() : Boolean {
         return map_.player_.accountId_ == this.ownerId_;
      }

      override public function addTo(param1:Map, param2:Number, param3:Number) : Boolean {
         if(!super.addTo(param1,param2,param3)) {
            return false;
         }
         if(map_.player_ == null) {
            return true;
         }
         var _local4:Number = PointUtil.distanceXY(map_.player_.x_,map_.player_.y_,param2,param3);
         if(Boolean(this.isLoot_) && _local4 < 10) {
            SoundEffectLibrary.play("loot_appears");
         }
         return true;
      }

      public function getPanel(param1:GameSprite) : Panel {
         var _local2:Player = Boolean(param1) && Boolean(param1.map)?param1.map.player_:null;
         var _local3:ContainerGrid = new ContainerGrid(this,_local2);
         return _local3;
      }
   }
}
