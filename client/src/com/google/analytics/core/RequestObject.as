package com.google.analytics.core {
import flash.net.URLRequest;
import flash.utils.getTimer;

public class RequestObject {

      public var start:int;

      public var end:int;

      public var request:URLRequest;

      public function RequestObject(param1:URLRequest) {
         super();
         start = getTimer();
         this.request = param1;
      }

      public function hasCompleted() : Boolean {
         return end > 0;
      }

      public function toString() : String {
         var _local1:Array = [];
         _local1.push("duration: " + duration + "ms");
         _local1.push("url: " + request.url);
         return "{ " + _local1.join(", ") + " }";
      }

      public function complete() : void {
         end = getTimer();
      }

      public function get duration() : int {
         if(!hasCompleted()) {
            return 0;
         }
         return end - start;
      }
   }
}
