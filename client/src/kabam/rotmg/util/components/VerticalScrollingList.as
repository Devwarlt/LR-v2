package kabam.rotmg.util.components {
import flash.display.DisplayObject;
import flash.display.Sprite;

import kabam.lib.ui.api.List;
import kabam.lib.ui.api.Size;
import kabam.lib.ui.impl.LayoutList;
import kabam.lib.ui.impl.VerticalLayout;

import org.osflash.signals.Signal;

public class VerticalScrollingList extends Sprite implements List {

      public static const SCROLLBAR_PADDING:int = 2;

      public static const SCROLLBAR_GUTTER:int = VerticalScrollbar.WIDTH + SCROLLBAR_PADDING;

      public const scrollStateChanged:Signal = new Signal(Boolean);

      private var layout:VerticalLayout;

      private var list:LayoutList;

      private var scrollbar:VerticalScrollbar;

      private var isEnabled:Boolean = true;

      private var size:Size;

      public function VerticalScrollingList() {
         super();
         this.makeLayout();
         this.makeVerticalList();
         this.makeScrollbar();
      }

      public function getIsEnabled() : Boolean {
         return this.isEnabled;
      }

      public function setIsEnabled(param1:Boolean) : void {
         this.isEnabled = param1;
         this.scrollbar.setIsEnabled(param1);
      }

      public function setSize(param1:Size) : void {
         this.size = param1;
         if(this.isScrollbarVisible()) {
            param1 = new Size(param1.width - SCROLLBAR_GUTTER,param1.height);
         }
         this.list.setSize(param1);
         this.refreshScrollbar();
      }

      public function getSize() : Size {
         return this.size;
      }

      public function setPadding(param1:int) : void {
         this.layout.setPadding(param1);
         this.list.updateLayout();
         this.refreshScrollbar();
      }

      public function addItem(param1:DisplayObject) : void {
         this.list.addItem(param1);
      }

      public function setItems(param1:Vector.<DisplayObject>) : void {
         this.list.setItems(param1);
      }

      public function getItemAt(param1:int) : DisplayObject {
         return this.list.getItemAt(param1);
      }

      public function getItemCount() : int {
         return this.list.getItemCount();
      }

      public function getListHeight() : int {
         return this.list.getSizeOfItems().height;
      }

      private function makeLayout() : void {
         this.layout = new VerticalLayout();
      }

      public function isScrollbarVisible() : Boolean {
         return this.scrollbar.visible;
      }

      private function makeVerticalList() : void {
         this.list = new LayoutList();
         this.list.itemsChanged.add(this.refreshScrollbar);
         this.list.setLayout(this.layout);
         addChild(this.list);
      }

      private function refreshScrollbar() : void {
         var _local3:int = 0;
         var _local5:* = false;
         var _local1:Size = this.list.getSize();
         var _local2:int = _local1.height;
         _local3 = this.list.getSizeOfItems().height;
         var _local4:* = _local3 > _local2;
         _local5 = this.scrollbar.visible != _local4;
         this.scrollbar.setIsEnabled(false);
         this.scrollbar.visible = _local4;
         _local4 && this.scrollbar.setIsEnabled(true);
         _local4 && this.updateScrollbarSize(_local2,_local3);
         _local5 && this.updateUiAndDispatchStateChange(_local4);
      }

      private function updateUiAndDispatchStateChange(param1:Boolean) : void {
         this.setSize(this.size);
         this.scrollStateChanged.dispatch(param1);
      }

      private function updateScrollbarSize(param1:int, param2:int) : void {
         var _local3:int = param1 * (param1 / param2);
         this.scrollbar.setSize(_local3,param1);
         this.scrollbar.x = this.list.getSize().width + SCROLLBAR_PADDING;
      }

      private function makeScrollbar() : void {
         this.scrollbar = new VerticalScrollbar();
         this.scrollbar.positionChanged.add(this.onPositionChanged);
         this.scrollbar.visible = false;
         addChild(this.scrollbar);
      }

      private function onPositionChanged(param1:Number) : void {
         var _local2:int = this.list.getSizeOfItems().height - this.list.getSize().height;
         this.list.setOffset(_local2 * param1);
      }
   }
}
