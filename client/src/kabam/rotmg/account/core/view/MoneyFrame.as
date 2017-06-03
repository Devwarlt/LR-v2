package kabam.rotmg.account.core.view {
import com.company.assembleegameclient.account.ui.Frame;
import com.company.assembleegameclient.account.ui.LOEBUILD_cb72693e3c4f933869f7a6ea4f77ddb2;
import com.company.assembleegameclient.account.ui.LOEBUILD_8c4fad153c9aacd802804f2b704cd337;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.assembleegameclient.ui.DeprecatedClickableText;
import com.company.assembleegameclient.ui.DeprecatedTextButton;
import com.company.assembleegameclient.util.PaymentMethod;
import com.company.assembleegameclient.util.offer.Offer;
import com.company.assembleegameclient.util.offer.Offers;

import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.account.core.model.MoneyConfig;
import kabam.rotmg.text.model.TextKey;

import org.osflash.signals.Signal;

public class MoneyFrame extends Sprite {

      private static const TITLE:String = TextKey.MONEY_FRAME_TITLE;

      private static const TRACKING:String = "/money";

      private static const PAYMENT_SUBTITLE:String = TextKey.MONEY_FRAME_PAYMENT;

      private static const GOLD_SUBTITLE:String = TextKey.MONEY_FRAME_GOLD;

      private static const BUY_NOW:String = TextKey.MONEY_FRAME_BUY;

      private static const WIDTH:int = 550;

      public var buyNow:Signal;

      public var cancel:Signal;

      private var offers:Offers;

      private var config:MoneyConfig;

      private var frame:Frame;

      private var paymentMethodButtons:LOEBUILD_8c4fad153c9aacd802804f2b704cd337;

      private var offerButtons:LOEBUILD_cb72693e3c4f933869f7a6ea4f77ddb2;

      public var buyNowButton:DeprecatedTextButton;

      public var cancelButton:DeprecatedClickableText;

      public function MoneyFrame() {
         super();
         this.buyNow = new Signal(Offer,String);
         this.cancel = new Signal();
      }

      public function initialize(param1:Offers, param2:MoneyConfig) : void {
         this.offers = param1;
         this.config = param2;
         this.frame = new Frame(TITLE,"","",TRACKING,WIDTH);
         param2.showPaymentMethods() && this.addPaymentMethods();
         this.addOffers();
         this.addBuyNowButton();
         addChild(this.frame);
         this.addCancelButton(TextKey.MONEY_FRAME_RIGHT_BUTTON);
         this.cancelButton.addEventListener(MouseEvent.CLICK,this.onCancel);
      }

      public function addPaymentMethods() : void {
         this.makePaymentMethodRadioButtons();
         this.frame.addTitle(PAYMENT_SUBTITLE);
         this.frame.addRadioBox(this.paymentMethodButtons);
         this.frame.addSpace(14);
         this.addLine(8355711,536,2,10);
         this.frame.addSpace(6);
      }

      private function makePaymentMethodRadioButtons() : void {
         var _local1:Vector.<String> = this.makePaymentMethodLabels();
         this.paymentMethodButtons = new LOEBUILD_8c4fad153c9aacd802804f2b704cd337(_local1);
         this.paymentMethodButtons.setSelected(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.paymentMethod);
      }

      private function makePaymentMethodLabels() : Vector.<String> {
         var _local2:PaymentMethod = null;
         var _local1:Vector.<String> = new Vector.<String>();
         for each(_local2 in PaymentMethod.PAYMENT_METHODS) {
            _local1.push(_local2.label_);
         }
         return _local1;
      }

      private function addLine(param1:int, param2:int, param3:int, param4:int) : void {
         var _local5:Shape = new Shape();
         _local5.graphics.beginFill(param1);
         _local5.graphics.drawRect(param4,0,param2 - param4 * 2,param3);
         _local5.graphics.endFill();
         this.frame.addComponent(_local5,0);
      }

      private function addOffers() : void {
         this.offerButtons = new LOEBUILD_cb72693e3c4f933869f7a6ea4f77ddb2(this.offers,this.config);
         this.offerButtons.showBonuses(this.config.showBonuses());
         this.frame.addTitle(GOLD_SUBTITLE);
         this.frame.addComponent(this.offerButtons);
      }

      public function addBuyNowButton() : void {
         this.buyNowButton = new DeprecatedTextButton(16,BUY_NOW);
         this.buyNowButton.addEventListener(MouseEvent.CLICK,this.onBuyNowClick);
         this.buyNowButton.x = 8;
         this.buyNowButton.y = this.frame.h_ - 52;
         this.frame.addChild(this.buyNowButton);
      }

      public function addCancelButton(param1:String) : void {
         this.cancelButton = new DeprecatedClickableText(18,true,param1);
         if(param1 != "") {
            this.cancelButton.buttonMode = true;
            this.cancelButton.x = 800 / 2 + this.frame.w_ / 2 - this.cancelButton.width - 26;
            this.cancelButton.y = 600 / 2 + this.frame.h_ / 2 - 52;
            this.cancelButton.setAutoSize(TextFieldAutoSize.RIGHT);
            addChild(this.cancelButton);
         }
      }

      protected function onBuyNowClick(param1:MouseEvent) : void {
         this.disable();
         var _local2:Offer = this.offerButtons.getChoice().offer;
         var _local3:String = !!this.paymentMethodButtons?this.paymentMethodButtons.getSelected():null;
         this.buyNow.dispatch(_local2,_local3 || "");
      }

      public function disable() : void {
         this.frame.disable();
         this.cancelButton.setDefaultColor(11776947);
         this.cancelButton.mouseEnabled = false;
         this.cancelButton.mouseChildren = false;
      }

      public function enableOnlyCancel() : void {
         this.cancelButton.removeOnHoverEvents();
         this.cancelButton.mouseEnabled = true;
         this.cancelButton.mouseChildren = true;
      }

      protected function onCancel(param1:MouseEvent) : void {
         stage.focus = stage;
         this.cancel.dispatch();
      }
   }
}
