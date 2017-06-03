package com.company.assembleegameclient.ui.panels.itemgrids.itemtiles {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.filters.ColorMatrixFilter;
import flash.geom.Matrix;

import kabam.rotmg.constants.ItemConstants;
import kabam.rotmg.text.view.BitmapTextFactory;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class ItemTileSprite extends Sprite {

      protected static const DIM_FILTER:Array = [new ColorMatrixFilter([0.4,0,0,0,0,0,0.4,0,0,0,0,0,0.4,0,0,0,0,0,1,0])];

      private static const IDENTITY_MATRIX:Matrix = new Matrix();

      private static const DOSE_MATRIX:Matrix = function():Matrix {
         var _local1:* = new Matrix();
         _local1.translate(10,5);
         return _local1;
      }();

      public var itemId:int;

      public var itemBitmap:Bitmap;

      private var bitmapFactory:BitmapTextFactory;

      public function ItemTileSprite() {
         super();
         this.itemBitmap = new Bitmap();
         addChild(this.itemBitmap);
         this.itemId = -1;
      }

      public function setDim(param1:Boolean) : void {
         filters = !!param1?DIM_FILTER:null;
      }

      public function setType(param1:int) : void {
         this.itemId = param1;
         this.drawTile();
      }

      public function drawTile() : void {
         var _local1:BitmapData = null;
         var _local2:XML = null;
         var _local3:BitmapData = null;
         if(this.itemId != ItemConstants.NO_ITEM) {
            _local1 = LOEBUILD_efda783509bc93eea698457c87bbee3f.getRedrawnTextureFromType(this.itemId,80,true);
            _local2 = LOEBUILD_efda783509bc93eea698457c87bbee3f.xmlLibrary_[this.itemId];
            if(Boolean(_local2) && Boolean(_local2.hasOwnProperty("Doses")) && Boolean(this.bitmapFactory)) {
               _local1 = _local1.clone();
               _local3 = this.bitmapFactory.make(new StaticStringBuilder(String(_local2.Doses)),12,16777215,false,IDENTITY_MATRIX,false);
               _local1.draw(_local3,DOSE_MATRIX);
            }
            this.itemBitmap.bitmapData = _local1;
            this.itemBitmap.x = -_local1.width / 2;
            this.itemBitmap.y = -_local1.height / 2;
            visible = true;
         } else {
            visible = false;
         }
      }

      public function setBitmapFactory(param1:BitmapTextFactory) : void {
         this.bitmapFactory = param1;
      }
   }
}
