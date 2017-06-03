package com.google.analytics.utils {
import flash.net.URLVariables;

public dynamic class Variables {

      public var post:Array;

      public var URIencode:Boolean;

      public var pre:Array;

      public var sort:Boolean = true;

      public function Variables(param1:String = null, param2:Array = null, param3:Array = null) {
         pre = [];
         post = [];
         super();
         if(param1) {
            decode(param1);
         }
         if(param2) {
            this.pre = param2;
         }
         if(param3) {
            this.post = param3;
         }
      }

      private function _join(param1:Variables) : void {
         var _local2:* = null;
         if(!param1) {
            return;
         }
         for(_local2 in param1) {
            this[_local2] = param1[_local2];
         }
      }

      public function join(... rest) : void {
         var _local2:int = rest.length;
         var _local3:int = 0;
         while(_local3 < _local2) {
            if(rest[_local3] is Variables) {
               _join(rest[_local3]);
            }
            _local3++;
         }
      }

      public function toString() : String {
         var _local2:String = null;
         var _local3:* = null;
         var _local4:String = null;
         var _local5:int = 0;
         var _local6:int = 0;
         var _local7:String = null;
         var _local8:String = null;
         var _local1:Array = [];
         for(_local3 in this) {
            _local2 = this[_local3];
            if(URIencode) {
               _local2 = encodeURI(_local2);
            }
            _local1.push(_local3 + "=" + _local2);
         }
         if(sort) {
            _local1.sort();
         }
         if(pre.length > 0) {
            pre.reverse();
            _local5 = 0;
            while(_local5 < pre.length) {
               _local7 = pre[_local5];
               _local6 = 0;
               while(_local6 < _local1.length) {
                  _local4 = _local1[_local6];
                  if(_local4.indexOf(_local7) == 0) {
                     _local1.unshift(_local1.splice(_local6,1)[0]);
                  }
                  _local6++;
               }
               _local5++;
            }
            pre.reverse();
         }
         if(post.length > 0) {
            _local5 = 0;
            while(_local5 < post.length) {
               _local8 = post[_local5];
               _local6 = 0;
               while(_local6 < _local1.length) {
                  _local4 = _local1[_local6];
                  if(_local4.indexOf(_local8) == 0) {
                     _local1.push(_local1.splice(_local6,1)[0]);
                  }
                  _local6++;
               }
               _local5++;
            }
         }
         return _local1.join("&");
      }

      public function decode(param1:String) : void {
         var _local2:Array = null;
         var _local3:String = null;
         var _local4:String = null;
         var _local5:String = null;
         var _local6:Array = null;
         if(param1 == "") {
            return;
         }
         if(param1.charAt(0) == "?") {
            param1 = param1.substr(1,param1.length);
         }
         if(param1.indexOf("&") > -1) {
            _local2 = param1.split("&");
         } else {
            _local2 = [param1];
         }
         var _local7:int = 0;
         while(_local7 < _local2.length) {
            _local3 = _local2[_local7];
            if(_local3.indexOf("=") > -1) {
               _local6 = _local3.split("=");
               _local4 = _local6[0];
               _local5 = decodeURI(_local6[1]);
               this[_local4] = _local5;
            }
            _local7++;
         }
      }

      public function toURLVariables() : URLVariables {
         var _local2:* = null;
         var _local1:URLVariables = new URLVariables();
         for(_local2 in this) {
            _local1[_local2] = this[_local2];
         }
         return _local1;
      }
   }
}
