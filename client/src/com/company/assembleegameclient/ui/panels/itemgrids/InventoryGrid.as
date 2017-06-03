package com.company.assembleegameclient.ui.panels.itemgrids {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;
import kabam.rotmg.assets.model.Player;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InventoryTile;

public class InventoryGrid extends ItemGrid {

      private const NUM_SLOTS:uint = 8;

      private var tiles:Vector.<InventoryTile>;

      private var isBackpack:Boolean;

      public function InventoryGrid(param1:GameObject, param2:Player, param3:int = 0, param4:Boolean = false) {
         var _local6:InventoryTile = null;
         super(param1,param2,param3);
         this.tiles = new Vector.<InventoryTile>(this.NUM_SLOTS);
         this.isBackpack = param4;
         var _local5:int = 0;
         while(_local5 < this.NUM_SLOTS) {
            _local6 = new InventoryTile(_local5 + indexOffset,this,interactive);
            _local6.addTileNumber(_local5 + 1);
            addToGrid(_local6,2,_local5);
            this.tiles[_local5] = _local6;
            _local5++;
         }
      }

      override public function setItems(param1:Vector.<int>, param2:int = 0) : void {
         var _local3:Boolean = false;
         var _local4:int = 0;
         var _local5:int = 0;
         if(param1) {
            _local3 = false;
            _local4 = param1.length;
            _local5 = 0;
            while(_local5 < this.NUM_SLOTS) {
               if(_local5 + indexOffset < _local4) {
                  if(this.tiles[_local5].setItem(param1[_local5 + indexOffset])) {
                     _local3 = true;
                  }
               } else if(this.tiles[_local5].setItem(-1)) {
                  _local3 = true;
               }
               _local5++;
            }
            if(_local3) {
               refreshTooltip();
            }
         }
      }
   }
}
