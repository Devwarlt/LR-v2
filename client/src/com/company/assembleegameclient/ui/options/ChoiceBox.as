package com.company.assembleegameclient.ui.options {
import com.company.util.GraphicsUtil;

import flash.display.CapsStyle;
import flash.display.Graphics;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.IGraphicsData;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class ChoiceBox extends Sprite {

      public static const WIDTH:int = 80;

      public static const HEIGHT:int = 32;

      public var labels_:Vector.<StringBuilder>;

      public var values_:Array;

      public var selectedIndex_:int = -1;

      public var labelText_:TextFieldDisplayConcrete;

      private var over_:Boolean = false;

      private var color:Number = 16777215;

      private var internalFill_:GraphicsSolidFill;

      private var overLineFill_:GraphicsSolidFill;

      private var normalLineFill_:GraphicsSolidFill;

      private var path_:GraphicsPath;

      private var lineStyle_:GraphicsStroke;

      private var graphicsData_:Vector.<IGraphicsData>;

      public function ChoiceBox(param1:Vector.<StringBuilder>, param2:Array, param3:Object, param4:Number = 16777215) {
         this.internalFill_ = new GraphicsSolidFill(3355443,1);
         this.overLineFill_ = new GraphicsSolidFill(11776947,1);
         this.normalLineFill_ = new GraphicsSolidFill(4473924,1);
         this.path_ = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
         this.lineStyle_ = new GraphicsStroke(2,false,LineScaleMode.NORMAL,CapsStyle.NONE,JointStyle.ROUND,3,this.normalLineFill_);
         this.graphicsData_ = new <IGraphicsData>[internalFill_,lineStyle_,path_,GraphicsUtil.END_STROKE,GraphicsUtil.END_FILL];
         super();
         this.color = param4;
         this.labels_ = param1;
         this.values_ = param2;
         this.labelText_ = new TextFieldDisplayConcrete().setSize(16).setColor(param4);
         this.labelText_.x = WIDTH / 2;
         this.labelText_.y = HEIGHT / 2;
         this.labelText_.setAutoSize(TextFieldAutoSize.CENTER).setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
         this.labelText_.setBold(true);
         this.labelText_.filters = [new DropShadowFilter(0,0,0,1,4,4,2)];
         addChild(this.labelText_);
         this.setValue(param3);
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         addEventListener(MouseEvent.CLICK,this.onClick);
      }

      public function setValue(param1:*, param2:Boolean = true) : void {
         var _local3:int = 0;
         while(_local3 < this.values_.length) {
            if(param1 == this.values_[_local3]) {
               if(_local3 == this.selectedIndex_) {
                  return;
               }
               this.selectedIndex_ = _local3;
               break;
            }
            _local3++;
         }
         this.setSelected(this.selectedIndex_);
         if(param2) {
            dispatchEvent(new Event(Event.CHANGE));
         }
      }

      public function value() : * {
         return this.values_[this.selectedIndex_];
      }

      private function onMouseOver(param1:MouseEvent) : void {
         this.over_ = true;
         this.drawBackground();
      }

      private function onRollOut(param1:MouseEvent) : void {
         this.over_ = false;
         this.drawBackground();
      }

      private function onClick(param1:MouseEvent) : void {
         this.setSelected((this.selectedIndex_ + 1) % this.values_.length);
         dispatchEvent(new Event(Event.CHANGE));
      }

      private function drawBackground() : void {
         GraphicsUtil.clearPath(this.path_);
         GraphicsUtil.drawCutEdgeRect(0,0,WIDTH,HEIGHT,4,[1,1,1,1],this.path_);
         this.lineStyle_.fill = !!this.over_?this.overLineFill_:this.normalLineFill_;
         graphics.drawGraphicsData(this.graphicsData_);
         var _local1:Graphics = graphics;
         _local1.clear();
         _local1.drawGraphicsData(this.graphicsData_);
      }

      private function setSelected(param1:int) : void {
         this.selectedIndex_ = param1;
         if(this.selectedIndex_ < 0 || this.selectedIndex_ >= this.labels_.length) {
            this.selectedIndex_ = 0;
         }
         this.setText(this.labels_[this.selectedIndex_]);
      }

      private function setText(param1:StringBuilder) : void {
         this.labelText_.setStringBuilder(param1);
         this.drawBackground();
      }
   }
}
