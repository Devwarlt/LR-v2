package com.company.assembleegameclient.ui.panels.itemgrids.itemtiles {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;
import kabam.rotmg.assets.model.Player;
import com.company.assembleegameclient.ui.panels.itemgrids.ItemGrid;
import com.company.util.GraphicsUtil;

import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.display.Shape;
import flash.display.Sprite;

import kabam.rotmg.constants.ItemConstants;

public class ItemTile extends Sprite {

      public static const TILE_DOUBLE_CLICK:String = "TILE_DOUBLE_CLICK";

      public static const TILE_SINGLE_CLICK:String = "TILE_SINGLE_CLICK";

      public static const WIDTH:int = 40;

      public static const HEIGHT:int = 40;

      public static const BORDER:int = 4;

      private var fill_:GraphicsSolidFill;

      private var path_:GraphicsPath;

      private var graphicsData_:Vector.<IGraphicsData>;

      private var restrictedUseIndicator:Shape;

      public var itemSprite:ItemTileSprite;

      public var tileId:int;

      public var ownerGrid:ItemGrid;

      public var blockingItemUpdates:Boolean;

      public function ItemTile(param1:int, param2:ItemGrid) {
         this.fill_ = new GraphicsSolidFill(this.getBackgroundColor(),1);
         this.path_ = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
         this.graphicsData_ = new <IGraphicsData>[this.fill_,this.path_,GraphicsUtil.END_FILL];
         super();
         this.tileId = param1;
         this.ownerGrid = param2;
         this.restrictedUseIndicator = new Shape();
         addChild(this.restrictedUseIndicator);
         this.setItemSprite(new ItemTileSprite());
      }

      public function drawBackground(param1:Array) : void {
         GraphicsUtil.clearPath(this.path_);
         GraphicsUtil.drawCutEdgeRect(0,0,WIDTH,HEIGHT,4,param1,this.path_);
         graphics.clear();
         graphics.drawGraphicsData(this.graphicsData_);
         var _local2:GraphicsSolidFill = new GraphicsSolidFill(6036765,1);
         GraphicsUtil.clearPath(this.path_);
         var _local3:Vector.<IGraphicsData> = new <IGraphicsData>[_local2,this.path_,GraphicsUtil.END_FILL];
         GraphicsUtil.drawCutEdgeRect(0,0,WIDTH,HEIGHT,4,param1,this.path_);
         this.restrictedUseIndicator.graphics.drawGraphicsData(_local3);
         this.restrictedUseIndicator.cacheAsBitmap = true;
         this.restrictedUseIndicator.visible = false;
      }

      public function setItem(param1:int) : Boolean {
         if(param1 == this.itemSprite.itemId) {
            return false;
         }
         if(this.blockingItemUpdates) {
            return true;
         }
         this.itemSprite.setType(param1);
         this.updateUseability(this.ownerGrid.curPlayer);
         return true;
      }

      public function setItemSprite(param1:ItemTileSprite) : void {
         this.itemSprite = param1;
         var SIZE_8 = 8;
         var SIZE_16 = 16;
         var RESOLUTION_8x8 = 32;
         var RESOLUTION_16x16 = 64;
         /*if((this.itemSprite.width == RESOLUTION_8x8) || (this.itemSprite.width == SIZE_8)) {
            this.itemSprite.scaleX = 1;
            this.itemSprite.scaleY = 1;
         } else if((this.itemSprite.width == RESOLUTION_16x16) || (this.itemSprite.width == SIZE_16)) {
            this.itemSprite.scaleX = 0.5;
            this.itemSprite.scaleY = 0.5;
         }*/
         this.itemSprite.scaleX = 1;
         this.itemSprite.scaleY = 1;
         this.itemSprite.x = WIDTH / 2;
         this.itemSprite.y = HEIGHT / 2;
         addChild(this.itemSprite);
      }

      public function updateUseability(param1:Player) : void {
         if(this.itemSprite.itemId != ItemConstants.NO_ITEM) {
            this.restrictedUseIndicator.visible = !LOEBUILD_efda783509bc93eea698457c87bbee3f.isUsableByPlayer(this.itemSprite.itemId,param1);
         } else {
            this.restrictedUseIndicator.visible = false;
         }
      }

      public function canHoldItem(param1:int) : Boolean {
         return true;
      }

      public function resetItemPosition() : void {
         this.setItemSprite(this.itemSprite);
      }

      public function getItemId() : int {
         return this.itemSprite.itemId;
      }

      protected function getBackgroundColor() : int {
         return 2368548;
      }
   }
}
