package com.google.analytics.debug {
import flash.events.TextEvent;

public class Alert extends Label {

      public var autoClose:Boolean = true;

      public var actionOnNextLine:Boolean = true;

      private var _actions:Array;

      public function Alert(param1:String, param2:Array, param3:String = "uiAlert", param4:uint = 0, param5:Align = null, param6:Boolean = false, param7:Boolean = true) {
         if(param4 == 0) {
            param4 = Style.alertColor;
         }
         if(param5 == null) {
            param5 = Align.center;
         }
         super(param1,param3,param4,param5,param6);
         this.selectable = true;
         super.mouseChildren = true;
         this.buttonMode = true;
         this.mouseEnabled = true;
         this.useHandCursor = true;
         this.actionOnNextLine = param7;
         _actions = [];
         var _local8:int = 0;
         while(_local8 < param2.length) {
            param2[_local8].container = this;
            _actions.push(param2[_local8]);
            _local8++;
         }
      }

      private function _defineActions() : void {
         var _local3:AlertAction = null;
         var _local1:* = "";
         if(actionOnNextLine) {
            _local1 = _local1 + "\n";
         } else {
            _local1 = _local1 + " |";
         }
         _local1 = _local1 + " ";
         var _local2:Array = [];
         var _local4:int = 0;
         while(_local4 < _actions.length) {
            _local3 = _actions[_local4];
            _local2.push("<a href=\"event:" + _local3.activator + "\">" + _local3.name + "</a>");
            _local4++;
         }
         _local1 = _local1 + _local2.join(" | ");
         appendText(_local1,"uiAlertAction");
      }

      protected function isValidAction(param1:String) : Boolean {
         var _local2:int = 0;
         while(_local2 < _actions.length) {
            if(param1 == _actions[_local2].activator) {
               return true;
            }
            _local2++;
         }
         return false;
      }

      override protected function layout() : void {
         super.layout();
         _defineActions();
      }

      protected function getAction(param1:String) : AlertAction {
         var _local2:int = 0;
         while(_local2 < _actions.length) {
            if(param1 == _actions[_local2].activator) {
               return _actions[_local2];
            }
            _local2++;
         }
         return null;
      }

      protected function spaces(param1:int) : String {
         var _local2:String = "";
         var _local3:String = "          ";
         var _local4:int = 0;
         while(_local4 < param1 + 1) {
            _local2 = _local2 + _local3;
            _local4++;
         }
         return _local2;
      }

      override public function onLink(param1:TextEvent) : void {
         var _local2:AlertAction = null;
         if(isValidAction(param1.text)) {
            _local2 = getAction(param1.text);
            if(_local2) {
               _local2.execute();
            }
         }
         if(autoClose) {
            close();
         }
      }

      public function close() : void {
         if(parent != null) {
            parent.removeChild(this);
         }
      }
   }
}
