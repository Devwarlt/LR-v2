package com.company.assembleegameclient.account.ui {
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.LOEBUILD_6615c4f9bea4fdaf620bf1ad513a54c1;
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.LOEBUILD_16908b0605f2645dfcb4c3a8d248cef3.LOEBUILD_074c8fb83348087c0cf9b59ae079772a;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;

import kabam.rotmg.core.service.TrackingData;
import kabam.rotmg.core.signals.TrackEventSignal;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.ui.signals.NameChangedSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class LOEBUILD_fd4258db927c50c805af8b7b06140ba2 extends Mediator {

      [Inject]
      public var view:LOEBUILD_74a13e89b510f04db8bb32dcec0faa62;

      [Inject]
      public var closeDialogs:CloseDialogsSignal;

      [Inject]
      public var trackEvent:TrackEventSignal;

      [Inject]
      public var nameChanged:NameChangedSignal;

      private var gameSprite:LOEBUILD_6615c4f9bea4fdaf620bf1ad513a54c1;

      private var name:String;

      public function LOEBUILD_fd4258db927c50c805af8b7b06140ba2() {
         super();
      }

      override public function initialize() : void {
         this.gameSprite = this.view.gameSprite;
         this.view.choose.add(this.onChoose);
         this.view.cancel.add(this.onCancel);
      }

      override public function destroy() : void {
         this.view.choose.remove(this.onChoose);
         this.view.cancel.remove(this.onCancel);
      }

      private function onChoose(param1:String) : void {
         this.name = param1;
         this.gameSprite.addEventListener(LOEBUILD_074c8fb83348087c0cf9b59ae079772a.NAMERESULTEVENT,this.onNameResult);
         this.gameSprite.gsc_.chooseName(param1);
         this.view.disable();
      }

      public function onNameResult(param1:LOEBUILD_074c8fb83348087c0cf9b59ae079772a) : void {
         this.gameSprite.removeEventListener(LOEBUILD_074c8fb83348087c0cf9b59ae079772a.NAMERESULTEVENT,this.onNameResult);
         var _local2:Boolean = param1.m_.success_;
         if(_local2) {
            this.handleSuccessfulNameChange();
         } else {
            this.handleFailedNameChange(param1.m_.errorText_);
         }
      }

      private function handleSuccessfulNameChange() : void {
         if(this.view.isPurchase) {
            this.trackPurchase();
         }
         this.gameSprite.model.setName(this.name);
         this.gameSprite.map.player_.name_ = this.name;
         this.closeDialogs.dispatch();
         this.nameChanged.dispatch(this.name);
      }

      private function trackPurchase() : void {
         var _local1:TrackingData = new TrackingData();
         _local1.category = "credits";
         _local1.action = !!this.gameSprite.model.getConverted()?"buyConverted":"buy";
         _local1.label = "Name Change";
         _local1.value = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.NAME_CHANGE_PRICE;
         this.trackEvent.dispatch(_local1);
      }

      private function handleFailedNameChange(param1:String) : void {
         this.view.setError(param1);
         this.view.enable();
      }

      private function onCancel() : void {
         this.closeDialogs.dispatch();
      }
   }
}
