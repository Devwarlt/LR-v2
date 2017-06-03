package com.company.assembleegameclient.ui {
import com.company.assembleegameclient.LOEBUILD_93fb40ec02c008121fa9199899b31202.LOEBUILD_420e0eb99409a66597f19d612d12594f;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;
import kabam.rotmg.assets.model.Player;
import com.company.util.GraphicsUtil;
import com.company.util.MoreColorUtil;
import com.company.util.SpriteUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.CapsStyle;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.IGraphicsData;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Shape;
import flash.geom.Matrix;
import flash.geom.Point;

import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.text.view.BitmapTextFactory;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.tooltips.HoverTooltipDelegate;
import kabam.rotmg.tooltips.TooltipAble;

public class TradeSlot extends Slot implements TooltipAble {

      private static const IDENTITY_MATRIX:Matrix = new Matrix();

      public static const EMPTY:int = -1;

      private static const DOSE_MATRIX:Matrix = makeDoseMatrix();

      public var included_:Boolean;

      public var equipmentToolTipFactory:EquipmentToolTipFactory;

      public const hoverTooltipDelegate:HoverTooltipDelegate = new HoverTooltipDelegate();

      private var id:uint;

      private var item_:int;

      private var overlay_:Shape;

      private var overlayFill_:GraphicsSolidFill;

      private var lineStyle_:GraphicsStroke;

      private var overlayPath_:GraphicsPath;

      private var graphicsData_:Vector.<IGraphicsData>;

      private var bitmapFactory:BitmapTextFactory;

      public function TradeSlot(param1:int, param2:Boolean, param3:Boolean, param4:int, param5:int, param6:Array, param7:uint) {
         this.equipmentToolTipFactory = new EquipmentToolTipFactory();
         this.overlayFill_ = new GraphicsSolidFill(16711310,1);
         this.lineStyle_ = new GraphicsStroke(2,false,LineScaleMode.NORMAL,CapsStyle.NONE,JointStyle.ROUND,3,this.overlayFill_);
         this.overlayPath_ = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
         this.graphicsData_ = new <IGraphicsData>[this.lineStyle_,this.overlayPath_,GraphicsUtil.END_STROKE];
         super(param4,param5,param6);
         this.id = param7;
         this.item_ = param1;
         this.included_ = param3;
         this.drawItemIfAvailable();
         if(!param2) {
            transform.colorTransform = MoreColorUtil.veryDarkCT;
         }
         this.overlay_ = this.getOverlay();
         addChild(this.overlay_);
         this.setIncluded(param3);
         this.hoverTooltipDelegate.setDisplayObject(this);
      }

      private static function makeDoseMatrix() : Matrix {
         var _local1:Matrix = new Matrix();
         _local1.translate(10,5);
         return _local1;
      }

      private function drawItemIfAvailable() : void {
         if(!this.isEmpty()) {
            this.drawItem();
         }
      }

      private function drawItem() : void {
         var _local3:Point = null;
         var _local4:Bitmap = null;
         var _local5:BitmapData = null;
         SpriteUtil.safeRemoveChild(this,backgroundImage_);
         var _local1:BitmapData = LOEBUILD_efda783509bc93eea698457c87bbee3f.getRedrawnTextureFromType(this.item_,80,true);
         var _local2:XML = LOEBUILD_efda783509bc93eea698457c87bbee3f.xmlLibrary_[this.item_];
         if(Boolean(_local2.hasOwnProperty("Doses")) && Boolean(this.bitmapFactory)) {
            _local1 = _local1.clone();
            _local5 = this.bitmapFactory.make(new StaticStringBuilder(String(_local2.Doses)),12,16777215,false,IDENTITY_MATRIX,false);
            _local1.draw(_local5,DOSE_MATRIX);
         }
         _local3 = offsets(this.item_,type_,false);
         _local4 = new Bitmap(_local1);
         _local4.x = WIDTH / 2 - _local4.width / 2 + _local3.x;
         _local4.y = HEIGHT / 2 - _local4.height / 2 + _local3.y;
         SpriteUtil.safeAddChild(this,_local4);
      }

      public function setIncluded(param1:Boolean) : void {
         this.included_ = param1;
         this.overlay_.visible = this.included_;
         if(this.included_) {
            fill_.color = 16764247;
         } else {
            fill_.color = 2368548;
         }
         drawBackground();
      }

      public function setBitmapFactory(param1:BitmapTextFactory) : void {
         this.bitmapFactory = param1;
         this.drawItemIfAvailable();
      }

      private function getOverlay() : Shape {
         var _local1:Shape = new Shape();
         GraphicsUtil.clearPath(this.overlayPath_);
         GraphicsUtil.drawCutEdgeRect(0,0,WIDTH,HEIGHT,4,cuts_,this.overlayPath_);
         _local1.graphics.drawGraphicsData(this.graphicsData_);
         return _local1;
      }

      public function setShowToolTipSignal(param1:ShowTooltipSignal) : void {
         this.hoverTooltipDelegate.setShowToolTipSignal(param1);
      }

      public function getShowToolTip() : ShowTooltipSignal {
         return this.hoverTooltipDelegate.getShowToolTip();
      }

      public function setHideToolTipsSignal(param1:HideTooltipsSignal) : void {
         this.hoverTooltipDelegate.setHideToolTipsSignal(param1);
      }

      public function getHideToolTips() : HideTooltipsSignal {
         return this.hoverTooltipDelegate.getHideToolTips();
      }

      public function setPlayer(param1:Player) : void {
         if(!this.isEmpty()) {
            this.hoverTooltipDelegate.tooltip = this.equipmentToolTipFactory.make(this.item_,param1,-1,LOEBUILD_420e0eb99409a66597f19d612d12594f.OTHER_PLAYER,this.id);
         }
      }

      public function isEmpty() : Boolean {
         return this.item_ == EMPTY;
      }
   }
}
