package com.company.assembleegameclient.ui.options {
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;

import flash.events.Event;

import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class ChoiceOption extends BaseOption {

      private var callback_:Function;

      private var choiceBox_:ChoiceBox;

      public function ChoiceOption(param1:String, param2:Vector.<StringBuilder>, param3:Array, param4:String, param5:String, param6:Function, param7:Number = 16777215) {
         super(param1,param4,param5);
         desc_.setColor(param7);
         tooltip_.tipText_.setColor(param7);
         this.callback_ = param6;
         this.choiceBox_ = new ChoiceBox(param2,param3,LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_[paramName_],param7);
         this.choiceBox_.addEventListener(Event.CHANGE,this.onChange);
         addChild(this.choiceBox_);
      }

      override public function refresh() : void {
         this.choiceBox_.setValue(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_[paramName_]);
      }

      public function refreshNoCallback() : void {
         this.choiceBox_.setValue(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_[paramName_],false);
      }

      private function onChange(param1:Event) : void {
         LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_[paramName_] = this.choiceBox_.value();
         if(this.callback_ != null) {
            this.callback_();
         }
         LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.save();
      }
   }
}
