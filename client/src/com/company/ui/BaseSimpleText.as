package com.company.ui {
import flash.events.Event;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.text.TextLineMetrics;

public class BaseSimpleText extends TextField {

      public static const MyriadPro:Class = BaseSimpleText_MyriadPro;

      public var inputWidth_:int;

      public var inputHeight_:int;

      public var actualWidth_:int;

      public var actualHeight_:int;

      public function BaseSimpleText(param1:int, param2:uint, param3:Boolean = false, param4:int = 0, param5:int = 0) {
         super();
         this.inputWidth_ = param4;
         if(this.inputWidth_ != 0) {
            width = param4;
         }
         this.inputHeight_ = param5;
         if(this.inputHeight_ != 0) {
            height = param5;
         }
         Font.registerFont(MyriadPro);
         var _local6:Font = new MyriadPro();
         var _local7:TextFormat = this.defaultTextFormat;
         _local7.font = _local6.fontName;
         _local7.bold = false;
         _local7.size = param1;
         _local7.color = param2;
         defaultTextFormat = _local7;
         if(param3) {
            selectable = true;
            mouseEnabled = true;
            type = TextFieldType.INPUT;
            border = true;
            borderColor = param2;
            addEventListener(Event.CHANGE,this.onChange);
         } else {
            selectable = false;
            mouseEnabled = false;
         }
      }

      public function setFont(param1:String) : void {
         var _local2:TextFormat = defaultTextFormat;
         _local2.font = param1;
         defaultTextFormat = _local2;
      }

      public function setSize(param1:int) : void {
         var _local2:TextFormat = defaultTextFormat;
         _local2.size = param1;
         this.applyFormat(_local2);
      }

      public function setColor(param1:uint) : void {
         var _local2:TextFormat = defaultTextFormat;
         _local2.color = param1;
         this.applyFormat(_local2);
      }

      public function setBold(param1:Boolean) : void {
         var _local2:TextFormat = defaultTextFormat;
         _local2.bold = param1;
         this.applyFormat(_local2);
      }

      public function setAlignment(param1:String) : void {
         var _local2:TextFormat = defaultTextFormat;
         _local2.align = param1;
         this.applyFormat(_local2);
      }

      public function setText(param1:String) : void {
         this.text = param1;
      }

      private function applyFormat(param1:TextFormat) : void {
         setTextFormat(param1);
         defaultTextFormat = param1;
      }

      private function onChange(param1:Event) : void {
         this.updateMetrics();
      }

      public function updateMetrics() : void {
         var _local2:TextLineMetrics = null;
         var _local3:int = 0;
         var _local4:int = 0;
         this.actualWidth_ = 0;
         this.actualHeight_ = 0;
         var _local1:int = 0;
         while(_local1 < numLines) {
            _local2 = getLineMetrics(_local1);
            _local3 = _local2.width + 4;
            _local4 = _local2.height + 4;
            if(_local3 > this.actualWidth_) {
               this.actualWidth_ = _local3;
            }
            this.actualHeight_ = this.actualHeight_ + _local4;
            _local1++;
         }
         width = this.inputWidth_ == 0?Number(this.actualWidth_):Number(this.inputWidth_);
         height = this.inputHeight_ == 0?Number(this.actualHeight_):Number(this.inputHeight_);
      }

      public function useTextDimensions() : void {
         width = this.inputWidth_ == 0?Number(textWidth + 4):Number(this.inputWidth_);
         height = this.inputHeight_ == 0?Number(textHeight + 4):Number(this.inputHeight_);
      }
   }
}
