package kabam.rotmg.ui.view {
import com.company.assembleegameclient.LOEBUILD_96062b2d312b581d94ca7a4e277ffe2a.LOEBUILD_81ade24e8daf8d0d9cbf110052ac9011;
import com.company.assembleegameclient.screens.ServersScreen;
import com.company.assembleegameclient.ui.language.LanguageOptionOverlay;

import flash.events.Event;
import flash.external.ExternalInterface;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;
import flash.net.navigateToURL;
import flash.system.Capabilities;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.signals.OpenAccountInfoSignal;
import kabam.rotmg.application.DynamicSettings;
import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.core.signals.SetScreenSignal;
import kabam.rotmg.core.signals.SetScreenWithValidDataSignal;
import kabam.rotmg.core.view.Layers;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.legends.view.LegendsView;
import kabam.rotmg.ui.model.EnvironmentData;
import kabam.rotmg.ui.signals.EnterGameSignal;

import robotlegs.bender.bundles.mvcs.Mediator;
import robotlegs.bender.framework.api.ILogger;

public class TitleMediator extends Mediator {

      private static var supportCalledBefore:Boolean = false;

      [Inject]
      public var view:TitleView;

      [Inject]
      public var account:Account;

      [Inject]
      public var playerModel:PlayerModel;

      [Inject]
      public var setScreen:SetScreenSignal;

      [Inject]
      public var setScreenWithValidData:SetScreenWithValidDataSignal;

      [Inject]
      public var enterGame:EnterGameSignal;

      [Inject]
      public var openAccountInfo:OpenAccountInfoSignal;

      [Inject]
      public var openDialog:OpenDialogSignal;

      [Inject]
      public var setup:ApplicationSetup;

      [Inject]
      public var layers:Layers;

      [Inject]
      public var logger:ILogger;

      public function TitleMediator() {
         super();
      }

      override public function initialize() : void {
         this.view.optionalButtonsAdded.add(this.onOptionalButtonsAdded);
         this.view.initialize(this.makeEnvironmentData());
         this.view.playClicked.add(this.handleIntentionToPlay);
         this.view.serversClicked.add(this.showServersScreen);
         this.view.accountClicked.add(this.handleIntentionToReviewAccount);
         // update 7.32.451X
          // this.view.legendsClicked.add(this.showLegendsScreen);
         this.view.supportClicked.add(this.openSupportPage);
         this.view.kabamTransferClicked;//.add(this.openKabamTransferView);
      }

      private function openSupportPage() : void {
          var _local1 = new URLRequest("http://loerealm.com/theserver/donate");
          navigateToURL(_local1,"_blank");
         /*var _local1:URLVariables = new URLVariables();
         var _local2:URLRequest = new URLRequest();
         var _local3:Boolean = false;
         if(Boolean(DynamicSettings.settingExists("SalesforceMobile")) && DynamicSettings.getSettingValue("SalesforceMobile") == 1) {
            _local3 = true;
         }
         var _local4:String = this.playerModel.getSalesForceData();
         if(_local4 == "unavailable" || !_local3) {
            _local1.language = "en_US";
            _local1.game = "a0Za000000jIBFUEA4";
            _local1.issue = "Other_Game_Issues";
            _local2.url = "http://rotmg.decagames.io";
            _local2.method = URLRequestMethod.GET;
            _local2.data = _local1;
            navigateToURL(_local2,"_blank");
         } else if(Capabilities.playerType == "PlugIn" || Capabilities.playerType == "ActiveX") {
            if(!supportCalledBefore) {
               ExternalInterface.call("openSalesForceFirstTime",_local4);
               supportCalledBefore = true;
            } else {
               ExternalInterface.call("reopenSalesForce");
            }
         } else {
            _local1.data = _local4;
            _local2.url = "http://rotmg.decagames.io";
            _local2.method = URLRequestMethod.GET;
            _local2.data = _local1;
            navigateToURL(_local2,"_blank");
         }*/
      }

      private function onOptionalButtonsAdded() : void {
         this.view.editorClicked && this.view.editorClicked.add(this.showMapEditor);
         this.view.quitClicked && this.view.quitClicked.add(this.attemptToCloseClient);
      }

      private function showLanguagesScreen() : void {
         this.setScreen.dispatch(new LanguageOptionOverlay());
      }

      private function makeEnvironmentData() : EnvironmentData {
         var _local1:EnvironmentData = new EnvironmentData();
         _local1.isDesktop = Capabilities.playerType == "Desktop";
         _local1.isAdmin = this.playerModel.isAdmin();
         _local1.buildLabel = this.setup.getBuildLabel();
         return _local1;
      }

      override public function destroy() : void {
         this.view.playClicked.remove(this.handleIntentionToPlay);
         this.view.serversClicked.remove(this.showServersScreen);
         this.view.accountClicked.remove(this.handleIntentionToReviewAccount);
         // update 7.32.451X
          // this.view.legendsClicked.remove(this.showLegendsScreen);
         this.view.supportClicked.remove(this.openSupportPage);
         this.view.optionalButtonsAdded.remove(this.onOptionalButtonsAdded);
         this.view.kabamTransferClicked;//.remove(this.openKabamTransferView);
         this.view.editorClicked && this.view.editorClicked.remove(this.showMapEditor);
         this.view.quitClicked && this.view.quitClicked.remove(this.attemptToCloseClient);
      }

      private function openKabamTransferView() : void {
         this.view.openKabamTransferView();
      }

      private function handleIntentionToPlay() : void {
         this.enterGame.dispatch();
      }

      private function showServersScreen() : void {
         this.setScreen.dispatch(new ServersScreen());
      }

      private function handleIntentionToReviewAccount() : void {
         this.openAccountInfo.dispatch(false);
      }

      private function showLegendsScreen() : void {
         this.setScreen.dispatch(new LegendsView());
      }

      private function showMapEditor() : void {
         this.setScreen.dispatch(new LOEBUILD_81ade24e8daf8d0d9cbf110052ac9011());
      }

      private function attemptToCloseClient() : void {
         dispatch(new Event("APP_CLOSE_EVENT"));
      }
   }
}
