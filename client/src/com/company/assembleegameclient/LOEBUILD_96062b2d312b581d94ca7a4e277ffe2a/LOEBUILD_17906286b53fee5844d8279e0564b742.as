package com.company.assembleegameclient.LOEBUILD_96062b2d312b581d94ca7a4e277ffe2a {
import com.company.assembleegameclient.account.ui.Frame;
import com.company.assembleegameclient.account.ui.LOEBUILD_b5d88c64baa451896772d5efdf29f2bf;

import flash.events.Event;
import flash.events.MouseEvent;

public class LOEBUILD_17906286b53fee5844d8279e0564b742 extends Frame {

      public var objectName_:LOEBUILD_b5d88c64baa451896772d5efdf29f2bf;

      public function LOEBUILD_17906286b53fee5844d8279e0564b742(param1:String) {
         super("Tile properties","Cancel","Save",null);
         this.objectName_ = new LOEBUILD_b5d88c64baa451896772d5efdf29f2bf("Object Name",false);
         if(param1 != null) {
            this.objectName_.inputText_.text = param1;
         }
         addTextInputField(this.objectName_);
         leftButton_.addEventListener(MouseEvent.CLICK,this.onCancel);
         rightButton_.addEventListener(MouseEvent.CLICK,this.onDone);
      }

      private function onCancel(param1:MouseEvent) : void {
         dispatchEvent(new Event(Event.CANCEL));
      }

      private function onDone(param1:MouseEvent) : void {
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}
