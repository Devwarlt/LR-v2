package com.company.assembleegameclient.util {
import com.company.assembleegameclient.util.offer.Offer;

import flash.net.URLVariables;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.text.model.TextKey;

public class PaymentMethod {

      public static const GO_METHOD:PaymentMethod = new PaymentMethod(TextKey.PAYMENTS_GOOGLE_CHECKOUT,"co","");

      public static const PAYPAL_METHOD:PaymentMethod = new PaymentMethod(TextKey.PAYMENTS_PAYPAL,"ps","P3");

      public static const CREDITS_METHOD:PaymentMethod = new PaymentMethod(TextKey.PAYMENTS_CREDIT_CARDS,"ps","CH");

      public static const PAYMENT_METHODS:Vector.<PaymentMethod> = new <PaymentMethod>[GO_METHOD,PAYPAL_METHOD,CREDITS_METHOD];

      public var label_:String;

      public var provider_:String;

      public var paymentid_:String;

      public function PaymentMethod(param1:String, param2:String, param3:String) {
         super();
         this.label_ = param1;
         this.provider_ = param2;
         this.paymentid_ = param3;
      }

      public static function getPaymentMethodByLabel(param1:String) : PaymentMethod {
         var _local2:PaymentMethod = null;
         for each(_local2 in PAYMENT_METHODS) {
            if(_local2.label_ == param1) {
               return _local2;
            }
         }
         return null;
      }

      public function getURL(param1:String, param2:String, param3:Offer) : String {
         var _local4:Account = StaticInjectorContext.getInjector().getInstance(Account);
         var _local5:ApplicationSetup = StaticInjectorContext.getInjector().getInstance(ApplicationSetup);
         var _local6:URLVariables = new URLVariables();
         _local6["tok"] = param1;
         _local6["exp"] = param2;
         _local6["guid"] = _local4.getUserId();
         _local6["provider"] = this.provider_;
         switch(this.provider_) {
            case "co":
               _local6["jwt"] = param3.jwt_;
               break;
            case "ps":
               _local6["jwt"] = param3.jwt_;
               _local6["price"] = param3.price_.toString();
               _local6["paymentid"] = this.paymentid_;
         }
         return _local5.getAppEngineUrl(true) + "/credits/add?" + _local6.toString();
      }
   }
}
