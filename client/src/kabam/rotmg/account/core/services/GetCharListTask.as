package kabam.rotmg.account.core.services {
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.util.MoreObjectUtil;

import flash.events.TimerEvent;
import flash.utils.Timer;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.signals.CharListDataSignal;
import kabam.rotmg.account.web.view.MigrationDialog;
import kabam.rotmg.account.web.view.WebLoginDialog;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.core.signals.SetLoadingMessageSignal;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.fortune.components.TimerCallback;
import kabam.rotmg.text.model.TextKey;

import robotlegs.bender.framework.api.ILogger;

public class GetCharListTask extends BaseTask {

      private static const ONE_SECOND_IN_MS:int = 1000;

      private static const MAX_RETRIES:int = 100;

      [Inject]
      public var account:Account;

      [Inject]
      public var client:AppEngineClient;

      [Inject]
      public var model:PlayerModel;

      [Inject]
      public var setLoadingMessage:SetLoadingMessageSignal;

      [Inject]
      public var charListData:CharListDataSignal;

      [Inject]
      public var logger:ILogger;

      [Inject]
      public var openDialog:OpenDialogSignal;

      [Inject]
      public var closeDialogs:CloseDialogsSignal;

      private var requestData:Object;

      private var retryTimer:Timer;

      private var numRetries:int = 0;

    private var countRetries:int = 0;

      private var fromMigration:Boolean = false;

      public function GetCharListTask() {
         super();
      }

      override protected function startTask() : void {
         this.logger.info("GetUserDataTask start");
         this.requestData = this.makeRequestData();
         this.sendRequest();
         LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.sendLogin_ = false;
      }

      private function sendRequest() : void {
         this.client.complete.addOnce(this.onComplete);
         this.client.sendRequest("/char/list",this.requestData);
      }

      private function onComplete(param1:Boolean, param2:*) : void {
         if(param1) {
            this.onListComplete(param2);
         } else {
            this.onTextError(param2);
         }
      }

      public function makeRequestData() : Object {
         var _local1:Object = {};
         _local1.game_net_user_id = this.account.gameNetworkUserId();
         _local1.game_net = this.account.gameNetwork();
         _local1.play_platform = this.account.playPlatform();
         _local1.do_login = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.sendLogin_;
         MoreObjectUtil.addToObject(_local1,this.account.getCredentials());
         return _local1;
      }

      private function onListComplete(param1:String) : void {
         var _local3:Number = NaN;
         var _local4:MigrationDialog = null;
         var _local2:XML = new XML(param1);
         if(_local2.hasOwnProperty("MigrateStatus")) {
            _local3 = _local2.MigrateStatus;
            if(_local3 == 5) {
               this.sendRequest();
            }
            _local4 = new MigrationDialog(this.account,_local3);
            this.fromMigration = true;
            _local4.done.addOnce(this.sendRequest);
            _local4.cancel.addOnce(this.clearAccountAndReloadCharacters);
            this.openDialog.dispatch(_local4);
         } else {
            this.charListData.dispatch(XML(param1));
            completeTask(true);
         }
         if(this.retryTimer != null) {
            this.stopRetryTimer();
         }
      }

      private function onTextError(param1:String) : void {
         var _local2:WebLoginDialog = null;
          var _local3:WebLoginDialog = null;
         this.setLoadingMessage.dispatch("error.loadError");
         if(param1 == "Account credentials not valid") {
            if(this.fromMigration) {
               _local2 = new WebLoginDialog();
               _local2.setError(TextKey.WEB_LOGIN_DIALOG_PASSWORD_INVALID);
               _local2.setEmail(this.account.getUserId());
               StaticInjectorContext.getInjector().getInstance(OpenDialogSignal).dispatch(_local2);
            }
            this.clearAccountAndReloadCharacters();
         } else if(param1 == "Account is under maintenance") {
             _local3 = new WebLoginDialog();
             _local3.setError("This account has been banned!");
            this.setLoadingMessage.dispatch("This account has been banned!");
            new TimerCallback(5,this.clearAccountAndReloadCharacters);
         } else {
            this.waitForASecondThenRetryRequest();
         }
      }

      private function clearAccountAndReloadCharacters() : void {
          this.numRetries++;
          countRetries = numRetries;
         this.logger.info("GetUserDataTask invalid credentials");
         this.account.clear();
         this.client.complete.addOnce(this.onComplete);
         this.requestData = this.makeRequestData();
         this.client.sendRequest("/char/list",this.requestData);
      }

      private function waitForASecondThenRetryRequest() : void {
         this.logger.info("LoE Realm server is restarting, please wait...");
         this.retryTimer = new Timer(ONE_SECOND_IN_MS,1);
         this.retryTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onRetryTimer);
         this.retryTimer.start();
      }

      private function stopRetryTimer() : void {
         this.retryTimer.stop();
         this.retryTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onRetryTimer);
         this.retryTimer = null;
      }

      private function onRetryTimer(param1:TimerEvent) : void {
         this.stopRetryTimer();
         if(this.numRetries < MAX_RETRIES) {
            this.sendRequest();
            this.numRetries++;
             countRetries = numRetries;
             this.setLoadingMessage.dispatch("Attempt " + countRetries + " of " + MAX_RETRIES + " to connect you, please wait...");
         } else {
            this.clearAccountAndReloadCharacters();
            this.setLoadingMessage.dispatch("LoE Realm server is restarting, please wait...");
         }
      }
   }
}
