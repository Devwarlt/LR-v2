package kabam.rotmg.account.web.services {
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.assembleegameclient.util.PaymentMethod;

import flash.net.URLRequest;
import flash.net.navigateToURL;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.PaymentData;
import kabam.rotmg.account.core.model.OfferModel;
import kabam.rotmg.account.core.services.MakePaymentTask;

public class WebMakePaymentTask extends BaseTask implements MakePaymentTask {

      [Inject]
      public var data:PaymentData;

      [Inject]
      public var model:OfferModel;

      public function WebMakePaymentTask() {
         super();
      }

      override protected function startTask() : void {
         LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.paymentMethod = this.data.paymentMethod;
         LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.save();
         var _local1:PaymentMethod = PaymentMethod.getPaymentMethodByLabel(this.data.paymentMethod);
         var _local2:String = _local1.getURL(this.model.offers.tok,this.model.offers.exp,this.data.offer);
         navigateToURL(new URLRequest(_local2),"_blank");
         completeTask(true);
      }
   }
}
