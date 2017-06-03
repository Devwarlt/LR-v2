package com.company.assembleegameclient.ui {
import com.company.util.GraphicsUtil;

import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.display.Sprite;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;

public class BackgroundFilledText extends Sprite {

      protected static const MARGIN:int = 4;

      public var bWidth:int = 0;

      protected var text_:TextFieldDisplayConcrete;

      protected var w_:int;

      protected var enabledFill_:GraphicsSolidFill;

      protected var disabledFill_:GraphicsSolidFill;

      protected var path_:GraphicsPath;

      protected var graphicsData_:Vector.<IGraphicsData>;

      public function BackgroundFilledText(param1:int) {
         this.enabledFill_ = new GraphicsSolidFill(16777215,1);
         this.disabledFill_ = new GraphicsSolidFill(8355711,1);
         this.path_ = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
         this.graphicsData_ = new <IGraphicsData>[enabledFill_,path_,GraphicsUtil.END_FILL];
         super();
         this.bWidth = param1;
      }

      protected function centerTextAndDrawButton() : void {
         this.w_ = this.bWidth != 0?int(this.bWidth):int(this.text_.width + 12);
         this.text_.x = this.w_ / 2;
         GraphicsUtil.clearPath(this.path_);
         GraphicsUtil.drawCutEdgeRect(0,0,this.w_,this.text_.height + MARGIN * 2,4,[1,1,1,1],this.path_);
      }

      public function addText(param1:int) : void {
         this.text_ = this.makeText().setSize(param1).setColor(3552822);
         this.text_.setBold(true);
         this.text_.setAutoSize(TextFieldAutoSize.CENTER);
         this.text_.y = MARGIN;
         addChild(this.text_);
      }

      protected function makeText() : TextFieldDisplayConcrete {
         return new TextFieldDisplayConcrete();
      }
   }
}
