package kabam.rotmg.mysterybox.services {
import com.company.assembleegameclient.util.TimeUtil;

import flash.utils.getTimer;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.application.DynamicSettings;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.fortune.model.FortuneInfo;
import kabam.rotmg.fortune.services.FortuneModel;
import kabam.rotmg.language.model.LanguageModel;
import kabam.rotmg.mysterybox.model.MysteryBoxInfo;

import robotlegs.bender.framework.api.ILogger;

public class GetMysteryBoxesTask extends BaseTask {

      private static const TEN_MINUTES:int = 600;

      private static var version:String = "0";

      [Inject]
      public var client:AppEngineClient;

      [Inject]
      public var mysteryBoxModel:MysteryBoxModel;

      [Inject]
      public var fortuneModel:FortuneModel;

      [Inject]
      public var account:Account;

      [Inject]
      public var logger:ILogger;

      [Inject]
      public var languageModel:LanguageModel;

      [Inject]
      public var openDialogSignal:OpenDialogSignal;

      public var lastRan:uint = 0;

      public function GetMysteryBoxesTask() {
         super();
      }

      override protected function startTask() : void {
         var _local1:Number = NaN;
         var _local2:Object = null;
         if(DynamicSettings.settingExists("MysteryBoxRefresh")) {
            _local1 = DynamicSettings.getSettingValue("MysteryBoxRefresh");
         } else {
            _local1 = TEN_MINUTES;
         }
         if(this.lastRan == 0 || this.lastRan + _local1 < getTimer() / 1000) {
            this.lastRan = getTimer() / 1000;
            completeTask(true);
            _local2 = this.account.getCredentials();
            _local2.language = this.languageModel.getLanguage();
            _local2.version = version;
            this.client.sendRequest("/mysterybox/getBoxes",_local2);
            this.client.complete.addOnce(this.onComplete);
         } else {
            completeTask(true);
            reset();
         }
      }

      public function clearLastRanBlock() : void {
         this.lastRan = 0;
      }

      private function onComplete(param1:Boolean, param2:*) : void {
         reset();
         if(param1) {
            this.handleOkay(param2);
         } else {
            this.logger.warn("GetPackageTask.onComplete: Request failed.");
            completeTask(false);
         }
      }

      private function handleOkay(param1:*) : void {
         var _local2:XMLList = null;
         var _local3:XMLList = null;
         if(this.hasNoBoxes(param1)) {
            if(this.mysteryBoxModel.isInitialized()) {
               return;
            }
            this.mysteryBoxModel.setInitialized(false);
         } else {
            version = XML(param1).attribute("version").toString();
            _local2 = XML(param1).child("MysteryBox");
            this.parse(_local2);
            _local3 = XML(param1).child("FortuneGame");
            if(_local3.length() > 0) {
               this.parseFortune(_local3);
            }
         }
         completeTask(true);
      }

      private function hasNoBoxes(param1:*) : Boolean {
         var _local2:XMLList = XML(param1).children();
         var _local3:* = _local2.length() == 0;
         return _local3;
      }

      private function parseFortune(param1:XMLList) : void {
         var _local2:FortuneInfo = new FortuneInfo();
         _local2.id = param1.attribute("id").toString();
         _local2.title = param1.attribute("title").toString();
         _local2.weight = param1.attribute("weight").toString();
         _local2.description = param1.Description.toString();
         _local2.contents = param1.Contents.toString();
         _local2.priceFirstInGold = param1.Price.attribute("firstInGold").toString();
         _local2.priceFirstInToken = param1.Price.attribute("firstInToken").toString();
         _local2.priceSecondInGold = param1.Price.attribute("secondInGold").toString();
         _local2.iconImageUrl = param1.Icon.toString();
         _local2.infoImageUrl = param1.Image.toString();
         _local2.startTime = TimeUtil.parseUTCDate(param1.StartTime.toString());
         _local2.endTime = TimeUtil.parseUTCDate(param1.EndTime.toString());
         _local2.parseContents();
         this.fortuneModel.setFortune(_local2);
      }

      private function parse(param1:XMLList) : void {
         var _local4:XML = null;
         var _local5:MysteryBoxInfo = null;
         var _local2:Array = [];
         var _local3:Boolean = false;
         for each(_local4 in param1) {
            _local5 = new MysteryBoxInfo();
            _local5.id = _local4.attribute("id").toString();
            _local5.title = _local4.attribute("title").toString();
            _local5.weight = _local4.attribute("weight").toString();
            _local5.description = _local4.Description.toString();
            _local5.contents = _local4.Contents.toString();
            _local5.priceAmount = _local4.Price.attribute("amount").toString();
            _local5.priceCurrency = _local4.Price.attribute("currency").toString();
            if(_local4.hasOwnProperty("Sale")) {
               _local5.saleAmount = _local4.Sale.attribute("price").toString();
               _local5.saleCurrency = _local4.Sale.attribute("currency").toString();
               _local5.saleEnd = TimeUtil.parseUTCDate(_local4.Sale.End.toString());
            }
            _local5.iconImageUrl = _local4.Icon.toString();
            _local5.infoImageUrl = _local4.Image.toString();
            _local5.startTime = TimeUtil.parseUTCDate(_local4.StartTime.toString());
            _local5.parseContents();
            if(!_local3 && (Boolean(_local5.isNew()) || Boolean(_local5.isOnSale()))) {
               _local3 = true;
            }
            _local2.push(_local5);
         }
         this.mysteryBoxModel.setMysetryBoxes(_local2);
         this.mysteryBoxModel.isNew = _local3;
      }
   }
}
