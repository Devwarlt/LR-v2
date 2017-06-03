package com.google.analytics.utils {
import com.google.analytics.core.Utils;

import flash.system.Capabilities;
import flash.system.System;

public class UserAgent {

      public static var minimal:Boolean = false;

      private var _localInfo:Environment;

      private var _applicationProduct:String;

      private var _version:Version;

      public function UserAgent(param1:Environment, param2:String = "", param3:String = "") {
         super();
         _localInfo = param1;
         applicationProduct = param2;
         _version = Version.fromString(param3);
      }

      public function get tamarinProductToken() : String {
         if(UserAgent.minimal) {
            return "";
         }
         if(System.vmVersion) {
            return "Tamarin/" + Utils.trim(System.vmVersion,true);
         }
         return "";
      }

      public function get applicationVersion() : String {
         return _version.toString(2);
      }

      public function get vendorProductToken() : String {
         var _local1:* = "";
         if(_localInfo.isAIR()) {
            _local1 = _local1 + "AIR";
         } else {
            _local1 = _local1 + "FlashPlayer";
         }
         _local1 = _local1 + "/";
         _local1 = _local1 + _version.toString(3);
         return _local1;
      }

      public function toString() : String {
         var _local1:String = "";
         _local1 = _local1 + applicationProductToken;
         if(applicationComment != "") {
            _local1 = _local1 + (" " + applicationComment);
         }
         if(tamarinProductToken != "") {
            _local1 = _local1 + (" " + tamarinProductToken);
         }
         if(vendorProductToken != "") {
            _local1 = _local1 + (" " + vendorProductToken);
         }
         return _local1;
      }

      public function get applicationComment() : String {
         var _local1:Array = [];
         _local1.push(_localInfo.platform);
         _local1.push(_localInfo.playerType);
         if(!UserAgent.minimal) {
            _local1.push(_localInfo.operatingSystem);
            _local1.push(_localInfo.language);
         }
         if(Capabilities.isDebugger) {
            _local1.push("DEBUG");
         }
         if(_local1.length > 0) {
            return "(" + _local1.join("; ") + ")";
         }
         return "";
      }

      public function set applicationVersion(param1:String) : void {
         _version = Version.fromString(param1);
      }

      public function get applicationProductToken() : String {
         var _local1:String = applicationProduct;
         if(applicationVersion != "") {
            _local1 = _local1 + ("/" + applicationVersion);
         }
         return _local1;
      }

      public function set applicationProduct(param1:String) : void {
         _applicationProduct = param1;
      }

      public function get applicationProduct() : String {
         return _applicationProduct;
      }
   }
}
