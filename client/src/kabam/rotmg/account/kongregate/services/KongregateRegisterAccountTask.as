package kabam.rotmg.account.kongregate.services {
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.services.RegisterAccountTask;
import kabam.rotmg.account.kongregate.view.KongregateApi;
import kabam.rotmg.account.web.model.AccountData;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.core.service.TrackingData;
import kabam.rotmg.core.signals.TrackEventSignal;

public class KongregateRegisterAccountTask extends BaseTask implements RegisterAccountTask {

      [Inject]
      public var data:AccountData;

      [Inject]
      public var api:KongregateApi;

      [Inject]
      public var account:Account;

      [Inject]
      public var track:TrackEventSignal;

      [Inject]
      public var client:AppEngineClient;

      public function KongregateRegisterAccountTask() {
         super();
      }

      override protected function startTask() : void {
         this.client.setMaxRetries(2);
         this.client.complete.addOnce(this.onComplete);
         this.client.sendRequest("/kongregate/register",this.makeDataPacket());
      }

      private function onComplete(param1:Boolean, param2:*) : void {
         param1 && this.onInternalRegisterDone(param2);
         completeTask(param1,param2);
      }

      private function makeDataPacket() : Object {
         var _local1:Object = this.api.getAuthentication();
         _local1.newGUID = this.data.username;
         _local1.newPassword = this.data.password;
         _local1.entrytag = this.account.getEntryTag();
         return _local1;
      }

      private function onInternalRegisterDone(param1:String) : void {
         this.updateAccount(param1);
         this.trackAccountRegistration();
      }

      private function trackAccountRegistration() : void {
         var _local1:TrackingData = new TrackingData();
         _local1.category = "kongregateAccount";
         _local1.action = "accountRegistered";
         this.track.dispatch(_local1);
      }

      private function updateAccount(param1:String) : void {
         var _local2:XML = new XML(param1);
         this.account.updateUser(_local2.GUID,_local2.Secret);
         this.account.setPlatformToken(_local2.PlatformToken);
      }
   }
}
