package com.google.analytics.debug {
import com.google.analytics.core.GIFRequest;

import flash.net.URLRequest;
import flash.ui.Keyboard;
import flash.utils.getTimer;

public class DebugConfiguration {

      public var showHideKey:Number;

      private var _mode:VisualDebugMode;

      private var _verbose:Boolean = false;

      public var destroyKey:Number;

      public var GIFRequests:Boolean = false;

      public var showInfos:Boolean = true;

      public var infoTimeout:Number = 1000;

      public var minimizedOnStart:Boolean = false;

      private var _active:Boolean = false;

      public var traceOutput:Boolean = false;

      public var layout:ILayout;

      public var warningTimeout:Number = 1500;

      public var javascript:Boolean = false;

      public var showWarnings:Boolean = true;

      private var _visualInitialized:Boolean = false;

      public function DebugConfiguration() {
         _mode = VisualDebugMode.basic;
         showHideKey = Keyboard.SPACE;
         destroyKey = Keyboard.BACKSPACE;
         super();
      }

      public function get verbose() : Boolean {
         return _verbose;
      }

      public function set verbose(param1:Boolean) : void {
         _verbose = param1;
      }

      public function set mode(param1:*) : void {
         if(param1 is String) {
            switch(param1) {
               case "geek":
                  param1 = VisualDebugMode.geek;
                  break;
               case "advanced":
                  param1 = VisualDebugMode.advanced;
                  break;
               default:
               case "basic":
                  param1 = VisualDebugMode.basic;
            }
         }
         _mode = param1;
      }

      public function success(param1:String) : void {
         if(layout) {
            layout.createSuccessAlert(param1);
         }
         if(traceOutput) {
            trace("[+] " + param1 + " !!");
         }
      }

      public function get active() : Boolean {
         return _active;
      }

      private function _initializeVisual() : void {
         if(layout) {
            layout.init();
            _visualInitialized = true;
         }
      }

      private function _destroyVisual() : void {
         if(Boolean(layout) && Boolean(_visualInitialized)) {
            layout.destroy();
         }
      }

      public function warning(param1:String, param2:VisualDebugMode = null) : void {
         if(_filter(param2)) {
            return;
         }
         if(Boolean(layout) && Boolean(showWarnings)) {
            layout.createWarning(param1);
         }
         if(traceOutput) {
            trace("## " + param1 + " ##");
         }
      }

      private function _filter(param1:VisualDebugMode = null) : Boolean {
         return Boolean(param1) && int(param1) >= int(this.mode);
      }

      public function failure(param1:String) : void {
         if(layout) {
            layout.createFailureAlert(param1);
         }
         if(traceOutput) {
            trace("[-] " + param1 + " !!");
         }
      }

      public function get mode() : * {
         return _mode;
      }

      public function set active(param1:Boolean) : void {
         _active = param1;
         if(_active) {
            _initializeVisual();
         } else {
            _destroyVisual();
         }
      }

      protected function trace(param1:String) : void {
         var _local7:Array = null;
         var _local8:int = 0;
         var _local2:Array = [];
         var _local3:* = "";
         var _local4:* = "";
         if(this.mode == VisualDebugMode.geek) {
            _local3 = getTimer() + " - ";
            _local4 = new Array(_local3.length).join(" ") + " ";
         }
         if(param1.indexOf("\n") > -1) {
            _local7 = param1.split("\n");
            _local8 = 0;
            while(_local8 < _local7.length) {
               if(_local7[_local8] != "") {
                  if(_local8 == 0) {
                     _local2.push(_local3 + _local7[_local8]);
                  } else {
                     _local2.push(_local4 + _local7[_local8]);
                  }
               }
               _local8++;
            }
         } else {
            _local2.push(_local3 + param1);
         }
         var _local5:int = _local2.length;
         var _local6:int = 0;
         while(_local6 < _local5) {
            trace(_local2[_local6]);
            _local6++;
         }
      }

      public function alert(param1:String) : void {
         if(layout) {
            layout.createAlert(param1);
         }
         if(traceOutput) {
            trace("!! " + param1 + " !!");
         }
      }

      public function info(param1:String, param2:VisualDebugMode = null) : void {
         if(_filter(param2)) {
            return;
         }
         if(Boolean(layout) && Boolean(showInfos)) {
            layout.createInfo(param1);
         }
         if(traceOutput) {
            trace(param1);
         }
      }

      public function alertGifRequest(param1:String, param2:URLRequest, param3:GIFRequest) : void {
         if(layout) {
            layout.createGIFRequestAlert(param1,param2,param3);
         }
         if(traceOutput) {
            trace(">> " + param1 + " <<");
         }
      }
   }
}
