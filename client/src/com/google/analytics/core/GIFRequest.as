package com.google.analytics.core {
import com.google.analytics.debug.DebugConfiguration;
import com.google.analytics.debug.VisualDebugMode;
import com.google.analytics.utils.Environment;
import com.google.analytics.utils.Protocols;
import com.google.analytics.utils.Variables;
import com.google.analytics.v4.Configuration;

import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLRequest;
import flash.system.LoaderContext;

public class GIFRequest {

      private var _info:Environment;

      private var _count:int;

      private var _utmac:String;

      private var _alertcount:int;

      private var _debug:DebugConfiguration;

      private var _lastRequest:URLRequest;

      private var _buffer:Buffer;

      private var _config:Configuration;

      private var _requests:Array;

      public function GIFRequest(param1:Configuration, param2:DebugConfiguration, param3:Buffer, param4:Environment) {
         super();
         _config = param1;
         _debug = param2;
         _buffer = param3;
         _info = param4;
         _count = 0;
         _alertcount = 0;
         _requests = [];
      }

      public function get utmn() : String {
         return Utils.generate32bitRandom() as String;
      }

      public function onIOError(param1:IOErrorEvent) : void {
         var _local2:String = _lastRequest.url;
         var _local3:String = String(_requests.length - 1);
         var _local4:* = "Gif Request #" + _local3 + " failed";
         if(_debug.GIFRequests) {
            if(!_debug.verbose) {
               if(_local2.indexOf("?") > -1) {
                  _local2 = _local2.split("?")[0];
               }
               _local2 = _shortenURL(_local2);
            }
            if(int(_debug.mode) > int(VisualDebugMode.basic)) {
               _local4 = _local4 + (" \"" + _local2 + "\" does not exists or is unreachable");
            }
            _debug.failure(_local4);
         } else {
            _debug.warning(_local4);
         }
         _removeListeners(param1.target);
      }

      public function send(param1:String, param2:Variables = null, param3:Boolean = false, param4:Boolean = false) : void {
         var _local5:String = null;
         var _local6:URLRequest = null;
         var _local7:URLRequest = null;
         _utmac = param1;
         if(!param2) {
            param2 = new Variables();
         }
         param2.URIencode = false;
         param2.pre = ["utmwv","utmn","utmhn","utmt","utme","utmcs","utmsr","utmsc","utmul","utmje","utmfl","utmdt","utmhid","utmr","utmp"];
         param2.post = ["utmcc"];
         if(_debug.verbose) {
            _debug.info("tracking: " + _buffer.utmb.trackCount + "/" + _config.trackingLimitPerSession,VisualDebugMode.geek);
         }
         if(_buffer.utmb.trackCount < _config.trackingLimitPerSession || Boolean(param3)) {
            if(param4) {
               updateToken();
            }
            if(Boolean(param3) || !param4 || _buffer.utmb.token >= 1) {
               if(!param3 && Boolean(param4)) {
                  _buffer.utmb.token = _buffer.utmb.token - 1;
               }
               _buffer.utmb.trackCount = _buffer.utmb.trackCount + 1;
               if(_debug.verbose) {
                  _debug.info(_buffer.utmb.toString(),VisualDebugMode.geek);
               }
               param2.utmwv = utmwv;
               param2.utmn = Utils.generate32bitRandom();
               if(_info.domainName != "") {
                  param2.utmhn = _info.domainName;
               }
               if(_config.sampleRate < 1) {
                  param2.utmsp = _config.sampleRate * 100;
               }
               if(_config.serverMode == ServerOperationMode.local || _config.serverMode == ServerOperationMode.both) {
                  _local5 = _info.locationSWFPath;
                  if(_local5.lastIndexOf("/") > 0) {
                     _local5 = _local5.substring(0,_local5.lastIndexOf("/"));
                  }
                  _local6 = new URLRequest();
                  if(_config.localGIFpath.indexOf("http") == 0) {
                     _local6.url = _config.localGIFpath;
                  } else {
                     _local6.url = _local5 + _config.localGIFpath;
                  }
                  _local6.url = _local6.url + ("?" + param2.toString());
                  if(Boolean(_debug.active) && Boolean(_debug.GIFRequests)) {
                     _debugSend(_local6);
                  } else {
                     sendRequest(_local6);
                  }
               }
               if(_config.serverMode == ServerOperationMode.remote || _config.serverMode == ServerOperationMode.both) {
                  _local7 = new URLRequest();
                  if(_info.protocol == Protocols.HTTPS) {
                     _local7.url = _config.secureRemoteGIFpath;
                  } else if(_info.protocol == Protocols.HTTP) {
                     _local7.url = _config.remoteGIFpath;
                  } else {
                     _local7.url = _config.remoteGIFpath;
                  }
                  param2.utmac = utmac;
                  param2.utmcc = encodeURIComponent(utmcc);
                  _local7.url = _local7.url + ("?" + param2.toString());
                  if(Boolean(_debug.active) && Boolean(_debug.GIFRequests)) {
                     _debugSend(_local7);
                  } else {
                     sendRequest(_local7);
                  }
               }
            }
         }
      }

      public function onSecurityError(param1:SecurityErrorEvent) : void {
         if(_debug.GIFRequests) {
            _debug.failure(param1.text);
         }
      }

      public function get utmsp() : String {
         return (_config.sampleRate * 100) as String;
      }

      public function get utmcc() : String {
         var _local1:Array = [];
         if(_buffer.hasUTMA()) {
            _local1.push(_buffer.utma.toURLString() + ";");
         }
         if(_buffer.hasUTMZ()) {
            _local1.push(_buffer.utmz.toURLString() + ";");
         }
         if(_buffer.hasUTMV()) {
            _local1.push(_buffer.utmv.toURLString() + ";");
         }
         return _local1.join("+");
      }

      public function get utmac() : String {
         return _utmac;
      }

      public function get utmwv() : String {
         return _config.version;
      }

      public function sendRequest(param1:URLRequest) : void {
         var request:URLRequest = param1;
         var loader:Loader = new Loader();
         loader.name = String(_count++);
         var context:LoaderContext = new LoaderContext(false);
         loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
         _lastRequest = request;
         _requests[loader.name] = new RequestObject(request);
         try {
            loader.load(request,context);
            return;
         }
         catch(e:Error) {
            _debug.failure("\"Loader.load()\" could not instanciate Gif Request");
            return;
         }
      }

      private function _removeListeners(param1:Object) : void {
         param1.removeEventListener(IOErrorEvent.IO_ERROR,onIOError);
         param1.removeEventListener(Event.COMPLETE,onComplete);
      }

      public function updateToken() : void {
         var _local2:Number = NaN;
         var _local1:Number = new Date().getTime();
         _local2 = (_local1 - _buffer.utmb.lastTime) * (_config.tokenRate / 1000);
         if(_debug.verbose) {
            _debug.info("tokenDelta: " + _local2,VisualDebugMode.geek);
         }
         if(_local2 >= 1) {
            _buffer.utmb.token = Math.min(Math.floor(_buffer.utmb.token + _local2),_config.bucketCapacity);
            _buffer.utmb.lastTime = _local1;
            if(_debug.verbose) {
               _debug.info(_buffer.utmb.toString(),VisualDebugMode.geek);
            }
         }
      }

      public function get utmhn() : String {
         return _info.domainName;
      }

      private function _shortenURL(param1:String) : String {
         var _local2:Array = null;
         if(param1.length > 60) {
            _local2 = param1.split("/");
            while(param1.length > 60) {
               _local2.shift();
               param1 = "../" + _local2.join("/");
            }
         }
         return param1;
      }

      private function _debugSend(param1:URLRequest) : void {
         var _local3:String = null;
         var _local2:* = "";
         switch(_debug.mode) {
            case VisualDebugMode.geek:
               _local2 = "Gif Request #" + _alertcount + ":\n" + param1.url;
               break;
            case VisualDebugMode.advanced:
               _local3 = param1.url;
               if(_local3.indexOf("?") > -1) {
                  _local3 = _local3.split("?")[0];
               }
               _local3 = _shortenURL(_local3);
               _local2 = "Send Gif Request #" + _alertcount + ":\n" + _local3 + " ?";
               break;
            case VisualDebugMode.basic:
            default:
               _local2 = "Send " + _config.serverMode.toString() + " Gif Request #" + _alertcount + " ?";
         }
         _debug.alertGifRequest(_local2,param1,this);
         _alertcount++;
      }

      public function onComplete(param1:Event) : void {
         var _local2:String = param1.target.loader.name;
         _requests[_local2].complete();
         var _local3:* = "Gif Request #" + _local2 + " sent";
         var _local4:String = _requests[_local2].request.url;
         if(_debug.GIFRequests) {
            if(!_debug.verbose) {
               if(_local4.indexOf("?") > -1) {
                  _local4 = _local4.split("?")[0];
               }
               _local4 = _shortenURL(_local4);
            }
            if(int(_debug.mode) > int(VisualDebugMode.basic)) {
               _local3 = _local3 + (" to \"" + _local4 + "\"");
            }
            _debug.success(_local3);
         } else {
            _debug.info(_local3);
         }
         _removeListeners(param1.target);
      }
   }
}
