package com.company.assembleegameclient.LOEBUILD_96062b2d312b581d94ca7a4e277ffe2a {
import com.company.assembleegameclient.ui.Scrollbar;
import com.company.util.GraphicsUtil;

import flash.display.CapsStyle;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.IGraphicsData;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class LOEBUILD_241f7212fc0a9d7d79ce54e77768ee0b extends Sprite {

      public static const WIDTH:int = 136;

      public static const HEIGHT:int = 480;

      private static const SCROLLBAR_WIDTH:int = 20;

      public var layer_:int;

      private var elementSprite_:Sprite;

      public var selected_:LOEBUILD_231afe47f3f37d3808096b36c28b4ded;

      private var scrollBar_:Scrollbar;

      private var mask_:Shape;

      private var elements_:Vector.<LOEBUILD_231afe47f3f37d3808096b36c28b4ded>;

      private var outlineFill_:GraphicsSolidFill;

      private var lineStyle_:GraphicsStroke;

      private var backgroundFill_:GraphicsSolidFill;

      private var path_:GraphicsPath;

      private const graphicsData_:Vector.<IGraphicsData> = new <IGraphicsData>[lineStyle_,backgroundFill_,path_,GraphicsUtil.END_FILL,GraphicsUtil.END_STROKE];

      function LOEBUILD_241f7212fc0a9d7d79ce54e77768ee0b(param1:int) {
         this.elements_ = new Vector.<LOEBUILD_231afe47f3f37d3808096b36c28b4ded>();
         this.outlineFill_ = new GraphicsSolidFill(16777215,1);
         this.lineStyle_ = new GraphicsStroke(1,false,LineScaleMode.NORMAL,CapsStyle.NONE,JointStyle.ROUND,3,this.outlineFill_);
         this.backgroundFill_ = new GraphicsSolidFill(3552822,1);
         this.path_ = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
         super();
         this.layer_ = param1;
         this.drawBackground();
         this.elementSprite_ = new Sprite();
         this.elementSprite_.x = 4;
         this.elementSprite_.y = 6;
         addChild(this.elementSprite_);
         this.scrollBar_ = new Scrollbar(SCROLLBAR_WIDTH,HEIGHT - 8,0.1,this);
         this.scrollBar_.x = WIDTH - SCROLLBAR_WIDTH - 6;
         this.scrollBar_.y = 4;
         this.scrollBar_.addEventListener(Event.CHANGE,this.onScrollBarChange);
         var _local2:Shape = new Shape();
         _local2.graphics.beginFill(0);
         _local2.graphics.drawRect(0,2,LOEBUILD_241f7212fc0a9d7d79ce54e77768ee0b.WIDTH - SCROLLBAR_WIDTH - 4,LOEBUILD_241f7212fc0a9d7d79ce54e77768ee0b.HEIGHT - 4);
         addChild(_local2);
         this.elementSprite_.mask = _local2;
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }

      public function selectedType() : int {
         return this.selected_.type_;
      }

      public function setSelectedType(param1:int) : void {
         var _local2:LOEBUILD_231afe47f3f37d3808096b36c28b4ded = null;
         for each(_local2 in this.elements_) {
            if(_local2.type_ == param1) {
               this.setSelected(_local2);
               return;
            }
         }
      }

      protected function addElement(param1:LOEBUILD_231afe47f3f37d3808096b36c28b4ded) : void {
         var _local2:int = 0;
         _local2 = this.elements_.length;
         param1.x = _local2 % 2 == 0?Number(0):Number(2 + LOEBUILD_231afe47f3f37d3808096b36c28b4ded.WIDTH);
         param1.y = int(_local2 / 2) * LOEBUILD_231afe47f3f37d3808096b36c28b4ded.HEIGHT + 6;
         this.elementSprite_.addChild(param1);
         if(_local2 == 0) {
            this.setSelected(param1);
         }
         param1.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this.elements_.push(param1);
      }

      protected function onMouseDown(param1:MouseEvent) : void {
         var _local2:LOEBUILD_231afe47f3f37d3808096b36c28b4ded = param1.currentTarget as LOEBUILD_231afe47f3f37d3808096b36c28b4ded;
         this.setSelected(_local2);
      }

      protected function setSelected(param1:LOEBUILD_231afe47f3f37d3808096b36c28b4ded) : void {
         if(this.selected_ != null) {
            this.selected_.setSelected(false);
         }
         this.selected_ = param1;
         this.selected_.setSelected(true);
      }

      protected function onScrollBarChange(param1:Event) : void {
         this.elementSprite_.y = 6 - this.scrollBar_.pos() * (this.elementSprite_.height + 12 - HEIGHT);
      }

      protected function onAddedToStage(param1:Event) : void {
         this.scrollBar_.setIndicatorSize(HEIGHT,this.elementSprite_.height);
         addChild(this.scrollBar_);
      }

      protected function onRemovedFromStage(param1:Event) : void {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }

      private function drawBackground() : void {
         GraphicsUtil.clearPath(this.path_);
         GraphicsUtil.drawCutEdgeRect(0,0,WIDTH,HEIGHT,4,[1,1,1,1],this.path_);
         graphics.drawGraphicsData(this.graphicsData_);
      }
   }
}
