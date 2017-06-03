package kabam.rotmg.ui.view.components.dropdown {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import kabam.rotmg.ui.view.SignalWaiter;

public class LocalizedDropDown extends Sprite {

      protected var strings_:Vector.<String>;

      protected var w_:int = 0;

      protected const h_:int = 36;

      protected var selected_:LocalizedDropDownItem;

      private var items_:Vector.<LocalizedDropDownItem>;

      private var all_:Sprite;

      private var waiter:SignalWaiter;

      public function LocalizedDropDown(param1:Vector.<String>) {
         this.items_ = new Vector.<LocalizedDropDownItem>();
         this.all_ = new Sprite();
         this.waiter = new SignalWaiter();
         super();
         this.strings_ = param1;
         this.makeDropDownItems();
         this.updateView();
         addChild(this.all_);
         this.all_.visible = false;
         this.waiter.complete.addOnce(this.onComplete);
      }

      public function getValue() : String {
         return this.selected_.getValue();
      }

      public function setValue(param1:String) : void {
         var _local3:String = null;
         var _local2:int = this.strings_.indexOf(param1);
         if(_local2 > 0) {
            _local3 = this.strings_[0];
            this.strings_[_local2] = _local3;
            this.strings_[0] = param1;
            this.updateView();
            dispatchEvent(new Event(Event.CHANGE));
         }
      }

      public function getClosedHeight() : int {
         return this.h_;
      }

      private function makeDropDownItems() : void {
         var _local1:LocalizedDropDownItem = null;
         if(this.strings_.length > 0) {
            _local1 = this.makeDropDownItem(this.strings_[0]);
            this.items_.push(_local1);
            this.selected_ = _local1;
            this.selected_.addEventListener(MouseEvent.CLICK,this.onClick);
            addChild(this.selected_);
         }
         var _local2:int = 1;
         while(_local2 < this.strings_.length) {
            _local1 = this.makeDropDownItem(this.strings_[_local2]);
            _local1.addEventListener(MouseEvent.CLICK,this.onSelect);
            _local1.y = this.h_ * _local2;
            this.items_.push(_local1);
            this.all_.addChild(_local1);
            _local2++;
         }
      }

      private function makeDropDownItem(param1:String) : LocalizedDropDownItem {
         var _local2:LocalizedDropDownItem = new LocalizedDropDownItem(param1,0,this.h_);
         this.waiter.push(_local2.getTextChanged());
         return _local2;
      }

      private function updateView() : void {
         var _local1:int = 0;
         while(_local1 < this.strings_.length) {
            this.items_[_local1].setValue(this.strings_[_local1]);
            this.items_[_local1].setWidth(this.w_);
            _local1++;
         }
         if(this.items_.length > 0) {
            this.selected_ = this.items_[0];
         }
      }

      private function showAll() : void {
         this.addEventListener(MouseEvent.ROLL_OUT,this.onOut);
         this.all_.visible = true;
      }

      private function hideAll() : void {
         this.removeEventListener(MouseEvent.ROLL_OUT,this.onOut);
         this.all_.visible = false;
      }

      private function onComplete() : void {
         var _local2:LocalizedDropDownItem = null;
         var _local1:int = 83;
         for each(_local2 in this.items_) {
            _local1 = Math.max(_local2.width,_local1);
         }
         this.w_ = _local1;
         this.updateView();
      }

      private function onClick(param1:MouseEvent) : void {
         param1.stopImmediatePropagation();
         this.selected_.removeEventListener(MouseEvent.CLICK,this.onClick);
         this.selected_.addEventListener(MouseEvent.CLICK,this.onSelect);
         this.showAll();
      }

      private function onSelect(param1:MouseEvent) : void {
         param1.stopImmediatePropagation();
         this.selected_.addEventListener(MouseEvent.CLICK,this.onClick);
         this.selected_.removeEventListener(MouseEvent.CLICK,this.onSelect);
         this.hideAll();
         var _local2:LocalizedDropDownItem = param1.target as LocalizedDropDownItem;
         this.setValue(_local2.getValue());
      }

      private function onOut(param1:MouseEvent) : void {
         this.selected_.addEventListener(MouseEvent.CLICK,this.onClick);
         this.selected_.removeEventListener(MouseEvent.CLICK,this.onSelect);
         this.hideAll();
      }
   }
}
