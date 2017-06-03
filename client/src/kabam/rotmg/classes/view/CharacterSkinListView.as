package kabam.rotmg.classes.view {
import flash.display.DisplayObject;
import flash.display.Sprite;

import kabam.lib.ui.api.Size;
import kabam.rotmg.util.components.VerticalScrollingList;

public class CharacterSkinListView extends Sprite {

      public static const PADDING:int = 5;

      public static const WIDTH:int = 442;

      public static const HEIGHT:int = 400;

      private const list:VerticalScrollingList = makeList();

      private var items:Vector.<DisplayObject>;

      public function CharacterSkinListView() {
         super();
      }

      private function makeList() : VerticalScrollingList {
         var _local1:VerticalScrollingList = new VerticalScrollingList();
         _local1.setSize(new Size(WIDTH,HEIGHT));
         _local1.scrollStateChanged.add(this.onScrollStateChanged);
         _local1.setPadding(PADDING);
         addChild(_local1);
         return _local1;
      }

      public function setItems(param1:Vector.<DisplayObject>) : void {
         this.items = param1;
         this.list.setItems(param1);
         this.onScrollStateChanged(this.list.isScrollbarVisible());
      }

      private function onScrollStateChanged(param1:Boolean) : void {
         var _local3:CharacterSkinListItem = null;
         var _local2:int = CharacterSkinListItem.WIDTH;
         if(!param1) {
            _local2 = _local2 + VerticalScrollingList.SCROLLBAR_GUTTER;
         }
         for each(_local3 in this.items) {
            _local3.setWidth(_local2);
         }
      }

      public function getListHeight() : Number {
         return this.list.getListHeight();
      }
   }
}
