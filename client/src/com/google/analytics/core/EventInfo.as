package com.google.analytics.core {
import com.google.analytics.data.X10;
import com.google.analytics.utils.Variables;

public class EventInfo {

      private var _ext10:X10;

      private var _isEventHit:Boolean;

      private var _x10:X10;

      public function EventInfo(param1:Boolean, param2:X10, param3:X10 = null) {
         super();
         _isEventHit = param1;
         _x10 = param2;
         _ext10 = param3;
      }

      public function toURLString() : String {
         var _local1:Variables = toVariables();
         return _local1.toString();
      }

      public function get utmt() : String {
         return "event";
      }

      public function get utme() : String {
         return _x10.renderMergedUrlString(_ext10);
      }

      public function toVariables() : Variables {
         var _local1:Variables = new Variables();
         _local1.URIencode = true;
         if(_isEventHit) {
            _local1.utmt = utmt;
         }
         _local1.utme = utme;
         return _local1;
      }
   }
}
