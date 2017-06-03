package com.junkbyte.console.core {
import com.junkbyte.console.Console;
import com.junkbyte.console.KeyBind;

import flash.events.KeyboardEvent;
import flash.text.TextField;
import flash.text.TextFieldType;

public class KeyBinder extends ConsoleCore {

      private var _passInd:int;

      private var _binds:Object;

      private var _warns:uint;

      public function KeyBinder(param1:Console) {
         this._binds = {};
         super(param1);
         param1.cl.addCLCmd("keybinds",this.printBinds,"List all keybinds used");
      }

      public function bindKey(param1:KeyBind, param2:Function, param3:Array = null) : void {
         if(Boolean(config.keystrokePassword) && (!param1.useKeyCode && param1.key.charAt(0) == config.keystrokePassword.charAt(0))) {
            report("Error: KeyBind [" + param1.key + "] is conflicting with Console password.",9);
            return;
         }
         if(param2 == null) {
            delete this._binds[param1.key];
         } else {
            this._binds[param1.key] = [param2,param3];
         }
      }

      public function keyDownHandler(param1:KeyboardEvent) : void {
         this.handleKeyEvent(param1,false);
      }

      public function keyUpHandler(param1:KeyboardEvent) : void {
         this.handleKeyEvent(param1,true);
      }

      private function handleKeyEvent(param1:KeyboardEvent, param2:Boolean) : void {
         var _local4:KeyBind = null;
         var _local3:String = String.fromCharCode(param1.charCode);
         if(Boolean(param2 && config.keystrokePassword != null) && Boolean(_local3) && _local3 == config.keystrokePassword.substring(this._passInd,this._passInd + 1)) {
            this._passInd++;
            if(this._passInd >= config.keystrokePassword.length) {
               this._passInd = 0;
               if(this.canTrigger()) {
                  if(Boolean(console.visible) && !console.panels.mainPanel.visible) {
                     console.panels.mainPanel.visible = true;
                  } else {
                     console.visible = !console.visible;
                  }
                  if(Boolean(console.visible) && Boolean(console.panels.mainPanel.visible)) {
                     console.panels.mainPanel.visible = true;
                     console.panels.mainPanel.moveBackSafePosition();
                  }
               } else if(this._warns < 3) {
                  this._warns++;
                  report("Password did not trigger because you have focus on an input TextField.",8);
               }
            }
         } else {
            if(param2) {
               this._passInd = 0;
            }
            _local4 = new KeyBind(param1.keyCode,param1.shiftKey,param1.ctrlKey,param1.altKey,param2);
            this.tryRunKey(_local4.key);
            if(_local3) {
               _local4 = new KeyBind(_local3,param1.shiftKey,param1.ctrlKey,param1.altKey,param2);
               this.tryRunKey(_local4.key);
            }
         }
      }

      private function printBinds(... rest) : void {
         var _local3:* = null;
         report("Key binds:",-2);
         var _local2:uint = 0;
         for(_local3 in this._binds) {
            _local2++;
            report(_local3,-2);
         }
         report("--- Found " + _local2,-2);
      }

      private function tryRunKey(param1:String) : void {
         var _local2:Array = this._binds[param1];
         if(Boolean(config.keyBindsEnabled) && Boolean(_local2)) {
            if(this.canTrigger()) {
               (_local2[0] as Function).apply(null,_local2[1]);
            } else if(this._warns < 3) {
               this._warns++;
               report("Key bind [" + param1 + "] did not trigger because you have focus on an input TextField.",8);
            }
         }
      }

      private function canTrigger() : Boolean {
         var _local1:TextField = null;
         try {
            if(Boolean(console.stage) && console.stage.focus is TextField) {
               _local1 = console.stage.focus as TextField;
               if(_local1.type == TextFieldType.INPUT) {
                  return false;
               }
            }
         }
         catch(err:Error) {
         }
         return true;
      }
   }
}
