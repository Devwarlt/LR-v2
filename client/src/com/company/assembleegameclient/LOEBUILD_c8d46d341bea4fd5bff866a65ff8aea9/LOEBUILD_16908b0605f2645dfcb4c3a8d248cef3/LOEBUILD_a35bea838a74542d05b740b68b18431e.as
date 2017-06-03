package com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.LOEBUILD_16908b0605f2645dfcb4c3a8d248cef3 {
import kabam.rotmg.assets.model.Player;

import flash.display.BitmapData;
import flash.events.Event;

public class LOEBUILD_a35bea838a74542d05b740b68b18431e extends Event {

      public static const DEATH:String = "DEATH";

      public var background_:BitmapData;

      public var player_:Player;

      public var accountId_:int;

      public var charId_:int;

      public function LOEBUILD_a35bea838a74542d05b740b68b18431e(param1:BitmapData, param2:int, param3:int) {
         super(DEATH);
         this.background_ = param1;
         this.accountId_ = param2;
         this.charId_ = param3;
      }
   }
}
