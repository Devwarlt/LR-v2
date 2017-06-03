package kabam.rotmg.core.service {
import com.company.assembleegameclient.LOEBUILD_1f4c42c309fe6bc45253d598cfdf9b99.LOEBUILOD_1839b10431d757564a37f7352035160a;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.util.MoreObjectUtil;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.core.model.PlayerModel;

import robotlegs.bender.framework.api.ILogger;

public class PurchaseCharacterClassTask extends BaseTask {

      [Inject]
      public var classType:int;

      [Inject]
      public var account:Account;

      [Inject]
      public var client:AppEngineClient;

      [Inject]
      public var playerModel:PlayerModel;

      [Inject]
      public var logger:ILogger;

      public function PurchaseCharacterClassTask() {
         super();
      }

      override protected function startTask() : void {
         this.logger.info("PurchaseCharacterClassTask.startTask: Started ");
         this.client.complete.addOnce(this.onComplete);
         this.client.sendRequest("/char/purchaseClassUnlock",this.makeRequestPacket());
      }

      public function makeRequestPacket() : Object {
         var _local1:Object = {};
         _local1.game_net_user_id = this.account.gameNetworkUserId();
         _local1.game_net = this.account.gameNetwork();
         _local1.play_platform = this.account.playPlatform();
         _local1.do_login = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.sendLogin_;
         _local1.classType = this.classType;
         MoreObjectUtil.addToObject(_local1,this.account.getCredentials());
         return _local1;
      }

      private function onComplete(param1:Boolean, param2:*) : void {
         this.logger.info("PurchaseCharacterClassTask.onComplete: Ended ");
         param1 && this.onReceiveResponseFromClassPurchase();
         completeTask(param1,param2);
      }

      private function onReceiveResponseFromClassPurchase() : void {
         this.playerModel.setClassAvailability(this.classType,LOEBUILOD_1839b10431d757564a37f7352035160a.UNRESTRICTED);
         completeTask(true);
      }
   }
}
