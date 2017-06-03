package com.company.assembleegameclient.LOEBUILD_1f4c42c309fe6bc45253d598cfdf9b99 {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;
import kabam.rotmg.assets.model.Player;
import com.company.assembleegameclient.ui.dialogs.TOSPopup;

import flash.events.Event;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.promotions.model.BeginnersPackageModel;
import kabam.rotmg.servers.api.LatLong;

import org.swiftsuspenders.Injector;

public class LOEBUILOD_1839b10431d757564a37f7352035160a extends Event {

      public static const SAVED_CHARS_LIST:String = "SAVED_CHARS_LIST";

      public static const AVAILABLE:String = "available";

      public static const UNAVAILABLE:String = "unavailable";

      public static const UNRESTRICTED:String = "unrestricted";

      private static const DEFAULT_LATLONG:LatLong = new LatLong(37.4436,-122.412);

      private static const DEFAULT_SALESFORCE:String = "unavailable";

      private var origData_:String;

      private var charsXML_:XML;

      public var accountId_:String;

      public var nextCharId_:int;

      public var maxNumChars_:int;

      public var numChars_:int = 0;

      public var savedChars_:Vector.<LOEBUILD_7ebef6bdf3535c86294f666e62e89578>;

      public var charStats_:Object;

      public var totalFame_:int = 0;

      public var fame_:int = 0;

      public var credits_:int = 0;

      public var tokens_:int = 0;

      public var numStars_:int = 0;

      public var nextCharSlotPrice_:int;

      public var guildName_:String;

      public var guildRank_:int;

      public var name_:String = null;

      public var nameChosen_:Boolean;

      public var converted_:Boolean;

      public var isAdmin_:Boolean;

      public var news_:Vector.<LOEBUILD_7ef38360d46d56d4f3d5cdf71860fef5>;

      public var myPos_:LatLong;

      public var salesForceData_:String = "unavailable";

      public var hasPlayerDied:Boolean = false;

      public var classAvailability:Object;

      public var isAgeVerified:Boolean;

      private var account:Account;

      public function LOEBUILOD_1839b10431d757564a37f7352035160a(param1:String) {
         var _local4:*;
         var _local5:Account;
         this.savedChars_ = new Vector.<LOEBUILD_7ebef6bdf3535c86294f666e62e89578>();
         this.charStats_ = {};
         this.news_ = new Vector.<LOEBUILD_7ef38360d46d56d4f3d5cdf71860fef5>();
         super(SAVED_CHARS_LIST);
         this.origData_ = param1;
         this.charsXML_ = new XML(this.origData_);
         var _local2:XML = XML(this.charsXML_.Account);
         this.parseUserData(_local2);
         this.parseBeginnersPackageData(_local2);
         this.parseGuildData(_local2);
         this.parseCharacterData();
         this.parseCharacterStatsData();
         this.parseNewsData();
         this.parseGeoPositioningData();
         this.parseSalesForceData();
         this.parseTOSPopup();
         this.reportUnlocked();
         var _local3:Injector = StaticInjectorContext.getInjector();
         if(_local3) {
            _local5 = _local3.getInstance(Account);
            _local5.reportIntStat("BestLevel",this.bestOverallLevel());
            _local5.reportIntStat("BestFame",this.bestOverallFame());
            _local5.reportIntStat("NumStars",this.numStars_);
            _local5.verify(_local2.hasOwnProperty("VerifiedEmail"));
         }
         this.classAvailability = new Object();
         for each(_local4 in this.charsXML_.ClassAvailabilityList.ClassAvailability) {
            this.classAvailability[_local4.@id.toString()] = _local4.toString();
         }
      }

      public function getCharById(param1:int) : LOEBUILD_7ebef6bdf3535c86294f666e62e89578 {
         var _local2:LOEBUILD_7ebef6bdf3535c86294f666e62e89578;
         for each(_local2 in this.savedChars_) {
            if(_local2.charId() == param1) {
               return _local2;
            }
         }
         return null;
      }

      private function parseUserData(param1:XML) : void {
         this.accountId_ = param1.AccountId;
         this.name_ = param1.Name;
         this.nameChosen_ = param1.hasOwnProperty("NameChosen");
         this.converted_ = param1.hasOwnProperty("Converted");
         this.isAdmin_ = param1.hasOwnProperty("Admin");
         Player.isAdmin = this.isAdmin_;
         this.totalFame_ = int(param1.Stats.TotalFame);
         this.fame_ = int(param1.Stats.Fame);
         this.credits_ = int(param1.Credits);
         this.tokens_ = int(param1.FortuneToken);
         this.nextCharSlotPrice_ = int(param1.NextCharSlotPrice);
         this.isAgeVerified = this.accountId_ != "" && param1.IsAgeVerified == 1;
         this.hasPlayerDied = true;
      }

      private function parseBeginnersPackageData(param1:XML) : void {
         var _local2:Number;
         var _local3:BeginnersPackageModel;
         if(param1.hasOwnProperty("BeginnerPackageTimeLeft")) {
            _local2 = param1.BeginnerPackageTimeLeft;
            _local3 = this.getBeginnerModel();
            _local3.setBeginnersOfferSecondsLeft(_local2);
         }
      }

      private function getBeginnerModel() : BeginnersPackageModel {
         var _local1:Injector = StaticInjectorContext.getInjector();
         var _local2:BeginnersPackageModel = _local1.getInstance(BeginnersPackageModel);
         return _local2;
      }

      private function parseGuildData(param1:XML) : void {
         var _local2:XML;
         if(param1.hasOwnProperty("Guild")) {
            _local2 = XML(param1.Guild);
            this.guildName_ = _local2.Name;
            this.guildRank_ = int(_local2.Rank);
         }
      }

      private function parseCharacterData() : void {
         var _local1:XML;
         this.nextCharId_ = int(this.charsXML_.@nextCharId);
         this.maxNumChars_ = int(this.charsXML_.@maxNumChars);
         for each(_local1 in this.charsXML_.Char) {
            this.savedChars_.push(new LOEBUILD_7ebef6bdf3535c86294f666e62e89578(_local1,this.name_));
            this.numChars_++;
         }
         this.savedChars_.sort(LOEBUILD_7ebef6bdf3535c86294f666e62e89578.compare);
      }

      private function parseCharacterStatsData() : void {
         var _local2:XML;
         var _local3:int;
         var _local4:LOEBUILD_9ef2cbbbd6e1617e4401a08c93ad0f9c;
         var _local1:XML = XML(this.charsXML_.Account.Stats);
         for each(_local2 in _local1.ClassStats) {
            _local3 = int(_local2.@objectType);
            _local4 = new LOEBUILD_9ef2cbbbd6e1617e4401a08c93ad0f9c(_local2);
            this.numStars_ = this.numStars_ + _local4.numStars();
            this.charStats_[_local3] = _local4;
         }
      }

      private function parseNewsData() : void {
         var _local2:XML;
         var _local1:XML = XML(this.charsXML_.News);
         for each(_local2 in _local1.Item) {
            this.news_.push(new LOEBUILD_7ef38360d46d56d4f3d5cdf71860fef5(_local2.Icon,_local2.Title,_local2.TagLine,_local2.Link,int(_local2.Date)));
         }
      }

      private function parseGeoPositioningData() : void {
         if(Boolean(this.charsXML_.hasOwnProperty("Lat")) && Boolean(this.charsXML_.hasOwnProperty("Long"))) {
            this.myPos_ = new LatLong(Number(this.charsXML_.Lat),Number(this.charsXML_.Long));
         } else {
            this.myPos_ = DEFAULT_LATLONG;
         }
      }

      private function parseSalesForceData() : void {
         if(Boolean(this.charsXML_.hasOwnProperty("SalesForce")) && Boolean(this.charsXML_.hasOwnProperty("SalesForce"))) {
            this.salesForceData_ = String(this.charsXML_.SalesForce);
         }
      }

      private function parseTOSPopup() : void {
         if(this.charsXML_.hasOwnProperty("TOSPopup")) {
            StaticInjectorContext.getInjector().getInstance(OpenDialogSignal).dispatch(new TOSPopup());
         }
      }

      public function bestLevel(param1:int) : int {
         var _local2:LOEBUILD_9ef2cbbbd6e1617e4401a08c93ad0f9c = this.charStats_[param1];
         return _local2 == null?0:int(_local2.bestLevel());
      }

      public function bestOverallLevel() : int {
         var _local2:LOEBUILD_9ef2cbbbd6e1617e4401a08c93ad0f9c;
         var _local1:int = 0;
         for each(_local2 in this.charStats_) {
            if(_local2.bestLevel() > _local1) {
               _local1 = _local2.bestLevel();
            }
         }
         return _local1;
      }

      public function bestFame(param1:int) : int {
         var _local2:LOEBUILD_9ef2cbbbd6e1617e4401a08c93ad0f9c = this.charStats_[param1];
         return _local2 == null?0:int(_local2.bestFame());
      }

      public function bestOverallFame() : int {
         var _local2:LOEBUILD_9ef2cbbbd6e1617e4401a08c93ad0f9c;
         var _local1:int = 0;
         for each(_local2 in this.charStats_) {
            if(_local2.bestFame() > _local1) {
               _local1 = _local2.bestFame();
            }
         }
         return _local1;
      }

      public function levelRequirementsMet(param1:int) : Boolean {
         var _local3:XML;
         var _local4:int;
         var _local2:XML = LOEBUILD_efda783509bc93eea698457c87bbee3f.xmlLibrary_[param1];
         for each(_local3 in _local2.UnlockLevel) {
            _local4 = LOEBUILD_efda783509bc93eea698457c87bbee3f.idToType_[_local3.toString()];
            if(this.bestLevel(_local4) < int(_local3.@level)) {
               return false;
            }
         }
         return true;
      }

      public function availableCharSlots() : int {
         return this.maxNumChars_ - this.numChars_;
      }

      public function hasAvailableCharSlot() : Boolean {
         return this.numChars_ < this.maxNumChars_;
      }

      public function newUnlocks(param1:int, param2:int) : Array {
         var _local5:XML;
         var _local6:int = 0;
         var _local7:Boolean;
         var _local8:Boolean;
         var _local9:XML;
         var _local10:int = 0;
         var _local11:int = 0;
         var _local3:Array = new Array();
         var _local4:int = 0;
         while(_local4 < LOEBUILD_efda783509bc93eea698457c87bbee3f.playerChars_.length) {
            _local5 = LOEBUILD_efda783509bc93eea698457c87bbee3f.playerChars_[_local4];
            _local6 = int(_local5.@type);
            if(!this.levelRequirementsMet(_local6)) {
               _local7 = true;
               _local8 = false;
               for each(_local9 in _local5.UnlockLevel) {
                  _local10 = LOEBUILD_efda783509bc93eea698457c87bbee3f.idToType_[_local9.toString()];
                  _local11 = int(_local9.@level);
                  if(this.bestLevel(_local10) < _local11) {
                     if(_local10 != param1 || _local11 != param2) {
                        _local7 = false;
                        break;
                     }
                     _local8 = true;
                  }
               }
               if(Boolean(_local7) && Boolean(_local8)) {
                  _local3.push(_local6);
               }
            }
            _local4++;
         }
         return _local3;
      }

      override public function clone() : Event {
         return new LOEBUILOD_1839b10431d757564a37f7352035160a(this.origData_);
      }

      override public function toString() : String {
         return "[" + " numChars: " + this.numChars_ + " maxNumChars: " + this.maxNumChars_ + " ]";
      }

      private function reportUnlocked() : void {
         var _local1:Injector = StaticInjectorContext.getInjector();
         if(_local1) {
            this.account = _local1.getInstance(Account);
            this.account && this.updateAccount();
         }
      }

      private function updateAccount() : void {
         var _local3:XML;
         var _local4:int = 0;
         var _local1:int = 0;
         var _local2:int = 0;
         while(_local2 < LOEBUILD_efda783509bc93eea698457c87bbee3f.playerChars_.length) {
            _local3 = LOEBUILD_efda783509bc93eea698457c87bbee3f.playerChars_[_local2];
            _local4 = int(_local3.@type);
            if(this.levelRequirementsMet(_local4)) {
               this.account.reportIntStat(_local3.@id + "Unlocked",1);
               _local1++;
            }
            _local2++;
         }
         this.account.reportIntStat("ClassesUnlocked",_local1);
      }
   }
}
