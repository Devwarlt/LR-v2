package com.company.assembleegameclient.account.ui.LOEBUILD_4725dcf446a342f1473a8228e42dfa48 {
import flash.display.Shape;

public class LOEBUILD_b55e81101a46cbe032ef8003583f7008 extends Shape {

      private var _width:int;

      private var _height:int;

      private var _color:int;

      public function LOEBUILD_b55e81101a46cbe032ef8003583f7008() {
         super();
      }

      public function setSize(param1:int, param2:int) : void {
         this._width = param1;
         this._height = param2;
         this.drawFill();
      }

      public function setColor(param1:int) : void {
         this._color = param1;
         this.drawFill();
      }

      private function drawFill() : void {
         graphics.clear();
         graphics.beginFill(this._color);
         graphics.drawRect(0,0,this._width,this._height);
         graphics.endFill();
      }
   }
}
