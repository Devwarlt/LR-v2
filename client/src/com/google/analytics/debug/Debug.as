package com.google.analytics.debug {
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

public class Debug extends Label {

      public static var count:uint;

      private var _lines:Array;

      private var _preferredForcedWidth:uint = 540;

      private var _linediff:int = 0;

      public var maxLines:uint = 16;

      public function Debug(param1:uint = 0, param2:Align = null, param3:Boolean = false) {
         if(param2 == null) {
            param2 = Align.bottom;
         }
         super("","uiLabel",param1,param2,param3);
         this.name = "Debug" + count++;
         _lines = [];
         selectable = true;
         addEventListener(KeyboardEvent.KEY_DOWN,onKey);
      }

      public function writeBold(param1:String) : void {
         write(param1,true);
      }

      private function _getLinesToDisplay(param1:int = 0) : Array {
         var _local2:Array = null;
         var _local3:uint = 0;
         var _local4:uint = 0;
         if(_lines.length - 1 > maxLines) {
            if(_linediff <= 0) {
               _linediff = _linediff + param1;
            } else if(_linediff > 0 && param1 < 0) {
               _linediff = _linediff + param1;
            }
            _local3 = _lines.length - maxLines + _linediff;
            _local4 = _local3 + maxLines;
            _local2 = _lines.slice(_local3,_local4);
         } else {
            _local2 = _lines;
         }
         return _local2;
      }

      private function onKey(param1:KeyboardEvent = null) : void {
         var _local2:Array = null;
         switch(param1.keyCode) {
            case Keyboard.DOWN:
               _local2 = _getLinesToDisplay(1);
               break;
            case Keyboard.UP:
               _local2 = _getLinesToDisplay(-1);
               break;
            default:
               _local2 = null;
         }
         if(_local2 == null) {
            return;
         }
         text = _local2.join("\n");
      }

      override public function get forcedWidth() : uint {
         if(this.parent) {
            if(UISprite(this.parent).forcedWidth > _preferredForcedWidth) {
               return _preferredForcedWidth;
            }
            return UISprite(this.parent).forcedWidth;
         }
         return super.forcedWidth;
      }

      public function write(param1:String, param2:Boolean = false) : void {
         var _local3:Array = null;
         if(param1.indexOf("") > -1) {
            _local3 = param1.split("\n");
         } else {
            _local3 = [param1];
         }
         var _local4:String = "";
         var _local5:String = "";
         if(param2) {
            _local4 = "<b>";
            _local5 = "</b>";
         }
         var _local6:int = 0;
         while(_local6 < _local3.length) {
            _lines.push(_local4 + _local3[_local6] + _local5);
            _local6++;
         }
         var _local7:Array = _getLinesToDisplay();
         text = _local7.join("\n");
      }

      public function close() : void {
         dispose();
      }

      override protected function dispose() : void {
         removeEventListener(KeyboardEvent.KEY_DOWN,onKey);
         super.dispose();
      }
   }
}
