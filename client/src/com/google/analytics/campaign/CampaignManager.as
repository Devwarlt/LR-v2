package com.google.analytics.campaign {
import com.google.analytics.core.Buffer;
import com.google.analytics.core.OrganicReferrer;
import com.google.analytics.debug.DebugConfiguration;
import com.google.analytics.debug.VisualDebugMode;
import com.google.analytics.utils.Protocols;
import com.google.analytics.utils.URL;
import com.google.analytics.utils.Variables;
import com.google.analytics.v4.Configuration;

public class CampaignManager {

      public static const trackingDelimiter:String = "|";

      private var _config:Configuration;

      private var _domainHash:Number;

      private var _debug:DebugConfiguration;

      private var _timeStamp:Number;

      private var _referrer:String;

      private var _buffer:Buffer;

      public function CampaignManager(param1:Configuration, param2:DebugConfiguration, param3:Buffer, param4:Number, param5:String, param6:Number) {
         super();
         _config = param1;
         _debug = param2;
         _buffer = param3;
         _domainHash = param4;
         _referrer = param5;
         _timeStamp = param6;
      }

      public static function isInvalidReferrer(param1:String) : Boolean {
         var _local2:URL = null;
         if(param1 == "" || param1 == "-" || param1 == "0") {
            return true;
         }
         if(param1.indexOf("://") > -1) {
            _local2 = new URL(param1);
            if(_local2.protocol == Protocols.file || _local2.protocol == Protocols.none) {
               return true;
            }
         }
         return false;
      }

      public static function isFromGoogleCSE(param1:String, param2:Configuration) : Boolean {
         var _local3:URL = new URL(param1);
         if(_local3.hostName.indexOf(param2.google) > -1) {
            if(_local3.search.indexOf(param2.googleSearchParam + "=") > -1) {
               if(_local3.path == "/" + param2.googleCsePath) {
                  return true;
               }
            }
         }
         return false;
      }

      public function getCampaignInformation(param1:String, param2:Boolean) : CampaignInfo {
         var _local4:CampaignTracker = null;
         var _local8:CampaignTracker = null;
         var _local9:int = 0;
         var _local3:CampaignInfo = new CampaignInfo();
         var _local5:* = false;
         var _local6:Boolean = false;
         var _local7:int = 0;
         if(Boolean(_config.allowLinker) && Boolean(_buffer.isGenuine())) {
            if(!_buffer.hasUTMZ()) {
               return _local3;
            }
         }
         _local4 = getTrackerFromSearchString(param1);
         if(isValid(_local4)) {
            _local6 = hasNoOverride(param1);
            if(Boolean(_local6) && !_buffer.hasUTMZ()) {
               return _local3;
            }
         }
         if(!isValid(_local4)) {
            _local4 = getOrganicCampaign();
            if(!_buffer.hasUTMZ() && Boolean(isIgnoredKeyword(_local4))) {
               return _local3;
            }
         }
         if(!isValid(_local4) && Boolean(param2)) {
            _local4 = getReferrerCampaign();
            if(!_buffer.hasUTMZ() && Boolean(isIgnoredReferral(_local4))) {
               return _local3;
            }
         }
         if(!isValid(_local4)) {
            if(!_buffer.hasUTMZ() && Boolean(param2)) {
               _local4 = getDirectCampaign();
            }
         }
         if(!isValid(_local4)) {
            return _local3;
         }
         if(Boolean(_buffer.hasUTMZ()) && !_buffer.utmz.isEmpty()) {
            _local8 = new CampaignTracker();
            _local8.fromTrackerString(_buffer.utmz.campaignTracking);
            _local5 = _local8.toTrackerString() == _local4.toTrackerString();
            _local7 = _buffer.utmz.responseCount;
         }
         if(!_local5 || Boolean(param2)) {
            _local9 = _buffer.utma.sessionCount;
            _local7++;
            if(_local9 == 0) {
               _local9 = 1;
            }
            _buffer.utmz.domainHash = _domainHash;
            _buffer.utmz.campaignCreation = _timeStamp;
            _buffer.utmz.campaignSessions = _local9;
            _buffer.utmz.responseCount = _local7;
            _buffer.utmz.campaignTracking = _local4.toTrackerString();
            _debug.info(_buffer.utmz.toString(),VisualDebugMode.geek);
            _local3 = new CampaignInfo(false,true);
         } else {
            _local3 = new CampaignInfo(false,false);
         }
         return _local3;
      }

      public function hasNoOverride(param1:String) : Boolean {
         var _local2:CampaignKey = _config.campaignKey;
         if(param1 == "") {
            return false;
         }
         var _local3:Variables = new Variables(param1);
         var _local4:String = "";
         if(_local3.hasOwnProperty(_local2.UCNO)) {
            _local4 = _local3[_local2.UCNO];
            switch(_local4) {
               case "1":
                  return true;
               case "":
               case "0":
               default:
                  return false;
            }
         } else {
            return false;
         }
      }

      public function getTrackerFromSearchString(param1:String) : CampaignTracker {
         var _local2:CampaignTracker = getOrganicCampaign();
         var _local3:CampaignTracker = new CampaignTracker();
         var _local4:CampaignKey = _config.campaignKey;
         if(param1 == "") {
            return _local3;
         }
         var _local5:Variables = new Variables(param1);
         if(_local5.hasOwnProperty(_local4.UCID)) {
            _local3.id = _local5[_local4.UCID];
         }
         if(_local5.hasOwnProperty(_local4.UCSR)) {
            _local3.source = _local5[_local4.UCSR];
         }
         if(_local5.hasOwnProperty(_local4.UGCLID)) {
            _local3.clickId = _local5[_local4.UGCLID];
         }
         if(_local5.hasOwnProperty(_local4.UCCN)) {
            _local3.name = _local5[_local4.UCCN];
         } else {
            _local3.name = "(not set)";
         }
         if(_local5.hasOwnProperty(_local4.UCMD)) {
            _local3.medium = _local5[_local4.UCMD];
         } else {
            _local3.medium = "(not set)";
         }
         if(_local5.hasOwnProperty(_local4.UCTR)) {
            _local3.term = _local5[_local4.UCTR];
         } else if(Boolean(_local2) && _local2.term != "") {
            _local3.term = _local2.term;
         }
         if(_local5.hasOwnProperty(_local4.UCCT)) {
            _local3.content = _local5[_local4.UCCT];
         }
         return _local3;
      }

      public function getOrganicCampaign() : CampaignTracker {
         var _local1:CampaignTracker = null;
         var _local4:Array = null;
         var _local5:OrganicReferrer = null;
         var _local6:String = null;
         if(Boolean(isInvalidReferrer(_referrer)) || Boolean(isFromGoogleCSE(_referrer,_config))) {
            return _local1;
         }
         var _local2:URL = new URL(_referrer);
         var _local3:String = "";
         if(_local2.hostName != "") {
            if(_local2.hostName.indexOf(".") > -1) {
               _local4 = _local2.hostName.split(".");
               switch(_local4.length) {
                  case 2:
                     _local3 = _local4[0];
                     break;
                  case 3:
                     _local3 = _local4[1];
               }
            }
         }
         if(_config.organic.match(_local3)) {
            _local5 = _config.organic.getReferrerByName(_local3);
            _local6 = _config.organic.getKeywordValue(_local5,_local2.search);
            _local1 = new CampaignTracker();
            _local1.source = _local5.engine;
            _local1.name = "(organic)";
            _local1.medium = "organic";
            _local1.term = _local6;
         }
         return _local1;
      }

      public function getDirectCampaign() : CampaignTracker {
         var _local1:CampaignTracker = new CampaignTracker();
         _local1.source = "(direct)";
         _local1.name = "(direct)";
         _local1.medium = "(none)";
         return _local1;
      }

      public function isIgnoredKeyword(param1:CampaignTracker) : Boolean {
         if(Boolean(param1) && param1.medium == "organic") {
            return _config.organic.isIgnoredKeyword(param1.term);
         }
         return false;
      }

      public function isIgnoredReferral(param1:CampaignTracker) : Boolean {
         if(Boolean(param1) && param1.medium == "referral") {
            return _config.organic.isIgnoredReferral(param1.source);
         }
         return false;
      }

      public function isValid(param1:CampaignTracker) : Boolean {
         if(Boolean(param1) && Boolean(param1.isValid())) {
            return true;
         }
         return false;
      }

      public function getReferrerCampaign() : CampaignTracker {
         var _local1:CampaignTracker = null;
         if(Boolean(isInvalidReferrer(_referrer)) || Boolean(isFromGoogleCSE(_referrer,_config))) {
            return _local1;
         }
         var _local2:URL = new URL(_referrer);
         var _local3:String = _local2.hostName;
         var _local4:String = _local2.path;
         if(_local3.indexOf("www.") == 0) {
            _local3 = _local3.substr(4);
         }
         _local1 = new CampaignTracker();
         _local1.source = _local3;
         _local1.name = "(referral)";
         _local1.medium = "referral";
         _local1.content = _local4;
         return _local1;
      }
   }
}
