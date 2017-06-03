package kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_1bda80f2be4d3658e0baa43fbe7ae8c1 {
import flash.events.KeyboardEvent;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.ui.Keyboard;

import kabam.lib.resizing.view.Resizable;
import kabam.lib.util.StageLifecycleUtil;

public final class LOEBUILD_9a1afe308cb8a3976519f048fad72e19 extends TextField implements Resizable {

      public static const HEIGHT:int = 20;

      private var lifecycle:StageLifecycleUtil;

      public function LOEBUILD_9a1afe308cb8a3976519f048fad72e19() {
         super();
         background = true;
         backgroundColor = 13056;
         border = true;
         borderColor = 3355443;
         defaultTextFormat = new TextFormat("_sans",14,16777215,true);
         text = "";
         type = TextFieldType.INPUT;
         restrict = "^`";
         this.lifecycle = new StageLifecycleUtil(this);
         this.lifecycle.addedToStage.add(this.onAddedToStage);
         this.lifecycle.removedFromStage.add(this.onRemovedFromStage);
      }

      private function onAddedToStage() : void {
         addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }

      private function onRemovedFromStage() : void {
         removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }

      private function onKeyDown(param1:KeyboardEvent) : void {
         var _local2:String = text;
         switch(param1.keyCode) {
            case Keyboard.ENTER:
               text = "";
               dispatchEvent(new ConsoleEvent(ConsoleEvent.INPUT,_local2));
               break;
            case Keyboard.UP:
               dispatchEvent(new ConsoleEvent(ConsoleEvent.GET_PREVIOUS));
               break;
            case Keyboard.DOWN:
               dispatchEvent(new ConsoleEvent(ConsoleEvent.GET_NEXT));
         }
      }

      public function resize(param1:Rectangle) : void {
         var _local2:int = param1.height * 0.5;
         if(_local2 > HEIGHT) {
            _local2 = HEIGHT;
         }
         width = param1.width;
         height = _local2;
         x = param1.x;
         y = param1.bottom - height;
      }
   }
}
