package com.company.assembleegameclient.ui.dialogs {
import flash.events.Event;

import org.osflash.signals.Signal;

public class CloseDialogComponent {

      private const closeSignal:Signal = new Signal();

      private var dialog:DialogCloser;

      private var types:Vector.<String>;

      public function CloseDialogComponent() {
         this.types = new Vector.<String>();
         super();
      }

      public function add(param1:DialogCloser, param2:String) : void {
         this.dialog = param1;
         this.types.push(param2);
         param1.addEventListener(param2,this.onButtonType);
      }

      private function onButtonType(param1:Event) : void {
         var _local2:String = null;
         for each(_local2 in this.types) {
            this.dialog.removeEventListener(_local2,this.onButtonType);
         }
         this.dialog.getCloseSignal().dispatch();
      }

      public function getCloseSignal() : Signal {
         return this.closeSignal;
      }
   }
}
