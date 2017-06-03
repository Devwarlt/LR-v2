package com.google.analytics.v4 {
import com.google.analytics.campaign.CampaignInfo;
import com.google.analytics.campaign.CampaignManager;
import com.google.analytics.core.BrowserInfo;
import com.google.analytics.core.Buffer;
import com.google.analytics.core.DocumentInfo;
import com.google.analytics.core.DomainNameMode;
import com.google.analytics.core.Ecommerce;
import com.google.analytics.core.EventInfo;
import com.google.analytics.core.EventTracker;
import com.google.analytics.core.GIFRequest;
import com.google.analytics.core.ServerOperationMode;
import com.google.analytics.core.Utils;
import com.google.analytics.data.X10;
import com.google.analytics.debug.DebugConfiguration;
import com.google.analytics.debug.VisualDebugMode;
import com.google.analytics.ecommerce.Transaction;
import com.google.analytics.external.AdSenseGlobals;
import com.google.analytics.utils.Environment;
import com.google.analytics.utils.Protocols;
import com.google.analytics.utils.URL;
import com.google.analytics.utils.Variables;

import flash.net.URLRequest;
import flash.net.navigateToURL;

public class Tracker implements GoogleAnalyticsAPI {

      private var _adSense:AdSenseGlobals;

      private const EVENT_TRACKER_LABEL_KEY_NUM:int = 3;

      private var _eventTracker:X10;

      private const EVENT_TRACKER_VALUE_VALUE_NUM:int = 1;

      private var _noSessionInformation:Boolean = false;

      private var _browserInfo:BrowserInfo;

      private var _debug:DebugConfiguration;

      private var _isNewVisitor:Boolean = false;

      private var _buffer:Buffer;

      private var _config:Configuration;

      private var _x10Module:X10;

      private var _campaign:CampaignManager;

      private var _formatedReferrer:String;

      private var _timeStamp:Number;

      private var _info:Environment;

      private var _domainHash:Number;

      private const EVENT_TRACKER_PROJECT_ID:int = 5;

      private var _campaignInfo:CampaignInfo;

      private const EVENT_TRACKER_OBJECT_NAME_KEY_NUM:int = 1;

      private var _gifRequest:GIFRequest;

      private const EVENT_TRACKER_TYPE_KEY_NUM:int = 2;

      private var _hasInitData:Boolean = false;

      private var _ecom:Ecommerce;

      private var _account:String;

      public function Tracker(param1:String, param2:Configuration, param3:DebugConfiguration, param4:Environment, param5:Buffer, param6:GIFRequest, param7:AdSenseGlobals, param8:Ecommerce) {
         var _local9:* = null;
         super();
         _account = param1;
         _config = param2;
         _debug = param3;
         _info = param4;
         _buffer = param5;
         _gifRequest = param6;
         _adSense = param7;
         _ecom = param8;
         if(!Utils.validateAccount(param1)) {
            _local9 = "Account \"" + param1 + "\" is not valid.";
            _debug.warning(_local9);
            throw new Error(_local9);
         }
      }

      private function _doTracking() : Boolean {
         if(_info.protocol != Protocols.file && _info.protocol != Protocols.none && Boolean(_isNotGoogleSearch())) {
            return true;
         }
         if(_config.allowLocalTracking) {
            return true;
         }
         return false;
      }

      public function addOrganic(param1:String, param2:String) : void {
         _debug.info("addOrganic( " + [param1,param2].join(", ") + " )");
         _config.organic.addSource(param1,param2);
      }

      public function setAllowLinker(param1:Boolean) : void {
         _config.allowLinker = param1;
         _debug.info("setAllowLinker( " + _config.allowLinker + " )");
      }

      public function getLinkerUrl(param1:String = "", param2:Boolean = false) : String {
         _initData();
         _debug.info("getLinkerUrl( " + param1 + ", " + param2.toString() + " )");
         return _buffer.getLinkerUrl(param1,param2);
      }

      public function trackEvent(param1:String, param2:String, param3:String = null, param4:Number = NaN) : Boolean {
         _initData();
         var _local5:Boolean = true;
         var _local6:int = 2;
         if(param1 != "" && param2 != "") {
            _eventTracker.clearKey(EVENT_TRACKER_PROJECT_ID);
            _eventTracker.clearValue(EVENT_TRACKER_PROJECT_ID);
            _local5 = _eventTracker.setKey(EVENT_TRACKER_PROJECT_ID,EVENT_TRACKER_OBJECT_NAME_KEY_NUM,param1);
            _local5 = _eventTracker.setKey(EVENT_TRACKER_PROJECT_ID,EVENT_TRACKER_TYPE_KEY_NUM,param2);
            if(param3) {
               _local5 = _eventTracker.setKey(EVENT_TRACKER_PROJECT_ID,EVENT_TRACKER_LABEL_KEY_NUM,param3);
               _local6 = 3;
            }
            if(!isNaN(param4)) {
               _local5 = _eventTracker.setValue(EVENT_TRACKER_PROJECT_ID,EVENT_TRACKER_VALUE_VALUE_NUM,param4);
               _local6 = 4;
            }
            if(_local5) {
               _debug.info("valid event tracking call\ncategory: " + param1 + "\naction: " + param2,VisualDebugMode.geek);
               _sendXEvent(_eventTracker);
            }
         } else {
            _debug.warning("event tracking call is not valid, failed!\ncategory: " + param1 + "\naction: " + param2,VisualDebugMode.geek);
            _local5 = false;
         }
         switch(_local6) {
            case 4:
               _debug.info("trackEvent( " + [param1,param2,param3,param4].join(", ") + " )");
               break;
            case 3:
               _debug.info("trackEvent( " + [param1,param2,param3].join(", ") + " )");
               break;
            case 2:
            default:
               _debug.info("trackEvent( " + [param1,param2].join(", ") + " )");
         }
         return _local5;
      }

      public function trackPageview(param1:String = "") : void {
         _debug.info("trackPageview( " + param1 + " )");
         if(_doTracking()) {
            _initData();
            _trackMetrics(param1);
            _noSessionInformation = false;
         } else {
            _debug.warning("trackPageview( " + param1 + " ) failed");
         }
      }

      public function setCookieTimeout(param1:int) : void {
         _config.conversionTimeout = param1;
         _debug.info("setCookieTimeout( " + _config.conversionTimeout + " )");
      }

      public function trackTrans() : void {
         var _local1:Number = NaN;
         var _local2:Number = NaN;
         var _local4:Transaction = null;
         _initData();
         var _local3:Array = new Array();
         if(_takeSample()) {
            _local1 = 0;
            while(_local1 < _ecom.getTransLength()) {
               _local4 = _ecom.getTransFromArray(_local1);
               _local3.push(_local4.toGifParams());
               _local2 = 0;
               while(_local2 < _local4.getItemsLength()) {
                  _local3.push(_local4.getItemFromArray(_local2).toGifParams());
                  _local2++;
               }
               _local1++;
            }
            _local1 = 0;
            while(_local1 < _local3.length) {
               _gifRequest.send(_account,_local3[_local1]);
               _local1++;
            }
         }
      }

      public function setClientInfo(param1:Boolean) : void {
         _config.detectClientInfo = param1;
         _debug.info("setClientInfo( " + _config.detectClientInfo + " )");
      }

      public function linkByPost(param1:Object, param2:Boolean = false) : void {
         _debug.warning("linkByPost not implemented in AS3 mode");
      }

      private function _initData() : void {
         var _local1:* = null;
         var _local2:* = null;
         if(!_hasInitData) {
            _updateDomainName();
            _domainHash = _getDomainHash();
            _timeStamp = Math.round(new Date().getTime() / 1000);
            if(_debug.verbose) {
               _local1 = "";
               _local1 = _local1 + "_initData 0";
               _local1 = _local1 + ("\ndomain name: " + _config.domainName);
               _local1 = _local1 + ("\ndomain hash: " + _domainHash);
               _local1 = _local1 + ("\ntimestamp:   " + _timeStamp + " (" + new Date(_timeStamp * 1000) + ")");
               _debug.info(_local1,VisualDebugMode.geek);
            }
         }
         if(_doTracking()) {
            _handleCookie();
         }
         if(!_hasInitData) {
            if(_doTracking()) {
               _formatedReferrer = _formatReferrer();
               _browserInfo = new BrowserInfo(_config,_info);
               _debug.info("browserInfo: " + _browserInfo.toURLString(),VisualDebugMode.advanced);
               if(_config.campaignTracking) {
                  _campaign = new CampaignManager(_config,_debug,_buffer,_domainHash,_formatedReferrer,_timeStamp);
                  _campaignInfo = _campaign.getCampaignInformation(_info.locationSearch,_noSessionInformation);
                  _debug.info("campaignInfo: " + _campaignInfo.toURLString(),VisualDebugMode.advanced);
                  _debug.info("Search: " + _info.locationSearch);
                  _debug.info("CampaignTrackig: " + _buffer.utmz.campaignTracking);
               }
            }
            _x10Module = new X10();
            _eventTracker = new X10();
            _hasInitData = true;
         }
         if(_config.hasSiteOverlay) {
            _debug.warning("Site Overlay is not supported");
         }
         if(_debug.verbose) {
            _local2 = "";
            _local2 = _local2 + "_initData (misc)";
            _local2 = _local2 + ("\nflash version: " + _info.flashVersion.toString(4));
            _local2 = _local2 + ("\nprotocol: " + _info.protocol);
            _local2 = _local2 + ("\ndefault domain name (auto): \"" + _info.domainName + "\"");
            _local2 = _local2 + ("\nlanguage: " + _info.language);
            _local2 = _local2 + ("\ndomain hash: " + _getDomainHash());
            _local2 = _local2 + ("\nuser-agent: " + _info.userAgent);
            _debug.info(_local2,VisualDebugMode.geek);
         }
      }

      public function getDetectTitle() : Boolean {
         _debug.info("getDetectTitle()");
         return _config.detectTitle;
      }

      public function resetSession() : void {
         _debug.info("resetSession()");
         _buffer.resetCurrentSession();
      }

      public function getClientInfo() : Boolean {
         _debug.info("getClientInfo()");
         return _config.detectClientInfo;
      }

      private function _sendXEvent(param1:X10 = null) : void {
         var _local2:Variables = null;
         var _local3:EventInfo = null;
         var _local4:Variables = null;
         var _local5:Variables = null;
         if(_takeSample()) {
            _local2 = new Variables();
            _local2.URIencode = true;
            _local3 = new EventInfo(true,_x10Module,param1);
            _local4 = _local3.toVariables();
            _local5 = _renderMetricsSearchVariables();
            _local2.join(_local4,_local5);
            _gifRequest.send(_account,_local2,false,true);
         }
      }

      public function setDetectFlash(param1:Boolean) : void {
         _config.detectFlash = param1;
         _debug.info("setDetectFlash( " + _config.detectFlash + " )");
      }

      public function setCampNameKey(param1:String) : void {
         _config.campaignKey.UCCN = param1;
         var _local2:* = "setCampNameKey( " + _config.campaignKey.UCCN + " )";
         if(_debug.mode == VisualDebugMode.geek) {
            _debug.info(_local2 + " [UCCN]");
         } else {
            _debug.info(_local2);
         }
      }

      private function _formatReferrer() : String {
         var _local2:String = null;
         var _local3:URL = null;
         var _local4:URL = null;
         var _local1:String = _info.referrer;
         if(_local1 == "" || _local1 == "localhost") {
            _local1 = "-";
         } else {
            _local2 = _info.domainName;
            _local3 = new URL(_local1);
            _local4 = new URL("http://" + _local2);
            if(_local3.hostName == _local2) {
               return "-";
            }
            if(_local4.domain == _local3.domain) {
               if(_local4.subDomain != _local3.subDomain) {
                  _local1 = "0";
               }
            }
            if(_local1.charAt(0) == "[" && Boolean(_local1.charAt(_local1.length - 1))) {
               _local1 = "-";
            }
         }
         _debug.info("formated referrer: " + _local1,VisualDebugMode.advanced);
         return _local1;
      }

      private function _visitCode() : Number {
         if(_debug.verbose) {
            _debug.info("visitCode: " + _buffer.utma.sessionId,VisualDebugMode.geek);
         }
         return _buffer.utma.sessionId;
      }

      public function createEventTracker(param1:String) : EventTracker {
         _debug.info("createEventTracker( " + param1 + " )");
         return new EventTracker(param1,this);
      }

      public function addItem(param1:String, param2:String, param3:String, param4:String, param5:Number, param6:int) : void {
         var _local7:Transaction = null;
         _local7 = _ecom.getTransaction(param1);
         if(_local7 == null) {
            _local7 = _ecom.addTransaction(param1,"","","","","","","");
         }
         _local7.addItem(param2,param3,param4,param5.toString(),param6.toString());
         if(_debug.active) {
            _debug.info("addItem( " + [param1,param2,param3,param4,param5,param6].join(", ") + " )");
         }
      }

      public function clearIgnoredOrganic() : void {
         _debug.info("clearIgnoredOrganic()");
         _config.organic.clearIgnoredKeywords();
      }

      public function setVar(param1:String) : void {
         var _local2:Variables = null;
         if(param1 != "" && Boolean(_isNotGoogleSearch())) {
            _initData();
            _buffer.utmv.domainHash = _domainHash;
            _buffer.utmv.value = encodeURI(param1);
            if(_debug.verbose) {
               _debug.info(_buffer.utmv.toString(),VisualDebugMode.geek);
            }
            _debug.info("setVar( " + param1 + " )");
            if(_takeSample()) {
               _local2 = new Variables();
               _local2.utmt = "var";
               _gifRequest.send(_account,_local2);
            }
         } else {
            _debug.warning("setVar \"" + param1 + "\" is ignored");
         }
      }

      public function setDomainName(param1:String) : void {
         if(param1 == "auto") {
            _config.domain.mode = DomainNameMode.auto;
         } else if(param1 == "none") {
            _config.domain.mode = DomainNameMode.none;
         } else {
            _config.domain.mode = DomainNameMode.custom;
            _config.domain.name = param1;
         }
         _updateDomainName();
         _debug.info("setDomainName( " + _config.domainName + " )");
      }

      private function _updateDomainName() : void {
         var _local1:String = null;
         if(_config.domain.mode == DomainNameMode.auto) {
            _local1 = _info.domainName;
            if(_local1.substring(0,4) == "www.") {
               _local1 = _local1.substring(4);
            }
            _config.domain.name = _local1;
         }
         _config.domainName = _config.domain.name.toLowerCase();
         _debug.info("domain name: " + _config.domainName,VisualDebugMode.advanced);
      }

      public function addTrans(param1:String, param2:String, param3:Number, param4:Number, param5:Number, param6:String, param7:String, param8:String) : void {
         _ecom.addTransaction(param1,param2,param3.toString(),param4.toString(),param5.toString(),param6,param7,param8);
         if(_debug.active) {
            _debug.info("addTrans( " + [param1,param2,param3,param4,param5,param6,param7,param8].join(", ") + " );");
         }
      }

      private function _renderMetricsSearchVariables(param1:String = "") : Variables {
         var _local4:Variables = null;
         var _local2:Variables = new Variables();
         _local2.URIencode = true;
         var _local3:DocumentInfo = new DocumentInfo(_config,_info,_formatedReferrer,param1,_adSense);
         _debug.info("docInfo: " + _local3.toURLString(),VisualDebugMode.geek);
         if(_config.campaignTracking) {
            _local4 = _campaignInfo.toVariables();
         }
         var _local5:Variables = _browserInfo.toVariables();
         _local2.join(_local3.toVariables(),_local5,_local4);
         return _local2;
      }

      public function setCampContentKey(param1:String) : void {
         _config.campaignKey.UCCT = param1;
         var _local2:* = "setCampContentKey( " + _config.campaignKey.UCCT + " )";
         if(_debug.mode == VisualDebugMode.geek) {
            _debug.info(_local2 + " [UCCT]");
         } else {
            _debug.info(_local2);
         }
      }

      private function _handleCookie() : void {
         var _local1:* = null;
         var _local2:* = null;
         var _local3:Array = null;
         var _local4:* = null;
         if(!_config.allowLinker) {
         }
         _buffer.createSO();
         if(Boolean(_buffer.hasUTMA()) && !_buffer.utma.isEmpty()) {
            if(!_buffer.hasUTMB() || !_buffer.hasUTMC()) {
               _buffer.updateUTMA(_timeStamp);
               _noSessionInformation = true;
            }
            if(_debug.verbose) {
               _debug.info("from cookie " + _buffer.utma.toString(),VisualDebugMode.geek);
            }
         } else {
            _debug.info("create a new utma",VisualDebugMode.advanced);
            _buffer.utma.domainHash = _domainHash;
            _buffer.utma.sessionId = _getUniqueSessionId();
            _buffer.utma.firstTime = _timeStamp;
            _buffer.utma.lastTime = _timeStamp;
            _buffer.utma.currentTime = _timeStamp;
            _buffer.utma.sessionCount = 1;
            if(_debug.verbose) {
               _debug.info(_buffer.utma.toString(),VisualDebugMode.geek);
            }
            _noSessionInformation = true;
            _isNewVisitor = true;
         }
         if(Boolean(_adSense.gaGlobal) && _adSense.dh == String(_domainHash)) {
            if(_adSense.sid) {
               _buffer.utma.currentTime = Number(_adSense.sid);
               if(_debug.verbose) {
                  _local1 = "";
                  _local1 = _local1 + "AdSense sid found\n";
                  _local1 = _local1 + ("Override currentTime(" + _buffer.utma.currentTime + ") from AdSense sid(" + Number(_adSense.sid) + ")");
                  _debug.info(_local1,VisualDebugMode.geek);
               }
            }
            if(_isNewVisitor) {
               if(_adSense.sid) {
                  _buffer.utma.lastTime = Number(_adSense.sid);
                  if(_debug.verbose) {
                     _local2 = "";
                     _local2 = _local2 + "AdSense sid found (new visitor)\n";
                     _local2 = _local2 + ("Override lastTime(" + _buffer.utma.lastTime + ") from AdSense sid(" + Number(_adSense.sid) + ")");
                     _debug.info(_local2,VisualDebugMode.geek);
                  }
               }
               if(_adSense.vid) {
                  _local3 = _adSense.vid.split(".");
                  _buffer.utma.sessionId = Number(_local3[0]);
                  _buffer.utma.firstTime = Number(_local3[1]);
                  if(_debug.verbose) {
                     _local4 = "";
                     _local4 = _local4 + "AdSense vid found (new visitor)\n";
                     _local4 = _local4 + ("Override sessionId(" + _buffer.utma.sessionId + ") from AdSense vid(" + Number(_local3[0]) + ")\n");
                     _local4 = _local4 + ("Override firstTime(" + _buffer.utma.firstTime + ") from AdSense vid(" + Number(_local3[1]) + ")");
                     _debug.info(_local4,VisualDebugMode.geek);
                  }
               }
               if(_debug.verbose) {
                  _debug.info("AdSense modified : " + _buffer.utma.toString(),VisualDebugMode.geek);
               }
            }
         }
         _buffer.utmb.domainHash = _domainHash;
         if(isNaN(_buffer.utmb.trackCount)) {
            _buffer.utmb.trackCount = 0;
         }
         if(isNaN(_buffer.utmb.token)) {
            _buffer.utmb.token = _config.tokenCliff;
         }
         if(isNaN(_buffer.utmb.lastTime)) {
            _buffer.utmb.lastTime = _buffer.utma.currentTime;
         }
         _buffer.utmc.domainHash = _domainHash;
         if(_debug.verbose) {
            _debug.info(_buffer.utmb.toString(),VisualDebugMode.advanced);
            _debug.info(_buffer.utmc.toString(),VisualDebugMode.advanced);
         }
      }

      public function setLocalServerMode() : void {
         _config.serverMode = ServerOperationMode.local;
         _debug.info("setLocalServerMode()");
      }

      public function clearIgnoredRef() : void {
         _debug.info("clearIgnoredRef()");
         _config.organic.clearIgnoredReferrals();
      }

      public function setCampSourceKey(param1:String) : void {
         _config.campaignKey.UCSR = param1;
         var _local2:* = "setCampSourceKey( " + _config.campaignKey.UCSR + " )";
         if(_debug.mode == VisualDebugMode.geek) {
            _debug.info(_local2 + " [UCSR]");
         } else {
            _debug.info(_local2);
         }
      }

      public function getLocalGifPath() : String {
         _debug.info("getLocalGifPath()");
         return _config.localGIFpath;
      }

      public function setLocalGifPath(param1:String) : void {
         _config.localGIFpath = param1;
         _debug.info("setLocalGifPath( " + _config.localGIFpath + " )");
      }

      public function getVersion() : String {
         _debug.info("getVersion()");
         return _config.version;
      }

      public function setAllowAnchor(param1:Boolean) : void {
         _config.allowAnchor = param1;
         _debug.info("setAllowAnchor( " + _config.allowAnchor + " )");
      }

      private function _isNotGoogleSearch() : Boolean {
         var _local1:String = _config.domainName;
         var _local2:* = _local1.indexOf("www.google.") < 0;
         var _local3:* = _local1.indexOf(".google.") < 0;
         var _local4:* = _local1.indexOf("google.") < 0;
         var _local5:* = _local1.indexOf("google.org") > -1;
         return Boolean(_local2) || Boolean(_local3) || Boolean(_local4) || _config.cookiePath != "/" || Boolean(_local5);
      }

      public function setSampleRate(param1:Number) : void {
         if(param1 < 0) {
            _debug.warning("sample rate can not be negative, ignoring value.");
         } else {
            _config.sampleRate = param1;
         }
         _debug.info("setSampleRate( " + _config.sampleRate + " )");
      }

      private function _takeSample() : Boolean {
         if(_debug.verbose) {
            _debug.info("takeSample: (" + _visitCode() % 10000 + ") < (" + _config.sampleRate * 10000 + ")",VisualDebugMode.geek);
         }
         return _visitCode() % 10000 < _config.sampleRate * 10000;
      }

      public function setCookiePath(param1:String) : void {
         _config.cookiePath = param1;
         _debug.info("setCookiePath( " + _config.cookiePath + " )");
      }

      public function setAllowHash(param1:Boolean) : void {
         _config.allowDomainHash = param1;
         _debug.info("setAllowHash( " + _config.allowDomainHash + " )");
      }

      private function _generateUserDataHash() : Number {
         var _local1:String = "";
         _local1 = _local1 + _info.appName;
         _local1 = _local1 + _info.appVersion;
         _local1 = _local1 + _info.language;
         _local1 = _local1 + _info.platform;
         _local1 = _local1 + _info.userAgent.toString();
         _local1 = _local1 + (_info.screenWidth + "x" + _info.screenHeight + _info.screenColorDepth);
         _local1 = _local1 + _info.referrer;
         return Utils.generateHash(_local1);
      }

      public function setCampNOKey(param1:String) : void {
         _config.campaignKey.UCNO = param1;
         var _local2:* = "setCampNOKey( " + _config.campaignKey.UCNO + " )";
         if(_debug.mode == VisualDebugMode.geek) {
            _debug.info(_local2 + " [UCNO]");
         } else {
            _debug.info(_local2);
         }
      }

      public function addIgnoredOrganic(param1:String) : void {
         _debug.info("addIgnoredOrganic( " + param1 + " )");
         _config.organic.addIgnoredKeyword(param1);
      }

      public function setLocalRemoteServerMode() : void {
         _config.serverMode = ServerOperationMode.both;
         _debug.info("setLocalRemoteServerMode()");
      }

      public function cookiePathCopy(param1:String) : void {
         _debug.warning("cookiePathCopy( " + param1 + " ) not implemented");
      }

      public function setDetectTitle(param1:Boolean) : void {
         _config.detectTitle = param1;
         _debug.info("setDetectTitle( " + _config.detectTitle + " )");
      }

      public function setCampTermKey(param1:String) : void {
         _config.campaignKey.UCTR = param1;
         var _local2:* = "setCampTermKey( " + _config.campaignKey.UCTR + " )";
         if(_debug.mode == VisualDebugMode.geek) {
            _debug.info(_local2 + " [UCTR]");
         } else {
            _debug.info(_local2);
         }
      }

      public function getServiceMode() : ServerOperationMode {
         _debug.info("getServiceMode()");
         return _config.serverMode;
      }

      private function _trackMetrics(param1:String = "") : void {
         var _local2:Variables = null;
         var _local3:Variables = null;
         var _local4:Variables = null;
         var _local5:EventInfo = null;
         if(_takeSample()) {
            _local2 = new Variables();
            _local2.URIencode = true;
            if(Boolean(_x10Module) && Boolean(_x10Module.hasData())) {
               _local5 = new EventInfo(false,_x10Module);
               _local3 = _local5.toVariables();
            }
            _local4 = _renderMetricsSearchVariables(param1);
            _local2.join(_local3,_local4);
            _gifRequest.send(_account,_local2);
         }
      }

      public function setCampaignTrack(param1:Boolean) : void {
         _config.campaignTracking = param1;
         _debug.info("setCampaignTrack( " + _config.campaignTracking + " )");
      }

      public function addIgnoredRef(param1:String) : void {
         _debug.info("addIgnoredRef( " + param1 + " )");
         _config.organic.addIgnoredReferral(param1);
      }

      public function clearOrganic() : void {
         _debug.info("clearOrganic()");
         _config.organic.clearEngines();
      }

      public function getDetectFlash() : Boolean {
         _debug.info("getDetectFlash()");
         return _config.detectFlash;
      }

      public function setCampMediumKey(param1:String) : void {
         _config.campaignKey.UCMD = param1;
         var _local2:* = "setCampMediumKey( " + _config.campaignKey.UCMD + " )";
         if(_debug.mode == VisualDebugMode.geek) {
            _debug.info(_local2 + " [UCMD]");
         } else {
            _debug.info(_local2);
         }
      }

      private function _getUniqueSessionId() : Number {
         var _local1:Number = (Utils.generate32bitRandom() ^ _generateUserDataHash()) * 2147483647;
         _debug.info("Session ID: " + _local1,VisualDebugMode.geek);
         return _local1;
      }

      private function _getDomainHash() : Number {
         if(!_config.domainName || _config.domainName == "" || _config.domain.mode == DomainNameMode.none) {
            _config.domainName = "";
            return 1;
         }
         _updateDomainName();
         if(_config.allowDomainHash) {
            return Utils.generateHash(_config.domainName);
         }
         return 1;
      }

      public function setSessionTimeout(param1:int) : void {
         _config.sessionTimeout = param1;
         _debug.info("setSessionTimeout( " + _config.sessionTimeout + " )");
      }

      public function getAccount() : String {
         _debug.info("getAccount()");
         return _account;
      }

      public function link(param1:String, param2:Boolean = false) : void {
         var targetUrl:String = param1;
         var useHash:Boolean = param2;
         _initData();
         var out:String = _buffer.getLinkerUrl(targetUrl,useHash);
         var request:URLRequest = new URLRequest(out);
         _debug.info("link( " + [targetUrl,useHash].join(",") + " )");
         try {
            navigateToURL(request,"_top");
            return;
         }
         catch(e:Error) {
            _debug.warning("An error occured in link() msg: " + e.message);
            return;
         }
      }

      public function setRemoteServerMode() : void {
         _config.serverMode = ServerOperationMode.remote;
         _debug.info("setRemoteServerMode()");
      }
   }
}
