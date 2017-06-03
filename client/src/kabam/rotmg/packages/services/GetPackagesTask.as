package kabam.rotmg.packages.services {
import flash.events.TimerEvent;
import flash.utils.Timer;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.language.model.LanguageModel;
import kabam.rotmg.packages.model.PackageInfo;

import robotlegs.bender.framework.api.ILogger;

public class GetPackagesTask extends BaseTask {

      private static const HOUR:int = 1000 * 60 * 60;

      public var timer:Timer;

      [Inject]
      public var client:AppEngineClient;

      [Inject]
      public var packageModel:PackageModel;

      [Inject]
      public var account:Account;

      [Inject]
      public var logger:ILogger;

      [Inject]
      public var languageModel:LanguageModel;

      public function GetPackagesTask() {
         this.timer = new Timer(HOUR);
         super();
      }

      override protected function startTask() : void {
         var _local1:Object = this.account.getCredentials();
         _local1.language = this.languageModel.getLanguage();
         this.client.sendRequest("/package/getPackages",_local1);
         this.client.complete.addOnce(this.onComplete);
      }

      private function onComplete(param1:Boolean, param2:*) : void {
         if(param1) {
            this.handleOkay(param2);
         } else {
            this.logger.warn("GetPackageTask.onComplete: Request failed.");
            completeTask(false);
         }
      }

      private function handleOkay(param1:*) : void {
         var _local2:XML = null;
         if(this.hasNoPackage(param1)) {
            this.logger.info("GetPackageTask.onComplete: No package available, retrying in 1 hour.");
            this.timer.addEventListener(TimerEvent.TIMER,this.timer_timerHandler);
            this.timer.start();
            this.packageModel.setPackages([]);
         } else {
            _local2 = XML(param1);
            this.parse(_local2);
         }
         completeTask(true);
      }

      private function hasNoPackage(param1:*) : Boolean {
         var _local2:XMLList = XML(param1).Packages;
         var _local3:* = _local2.length() == 0;
         return _local3;
      }

      private function parse(param1:XML) : void {
         var _local3:XML = null;
         var _local4:int = 0;
         var _local5:String = null;
         var _local6:int = 0;
         var _local7:int = 0;
         var _local8:int = 0;
         var _local9:int = 0;
         var _local10:Date = null;
         var _local11:String = null;
         var _local12:int = 0;
         var _local13:PackageInfo = null;
         var _local2:Array = [];
         for each(_local3 in param1.Packages.Package) {
            _local4 = int(_local3.@id);
            _local5 = String(_local3.Name);
            _local6 = int(_local3.Price);
            _local7 = int(_local3.Quantity);
            _local8 = int(_local3.MaxPurchase);
            _local9 = int(_local3.Weight);
            _local10 = new Date(String(_local3.EndDate));
            _local11 = String(_local3.BgURL);
            _local12 = this.getNumPurchased(param1,_local4);
            _local13 = new PackageInfo();
            _local13.setData(_local4,_local10,_local5,_local7,_local8,_local9,_local6,_local11,_local12);
            _local2.push(_local13);
         }
         this.packageModel.setPackages(_local2);
      }

      private function getNumPurchased(param1:XML, param2:int) : int {
         var packageHistory:XMLList = null;
         var packagesXML:XML = param1;
         var packageID:int = param2;
         var numPurchased:int = 0;
         var history:XMLList = packagesXML.History;
         if(history) {
            packageHistory = history.Package.(@id == packageID);
            if(packageHistory) {
               numPurchased = int(packageHistory.Count);
            }
         }
         return numPurchased;
      }

      private function timer_timerHandler(param1:TimerEvent) : void {
         this.timer.removeEventListener(TimerEvent.TIMER,this.timer_timerHandler);
         this.timer.stop();
         this.startTask();
      }
   }
}
