package com.company.assembleegameclient.account.ui {
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.LOEBUILD_6615c4f9bea4fdaf620bf1ad513a54c1;

import flash.events.MouseEvent;

import kabam.rotmg.text.model.TextKey;

import org.osflash.signals.Signal;

public class LOEBUILD_74a13e89b510f04db8bb32dcec0faa62 extends Frame {

      public const cancel:Signal = new Signal();

      public const choose:Signal = new Signal(String);

      public var gameSprite:LOEBUILD_6615c4f9bea4fdaf620bf1ad513a54c1;

      public var isPurchase:Boolean;

      private var nameInput:LOEBUILD_b5d88c64baa451896772d5efdf29f2bf;

      public function LOEBUILD_74a13e89b510f04db8bb32dcec0faa62(param1:LOEBUILD_6615c4f9bea4fdaf620bf1ad513a54c1, param2:Boolean) {
         super(TextKey.CHOOSE_NAME_TITLE,TextKey.FRAME_CANCEL,TextKey.CHOOSE_NAME_CHOOSE,"/chooseName");
         this.gameSprite = param1;
         this.isPurchase = param2;
         this.nameInput = new LOEBUILD_b5d88c64baa451896772d5efdf29f2bf(TextKey.CHOOSE_NAME_NAME,false);
         this.nameInput.inputText_.restrict = "A-Za-z";
         var _local3:int = 10;
         this.nameInput.inputText_.maxChars = _local3;
         addTextInputField(this.nameInput);
         addPlainText(TextKey.FRAME_MAX_CHAR,{"maxChars":_local3});
         addPlainText(TextKey.FRAME_RESTRICT_CHAR);
         addPlainText(TextKey.CHOOSE_NAME_WARNING);
         leftButton_.addEventListener(MouseEvent.CLICK,this.onCancel);
         rightButton_.addEventListener(MouseEvent.CLICK,this.onChoose);
      }

      private function onCancel(param1:MouseEvent) : void {
         this.cancel.dispatch();
      }

      private function onChoose(param1:MouseEvent) : void {
         this.choose.dispatch(this.nameInput.text());
         disable();
      }

      public function setError(param1:String) : void {
         this.nameInput.setError(param1);
      }
   }
}
