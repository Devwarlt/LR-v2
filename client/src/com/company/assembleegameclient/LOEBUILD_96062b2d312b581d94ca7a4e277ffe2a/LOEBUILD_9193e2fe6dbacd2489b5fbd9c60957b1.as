package com.company.assembleegameclient.LOEBUILD_96062b2d312b581d94ca7a4e277ffe2a {
import com.company.util.IntPoint;

import flash.events.Event;

public class LOEBUILD_9193e2fe6dbacd2489b5fbd9c60957b1 extends Event {

      public static const TILES_EVENT:String = "TILES_EVENT";

      public var tiles_:Vector.<IntPoint>;

      function LOEBUILD_9193e2fe6dbacd2489b5fbd9c60957b1(param1:Vector.<IntPoint>) {
         super(TILES_EVENT);
         this.tiles_ = param1;
      }
   }
}
