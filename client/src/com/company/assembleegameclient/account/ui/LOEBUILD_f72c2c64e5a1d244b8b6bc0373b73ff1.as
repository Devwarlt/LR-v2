package com.company.assembleegameclient.account.ui {
import com.company.assembleegameclient.account.ui.LOEBUILD_4725dcf446a342f1473a8228e42dfa48.LOEBUILD_8318ce1c96df6ce21eb2ed428c6d0f85;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.util.components.RadioButton;

import org.osflash.signals.Signal;

public class LOEBUILD_f72c2c64e5a1d244b8b6bc0373b73ff1 extends Sprite implements LOEBUILD_8318ce1c96df6ce21eb2ed428c6d0f85 {

      public static const HEIGHT:int = 28;

      private var label:String;

      private var text:TextFieldDisplayConcrete;

      private var button:RadioButton;

      public const textSet:Signal = new Signal();

      public function LOEBUILD_f72c2c64e5a1d244b8b6bc0373b73ff1(param1:String) {
         super();
         this.label = param1;
         this.makeRadioButton();
         this.makeLabelText();
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         this.text.textChanged.add(this.onTextChanged);
      }

      private function onTextChanged() : void {
         this.text.y = this.button.height / 2 - this.text.height / 2;
         this.textSet.dispatch();
      }

      public function getValue() : String {
         return this.label;
      }

      private function makeRadioButton() : void {
         this.button = new RadioButton();
         addChild(this.button);
      }

      private function makeLabelText() : void {
         this.text = new TextFieldDisplayConcrete().setSize(18).setColor(16777215).setBold(true);
         this.text.setStringBuilder(new LineBuilder().setParams(this.label));
         this.text.filters = [new DropShadowFilter(0,0,0)];
         this.text.x = HEIGHT + 8;
         addChild(this.text);
      }

      public function setSelected(param1:Boolean) : void {
         this.button.setSelected(param1);
      }

      private function onMouseOver(param1:MouseEvent) : void {
         this.text.setColor(16768133);
      }

      private function onRollOut(param1:MouseEvent) : void {
         this.text.setColor(16777215);
      }
   }
}
