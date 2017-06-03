package kabam.rotmg.pets.view.dialogs {
import flash.display.DisplayObject;
import flash.display.Sprite;

import kabam.lib.ui.api.Size;
import kabam.rotmg.util.components.VerticalScrollingList;

public class GridList extends Sprite {

      public var list:VerticalScrollingList;

      private var size:Size;

      private var row:Sprite;

      private var rows:Vector.<DisplayObject>;

      private var items:Array;

      private var lastItemRight:int;

      private var padding:int;

      private var grid:Array;

      private var maxItemsPerRow:int;

      public function GridList() {
         this.list = new VerticalScrollingList();
         super();
      }

      public function setSize(param1:Size) : void {
         this.size = param1;
         this.list.setSize(param1);
         addChild(this.list);
      }

      public function setPadding(param1:int) : void {
         this.padding = param1;
         this.list.setPadding(param1);
      }

      public function setItems(param1:Vector.<PetItem>) : void {
         var _local2:DisplayObject = null;
         this.makeNewList();
         for each(_local2 in param1) {
            this.addItem(_local2);
         }
         this.list.setItems(this.rows);
         if(!param1.length) {
            return;
         }
         var _local3:DisplayObject = param1[0];
         this.maxItemsPerRow = this.maxRowWidth() / _local3.width;
      }

      public function getSize() : Size {
         return this.size;
      }

      public function getItems() : Array {
         return this.items;
      }

      public function getItem(param1:int) : DisplayObject {
         return this.items[param1];
      }

      private function makeNewList() : void {
         this.grid = [];
         this.items = [];
         this.rows = new Vector.<DisplayObject>();
         this.lastItemRight = 0;
         this.addRow();
      }

      private function addItem(param1:DisplayObject) : void {
         this.position(param1);
         this.row.addChild(param1);
         this.items.push(param1);
         this.grid[this.grid.length - 1].push(param1);
      }

      private function position(param1:DisplayObject) : void {
         if(this.exceedsWidthFor(param1)) {
            param1.x = 0;
            this.addRow();
         } else {
            this.positionRightOfPrevious(param1);
         }
         this.lastItemRight = param1.x + param1.width;
         this.lastItemRight = this.lastItemRight + this.padding;
      }

      private function addRow() : void {
         this.row = new Sprite();
         this.rows.push(this.row);
         this.grid.push([]);
      }

      private function positionRightOfPrevious(param1:DisplayObject) : void {
         param1.x = this.lastItemRight;
      }

      private function exceedsWidthFor(param1:DisplayObject) : Boolean {
         return this.lastItemRight + param1.width > this.maxRowWidth();
      }

      private function maxRowWidth() : int {
         return this.size.width - VerticalScrollingList.SCROLLBAR_GUTTER;
      }

      public function getTopLeft() : DisplayObject {
         if(this.items.length) {
            return this.items[0];
         }
         return null;
      }

      public function getTopRight() : DisplayObject {
         var _local1:Array = null;
         if(this.grid.length) {
            _local1 = this.grid[0];
            return _local1[this.maxItemsPerRow - 1];
         }
         return null;
      }

      public function getBottomLeft() : DisplayObject {
         var _local1:Array = null;
         if(this.grid.length >= 2) {
            _local1 = this.grid[this.grid.length - 1];
            return _local1[0];
         }
         return null;
      }

      public function getBottomRight() : DisplayObject {
         var _local1:Array = null;
         if(this.grid.length >= 2) {
            _local1 = this.grid[this.grid.length - 1];
            return _local1[this.maxItemsPerRow - 1];
         }
         return null;
      }
   }
}
