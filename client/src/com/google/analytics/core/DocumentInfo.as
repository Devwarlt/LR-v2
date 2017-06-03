package com.google.analytics.core {
import com.google.analytics.external.AdSenseGlobals;
import com.google.analytics.utils.Environment;
import com.google.analytics.utils.Variables;
import com.google.analytics.v4.Configuration;

public class DocumentInfo {

      private var _pageURL:String;

      private var _utmr:String;

      private var _config:Configuration;

      private var _adSense:AdSenseGlobals;

      private var _info:Environment;

      public function DocumentInfo(param1:Configuration, param2:Environment, param3:String, param4:String = null, param5:AdSenseGlobals = null) {
         super();
         _config = param1;
         _info = param2;
         _utmr = param3;
         _pageURL = param4;
         _adSense = param5;
      }

      public function get utmr() : String {
         if(!_utmr) {
            return "-";
         }
         return _utmr;
      }

      public function toURLString() : String {
         var _local1:Variables = toVariables();
         return _local1.toString();
      }

      private function _renderPageURL(param1:String = "") : String {
         var _local2:String = _info.locationPath;
         var _local3:String = _info.locationSearch;
         if(!param1 || param1 == "") {
            param1 = _local2 + unescape(_local3);
            if(param1 == "") {
               param1 = "/";
            }
         }
         return param1;
      }

      public function get utmp() : String {
         return _renderPageURL(_pageURL);
      }

      public function get utmhid() : String {
         return String(_generateHitId());
      }

      private function _generateHitId() : Number {
         var _local1:Number = NaN;
         if(Boolean(_adSense.hid) && _adSense.hid != "") {
            _local1 = Number(_adSense.hid);
         } else {
            _local1 = Math.round(Math.random() * 2147483647);
            _adSense.hid = String(_local1);
         }
         return _local1;
      }

      public function toVariables() : Variables {
         var _local1:Variables = new Variables();
         _local1.URIencode = true;
         if(Boolean(_config.detectTitle) && utmdt != "") {
            _local1.utmdt = utmdt;
         }
         _local1.utmhid = utmhid;
         _local1.utmr = utmr;
         _local1.utmp = utmp;
         return _local1;
      }

      public function get utmdt() : String {
         return _info.documentTitle;
      }
   }
}
