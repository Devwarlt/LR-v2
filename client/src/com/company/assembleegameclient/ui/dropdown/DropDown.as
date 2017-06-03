package com.company.assembleegameclient.ui.dropdown {
import com.company.ui.BaseSimpleText;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

public class DropDown extends Sprite {

      protected var strings_:Vector.<String>;

      protected var w_:int;

      protected var h_:int;

      protected var labelText_:BaseSimpleText;

      protected var xOffset_:int = 0;

      protected var selected_:DropDownItem;

      protected var all_:Sprite;

      public function DropDown(param1:Vector.<String>, param2:int, param3:int, param4:String = null) {
         this.all_ = new Sprite();
         super();
         this.strings_ = param1;
         this.w_ = param2;
         this.h_ = param3;
         if(param4 != null) {
            this.labelText_ = new BaseSimpleText(16,16777215,false,0,0);
            this.labelText_.setBold(true);
            this.labelText_.text = param4 + ":";
            this.labelText_.updateMetrics();
            addChild(this.labelText_);
            this.xOffset_ = this.labelText_.width + 5;
         }
         this.setIndex(0);
      }

      public function getValue() : String {
         return this.selected_.getValue();
      }

      public function setValue(param1:String) : void {
         var _local2:int = 0;
         while(_local2 < this.strings_.length) {
            if(param1 == this.strings_[_local2]) {
               this.setIndex(_local2);
               return;
            }
            _local2++;
         }
      }

      public function setIndex(param1:int) : void {
         this.setSelected(this.strings_[param1]);
      }

      public function getIndex() : int {
         var _local1:int = 0;
         while(_local1 < this.strings_.length) {
            if(this.selected_.getValue() == this.strings_[_local1]) {
               return _local1;
            }
            _local1++;
         }
         return -1;
      }

      private function setSelected(param1:String) : void {
         var _local2:String = null;
         _local2 = this.selected_ != null?this.selected_.getValue():null;
         this.selected_ = new DropDownItem(param1,this.w_,this.h_);
         this.selected_.x = this.xOffset_;
         this.selected_.y = 0;
         addChild(this.selected_);
         this.selected_.addEventListener(MouseEvent.CLICK,this.onClick);
         if(param1 != _local2) {
            dispatchEvent(new Event(Event.CHANGE));
         }
      }

      private function onClick(param1:MouseEvent) : void {
         param1.stopImmediatePropagation();
         this.selected_.removeEventListener(MouseEvent.CLICK,this.onClick);
         if(contains(this.selected_)) {
            removeChild(this.selected_);
         }
         this.showAll();
      }

      private function showAll() : void {
         var _local1:int = 0;
         var _local2:Point = null;
         var _local4:DropDownItem = null;
         _local1 = 0;
         _local2 = parent.localToGlobal(new Point(x,y));
         this.all_.x = _local2.x;
         this.all_.y = _local2.y;
         var _local3:int = 0;
         while(_local3 < this.strings_.length) {
            _local4 = new DropDownItem(this.strings_[_local3],this.w_,this.h_);
            _local4.addEventListener(MouseEvent.CLICK,this.onSelect);
            _local4.x = this.xOffset_;
            _local4.y = _local1;
            this.all_.addChild(_local4);
            _local1 = _local1 + _local4.h_;
            _local3++;
         }
         this.all_.addEventListener(MouseEvent.ROLL_OUT,this.onOut);
         stage.addChild(this.all_);
      }

      private function hideAll() : void {
         this.all_.removeEventListener(MouseEvent.ROLL_OUT,this.onOut);
         stage.removeChild(this.all_);
      }

      private function onSelect(param1:MouseEvent) : void {
         param1.stopImmediatePropagation();
         this.hideAll();
         var _local2:DropDownItem = param1.target as DropDownItem;
         this.setSelected(_local2.getValue());
      }

      private function onOut(param1:MouseEvent) : void {
         this.hideAll();
         this.setSelected(this.selected_.getValue());
      }
   }
}
