package kabam.rotmg.packages.services {
import com.company.assembleegameclient.map.LOEBUILD_a2df85b914fd649750056f699bc0d502;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.packages.control.BuyPackageSuccessfulSignal;
import kabam.rotmg.packages.model.PackageInfo;
import kabam.rotmg.text.model.TextKey;

public class BuyPackageTask extends BaseTask {

      private static const ERROR_MESSAGES_THAT_REFRESH:Array = ["Package is not Available","Package is not Available Right Now","Invalid PackageId"];

      [Inject]
      public var client:AppEngineClient;

      [Inject]
      public var account:Account;

      [Inject]
      public var getPackageTask:GetPackagesTask;

      [Inject]
      public var playerModel:PlayerModel;

      [Inject]
      public var queueStatusText:LOEBUILD_a2df85b914fd649750056f699bc0d502;

      [Inject]
      public var packageInfo:PackageInfo;

      [Inject]
      public var buyPackageSuccessful:BuyPackageSuccessfulSignal;

      public function BuyPackageTask() {
         super();
      }

      override protected function startTask() : void {
         var _local1:Object = this.account.getCredentials();
         _local1.packageId = this.packageInfo.packageID;
         this.playerModel.changeCredits(-this.packageInfo.price);
         this.client.complete.addOnce(this.onComplete);
         this.client.sendRequest("/account/purchasePackage",_local1);
      }

      private function onComplete(param1:Boolean, param2:*) : void {
         var _local3:XML = new XML(param2);
         if(param1) {
            this.completePurchase(_local3);
         } else {
            this.abandonPurchase(_local3);
         }
         completeTask(true,param2);
      }

      private function completePurchase(param1:XML) : void {
         if(this.packageInfo.quantity != PackageInfo.INFINITE) {
            this.packageInfo.quantity--;
         }
         this.packageInfo.numPurchased++;
         this.queueStatusText.dispatch(TextKey.BUYPACKAGETASK_NEWGIFTS,11495650);
         this.buyPackageSuccessful.dispatch();
         if(this.packageInfo.quantity <= 0) {
            this.getPackageTask.start();
         }
      }

      private function abandonPurchase(param1:XML) : void {
         this.playerModel.changeCredits(this.packageInfo.price);
         this.reportFailureAndRefreshPackages(param1[0]);
      }

      private function reportFailureAndRefreshPackages(param1:String) : void {
         this.queueStatusText.dispatch(param1,16744576);
         if(ERROR_MESSAGES_THAT_REFRESH.indexOf(param1) != -1) {
            this.getPackageTask.start();
         }
      }
   }
}
