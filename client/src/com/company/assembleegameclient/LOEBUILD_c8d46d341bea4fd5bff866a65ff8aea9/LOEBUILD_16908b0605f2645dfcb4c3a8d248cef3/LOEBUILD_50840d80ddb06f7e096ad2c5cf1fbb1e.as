package com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.LOEBUILD_16908b0605f2645dfcb4c3a8d248cef3 {
import flash.events.Event;

public class LOEBUILD_50840d80ddb06f7e096ad2c5cf1fbb1e extends Event {

      public static const EVENT:String = "GUILDRESULTEVENT";

      public var success_:Boolean;

      public var errorKey:String;

      public var errorTokens:Object;

      public function LOEBUILD_50840d80ddb06f7e096ad2c5cf1fbb1e(param1:Boolean, param2:String, param3:Object) {
         super(EVENT);
         this.success_ = param1;
         this.errorKey = param2;
         this.errorTokens = param3;
      }
   }
}
