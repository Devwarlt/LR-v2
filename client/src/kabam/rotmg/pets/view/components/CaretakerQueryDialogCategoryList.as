package kabam.rotmg.pets.view.components {
import flash.display.DisplayObject;
import flash.events.MouseEvent;

import kabam.lib.ui.impl.LayoutList;
import kabam.lib.ui.impl.VerticalLayout;
import kabam.rotmg.ui.view.SignalWaiter;

import org.osflash.signals.Signal;

public class CaretakerQueryDialogCategoryList extends LayoutList {

      private const waiter:SignalWaiter = new SignalWaiter();

      public const ready:Signal = waiter.complete;

      public const selected:Signal = new Signal(String);

      public function CaretakerQueryDialogCategoryList(param1:Array) {
         super();
         setLayout(this.makeLayout());
         setItems(this.makeItems(param1));
         this.ready.addOnce(updateLayout);
      }

      private function makeLayout() : VerticalLayout {
         var _local1:VerticalLayout = new VerticalLayout();
         _local1.setPadding(2);
         return _local1;
      }

      private function makeItems(param1:Array) : Vector.<DisplayObject> {
         var _local2:Vector.<DisplayObject> = new Vector.<DisplayObject>();
         var _local3:int = 0;
         while(_local3 < param1.length) {
            _local2.push(this.makeItem(param1[_local3]));
            _local3++;
         }
         return _local2;
      }

      private function makeItem(param1:Object) : CaretakerQueryDialogCategoryItem {
         var _local2:CaretakerQueryDialogCategoryItem = new CaretakerQueryDialogCategoryItem(param1.category,param1.info);
         _local2.addEventListener(MouseEvent.CLICK,this.onClick);
         this.waiter.push(_local2.textChanged);
         return _local2;
      }

      private function onClick(param1:MouseEvent) : void {
         var _local2:CaretakerQueryDialogCategoryItem = param1.currentTarget as CaretakerQueryDialogCategoryItem;
         this.selected.dispatch(_local2.info);
      }
   }
}
