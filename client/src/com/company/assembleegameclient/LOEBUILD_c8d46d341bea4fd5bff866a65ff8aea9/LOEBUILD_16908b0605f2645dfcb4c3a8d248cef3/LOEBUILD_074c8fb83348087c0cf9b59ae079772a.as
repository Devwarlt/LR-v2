package com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.LOEBUILD_16908b0605f2645dfcb4c3a8d248cef3 {
import flash.events.Event;

import kabam.rotmg.messaging.impl.incoming.NameResult;

public class LOEBUILD_074c8fb83348087c0cf9b59ae079772a extends Event {

      public static const NAMERESULTEVENT:String = "NAMERESULTEVENT";

      public var m_:NameResult;

      public function LOEBUILD_074c8fb83348087c0cf9b59ae079772a(param1:NameResult) {
         super(NAMERESULTEVENT);
         this.m_ = param1;
      }
   }
}
