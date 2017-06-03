package com.company.assembleegameclient.account.ui {
import com.company.util.MoreObjectUtil;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.ui.signals.NameChangedSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class LOEBUILD_4f0354bebd75d2538b9cdb2035dd45bb extends Mediator {

      [Inject]
      public var view:NewChooseNameFrame;

      [Inject]
      public var account:Account;

      [Inject]
      public var openDialog:OpenDialogSignal;

      [Inject]
      public var closeDialogs:CloseDialogsSignal;

      [Inject]
      public var nameChanged:NameChangedSignal;

      [Inject]
      public var client:AppEngineClient;

      [Inject]
      public var playerModel:PlayerModel;

      private var name:String;

      public function LOEBUILD_4f0354bebd75d2538b9cdb2035dd45bb() {
         super();
      }

      override public function initialize() : void {
         this.view.choose.add(this.onChoose);
         this.view.cancel.add(this.onCancel);
      }

      override public function destroy() : void {
         this.view.choose.remove(this.onChoose);
         this.view.cancel.remove(this.onCancel);
      }

      private function onChoose(param1:String) : void {
         this.name = param1;
         if(param1.length < 1) {
            this.view.setError("Name too short");
         } else {
            this.sendNameToServer();
         }
      }

      private function sendNameToServer() : void {
         var _local1:Object = {"name":this.name};
         MoreObjectUtil.addToObject(_local1,this.account.getCredentials());
         this.client.complete.addOnce(this.onComplete);
         this.client.sendRequest("/account/setName",_local1);
         this.view.disable();
      }

      private function onComplete(param1:Boolean, param2:*) : void {
         if(param1) {
            this.onNameChoseDone();
         } else {
            this.onNameChoseError(param2);
         }
      }

      private function onNameChoseDone() : void {
         if(this.playerModel != null) {
            this.playerModel.setName(this.name);
         }
         this.nameChanged.dispatch(this.name);
         this.closeDialogs.dispatch();
      }

      private function onNameChoseError(param1:String) : void {
         this.view.setError(param1);
         this.view.enable();
      }

      private function onCancel() : void {
         this.closeDialogs.dispatch();
      }
   }
}
