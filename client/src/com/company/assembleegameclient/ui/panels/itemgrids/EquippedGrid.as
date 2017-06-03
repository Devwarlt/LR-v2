package com.company.assembleegameclient.ui.panels.itemgrids {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;
import kabam.rotmg.assets.model.Player;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.EquipmentTile;
import com.company.util.ArrayIterator;
import com.company.util.IIterator;

import kabam.lib.util.VectorAS3Util;

public class EquippedGrid extends ItemGrid {

      public static const NUM_SLOTS:uint = 4;

      private var tiles:Vector.<EquipmentTile>;

      public function EquippedGrid(param1:GameObject, param2:Vector.<int>, param3:Player, param4:int = 0) {
         var _local6:EquipmentTile = null;
         super(param1,param3,param4);
         this.tiles = new Vector.<EquipmentTile>(NUM_SLOTS);
         var _local5:int = 0;
         while(_local5 < NUM_SLOTS) {
            _local6 = new EquipmentTile(_local5,this,interactive);
            addToGrid(_local6,1,_local5);
            _local6.setType(param2[_local5]);
            this.tiles[_local5] = _local6;
            _local5++;
         }
      }

      public function createInteractiveItemTileIterator() : IIterator {
         return new ArrayIterator(VectorAS3Util.toArray(this.tiles));
      }

      override public function setItems(param1:Vector.<int>, param2:int = 0) : void {
         var _local3:int = 0;
         var _local4:int = 0;
         if(param1) {
            _local3 = param1.length;
            _local4 = 0;
            while(_local4 < this.tiles.length) {
               if(_local4 + param2 < _local3) {
                  this.tiles[_local4].setItem(param1[_local4 + param2]);
               } else {
                  this.tiles[_local4].setItem(-1);
               }
               this.tiles[_local4].updateDim(curPlayer);
               _local4++;
            }
         }
      }
   }
}
