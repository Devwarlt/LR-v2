package com.junkbyte.console.view {
import com.junkbyte.console.Console;
import com.junkbyte.console.KeyBind;
import com.junkbyte.console.core.LogReferences;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Stage;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.TextEvent;
import flash.geom.Point;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.utils.Dictionary;

public class RollerPanel extends ConsolePanel {

      public static const NAME:String = "rollerPanel";

      private var _settingKey:Boolean;

      public function RollerPanel(param1:Console) {
         super(param1);
         name = NAME;
         init(60,100,false);
         txtField = makeTF("rollerPrints");
         txtField.multiline = true;
         txtField.autoSize = TextFieldAutoSize.LEFT;
         registerTFRoller(txtField,this.onMenuRollOver,this.linkHandler);
         registerDragger(txtField);
         addChild(txtField);
         addEventListener(Event.ENTER_FRAME,this._onFrame);
         addEventListener(Event.REMOVED_FROM_STAGE,this.removeListeners);
      }

      private function removeListeners(param1:Event = null) : void {
         removeEventListener(Event.ENTER_FRAME,this._onFrame);
         removeEventListener(Event.REMOVED_FROM_STAGE,this.removeListeners);
         if(stage) {
            stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
         }
      }

      private function _onFrame(param1:Event) : void {
         if(!console.stage) {
            this.close();
            return;
         }
         if(this._settingKey) {
            txtField.htmlText = "<high><menu>Press a key to set [ <a href=\"event:cancel\"><b>cancel</b></a> ]</menu></high>";
         } else {
            txtField.htmlText = "<low>" + this.getMapString(false) + "</low>";
            txtField.autoSize = TextFieldAutoSize.LEFT;
            txtField.setSelection(0,0);
         }
         width = txtField.width + 4;
         height = txtField.height;
      }

      public function getMapString(param1:Boolean) : String {
         var _local7:DisplayObject = null;
         var _local8:String = null;
         var _local9:Array = null;
         var _local10:DisplayObjectContainer = null;
         var _local11:uint = 0;
         var _local12:uint = 0;
         var _local13:DisplayObject = null;
         var _local14:uint = 0;
         var _local15:* = null;
         var _local16:uint = 0;
         var _local2:Stage = console.stage;
         var _local3:* = "";
         if(!param1) {
            _local8 = !!console.rollerCaptureKey?console.rollerCaptureKey.key:"unassigned";
            _local3 = "<menu> <a href=\"event:close\"><b>X</b></a></menu> Capture key: <menu><a href=\"event:capture\">" + _local8 + "</a></menu><br/>";
         }
         var _local4:Point = new Point(_local2.mouseX,_local2.mouseY);
         if(_local2.areInaccessibleObjectsUnderPoint(_local4)) {
            _local3 = _local3 + "<p9>Inaccessible LOEBUILD_5891da2d64975cae48d175d1e001f5da detected</p9><br/>";
         }
         var _local5:Array = _local2.getObjectsUnderPoint(_local4);
         var _local6:Dictionary = new Dictionary(true);
         if(_local5.length == 0) {
            _local5.push(_local2);
         }
         for each(_local7 in _local5) {
            _local9 = new Array(_local7);
            _local10 = _local7.parent;
            while(_local10) {
               _local9.unshift(_local10);
               _local10 = _local10.parent;
            }
            _local11 = _local9.length;
            _local12 = 0;
            while(_local12 < _local11) {
               _local13 = _local9[_local12];
               if(_local6[_local13] == undefined) {
                  _local6[_local13] = _local12;
                  _local14 = _local12;
                  while(_local14 > 0) {
                     _local3 = _local3 + (_local14 == 1?" ∟":" -");
                     _local14--;
                  }
                  _local15 = _local13.name;
                  if(Boolean(param1) && Boolean(console.config.useObjectLinking)) {
                     _local16 = console.refs.setLogRef(_local13);
                     _local15 = "<a href=\'event:cl_" + _local16 + "\'>" + _local15 + "</a> " + console.refs.makeRefTyped(_local13);
                  } else {
                     _local15 = _local15 + " (" + LogReferences.ShortClassName(_local13) + ")";
                  }
                  if(_local13 == _local2) {
                     _local16 = console.refs.setLogRef(_local2);
                     if(_local16) {
                        _local3 = _local3 + ("<p3><a href=\'event:cl_" + _local16 + "\'><i>Stage</i></a> ");
                     } else {
                        _local3 = _local3 + "<p3><i>Stage</i> ";
                     }
                     _local3 = _local3 + ("[" + _local2.mouseX + "," + _local2.mouseY + "]</p3><br/>");
                  } else if(_local12 == _local11 - 1) {
                     _local3 = _local3 + ("<p5>" + _local15 + "</p5><br/>");
                  } else {
                     _local3 = _local3 + ("<p2><i>" + _local15 + "</i></p2><br/>");
                  }
               }
               _local12++;
            }
         }
         return _local3;
      }

      override public function close() : void {
         this.cancelCaptureKeySet();
         this.removeListeners();
         super.close();
         console.panels.updateMenu();
      }

      private function onMenuRollOver(param1:TextEvent) : void {
         var _local3:KeyBind = null;
         var _local2:String = !!param1.text?param1.text.replace("event:",""):"";
         if(_local2 == "close") {
            _local2 = "Close";
         } else if(_local2 == "capture") {
            _local3 = console.rollerCaptureKey;
            if(_local3) {
               _local2 = "Unassign key ::" + _local3.key;
            } else {
               _local2 = "Assign key";
            }
         } else if(_local2 == "cancel") {
            _local2 = "Cancel assign key";
         } else {
            _local2 = null;
         }
         console.panels.tooltip(_local2,this);
      }

      protected function linkHandler(param1:TextEvent) : void {
         TextField(param1.currentTarget).setSelection(0,0);
         if(param1.text == "close") {
            this.close();
         } else if(param1.text == "capture") {
            if(console.rollerCaptureKey) {
               console.setRollerCaptureKey(null);
            } else {
               this._settingKey = true;
               stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler,false,0,true);
            }
            console.panels.tooltip(null);
         } else if(param1.text == "cancel") {
            this.cancelCaptureKeySet();
            console.panels.tooltip(null);
         }
         param1.stopPropagation();
      }

      private function cancelCaptureKeySet() : void {
         this._settingKey = false;
         if(stage) {
            stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
         }
      }

      private function keyDownHandler(param1:KeyboardEvent) : void {
         if(!param1.charCode) {
            return;
         }
         var _local2:String = String.fromCharCode(param1.charCode);
         this.cancelCaptureKeySet();
         console.setRollerCaptureKey(_local2,param1.shiftKey,param1.ctrlKey,param1.altKey);
         console.panels.tooltip(null);
      }
   }
}
