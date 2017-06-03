package com.company.assembleegameclient.ui.panels.itemgrids {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;
import kabam.rotmg.assets.model.Player;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InteractiveItemTile;

public class ContainerGrid extends ItemGrid {

      private const NUM_SLOTS:uint = 8;

      private var tiles:Vector.<InteractiveItemTile>;

      public function ContainerGrid(param1:GameObject, param2:Player) {
         var _local4:InteractiveItemTile = null;
         super(param1,param2,0);
         this.tiles = new Vector.<InteractiveItemTile>(this.NUM_SLOTS);
         var _local3:int = 0;
         while(_local3 < this.NUM_SLOTS) {
            _local4 = new InteractiveItemTile(_local3 + indexOffset,this,interactive);
            addToGrid(_local4,2,_local3);
            this.tiles[_local3] = _local4;
            _local3++;
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
