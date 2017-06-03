package kabam.rotmg.account.web.view {
import com.company.assembleegameclient.account.ui.Frame;
import com.company.assembleegameclient.account.ui.LOEBUILD_b5d88c64baa451896772d5efdf29f2bf;
import com.company.assembleegameclient.ui.DeprecatedClickableText;

import flash.events.MouseEvent;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class WebForgotPasswordDialog extends Frame {

      public var cancel:Signal;

      public var submit:Signal;

      public var register:Signal;

      private var emailInput:LOEBUILD_b5d88c64baa451896772d5efdf29f2bf;

      private var registerText:DeprecatedClickableText;

      public function WebForgotPasswordDialog() {
         super("WebForgotPasswordDialog.title","WebForgotPasswordDialog.leftButton","WebForgotPasswordDialog.rightButton","/forgotPassword");
         this.emailInput = new LOEBUILD_b5d88c64baa451896772d5efdf29f2bf("WebForgotPasswordDialog.email",false);
         addTextInputField(this.emailInput);
         this.registerText = new DeprecatedClickableText(12,false,"WebForgotPasswordDialog.register");
         addNavigationText(this.registerText);
         rightButton_.addEventListener(MouseEvent.CLICK,this.onSubmit);
         this.cancel = new NativeMappedSignal(leftButton_,MouseEvent.CLICK);
         this.register = new NativeMappedSignal(this.registerText,MouseEvent.CLICK);
         this.submit = new Signal(String);
      }

      private function onSubmit(param1:MouseEvent) : void {
         if(this.isEmailValid()) {
            disable();
            this.submit.dispatch(this.emailInput.text());
         }
      }

      private function isEmailValid() : Boolean {
         var _local1:* = this.emailInput.text() != "";
         if(!_local1) {
            this.emailInput.setError("Not a valid email address");
         }
         return _local1;
      }

      public function showError(param1:String) : void {
         this.emailInput.setError(param1);
      }
   }
}
