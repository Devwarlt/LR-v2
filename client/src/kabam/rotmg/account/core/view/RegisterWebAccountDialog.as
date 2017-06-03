package kabam.rotmg.account.core.view {
import com.company.assembleegameclient.account.ui.LOEBUILD_2a93051d854334232eccdc5b2f3af3eb;
import com.company.assembleegameclient.account.ui.Frame;
import com.company.assembleegameclient.account.ui.LOEBUILD_b5d88c64baa451896772d5efdf29f2bf;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.util.EmailValidator;

import flash.events.MouseEvent;

import kabam.rotmg.account.web.model.AccountData;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

import org.osflash.signals.Signal;

public class RegisterWebAccountDialog extends Frame {

      public var register:Signal;

      public var cancel:Signal;

      private var emailInput:LOEBUILD_b5d88c64baa451896772d5efdf29f2bf;

      private var passwordInput:LOEBUILD_b5d88c64baa451896772d5efdf29f2bf;

      private var retypePasswordInput:LOEBUILD_b5d88c64baa451896772d5efdf29f2bf;

      private var checkbox:LOEBUILD_2a93051d854334232eccdc5b2f3af3eb;

      public function RegisterWebAccountDialog() {
         this.register = new Signal(AccountData);
         this.cancel = new Signal();
         super(TextKey.REGISTER_WEB_ACCOUNT_DIALOG_TITLE,TextKey.REGISTER_WEB_ACCOUNT_DIALOG_LEFTBUTTON,TextKey.REGISTER_WEB_ACCOUNT_DIALOG_RIGHTBUTTON,"/kongregateRegisterAccount");
         this.createAssets();
         this.enableForTabBehavior();
         this.addEventListeners();
      }

      private function addEventListeners() : void {
         leftButton_.addEventListener(MouseEvent.CLICK,this.onCancel);
         rightButton_.addEventListener(MouseEvent.CLICK,this.onRegister);
      }

      private function createAssets() : void {
         this.emailInput = new LOEBUILD_b5d88c64baa451896772d5efdf29f2bf(TextKey.REGISTER_WEB_ACCOUNT_EMAIL,false);
         addTextInputField(this.emailInput);
         this.passwordInput = new LOEBUILD_b5d88c64baa451896772d5efdf29f2bf(TextKey.REGISTER_WEB_ACCOUNT_PASSWORD,true);
         addTextInputField(this.passwordInput);
         this.retypePasswordInput = new LOEBUILD_b5d88c64baa451896772d5efdf29f2bf(TextKey.RETYPE_PASSWORD,true);
         addTextInputField(this.retypePasswordInput);
         this.checkbox = new LOEBUILD_2a93051d854334232eccdc5b2f3af3eb("",false);
         var _local1:* = "<font color=\"#7777EE\"><a href=\"" + LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.TERMS_OF_USE_URL + "\" target=\"_blank\">";
         var _local2:String = "</a></font>.";
         this.checkbox.setTextStringBuilder(new LineBuilder().setParams(TextKey.REGISTER_WEB_CHECKBOX,{
            "link":_local1,
            "_link":_local2
         }));
         addCheckBox(this.checkbox);
      }

      private function enableForTabBehavior() : void {
         this.emailInput.inputText_.tabIndex = 1;
         this.passwordInput.inputText_.tabIndex = 2;
         this.retypePasswordInput.inputText_.tabIndex = 3;
         this.checkbox.checkBox_.tabIndex = 4;
         leftButton_.tabIndex = 6;
         rightButton_.tabIndex = 5;
         this.emailInput.inputText_.tabEnabled = true;
         this.passwordInput.inputText_.tabEnabled = true;
         this.retypePasswordInput.inputText_.tabEnabled = true;
         this.checkbox.checkBox_.tabEnabled = true;
         leftButton_.tabEnabled = true;
         rightButton_.tabEnabled = true;
      }

      private function onCancel(param1:MouseEvent) : void {
         this.cancel.dispatch();
      }

      private function onRegister(param1:MouseEvent) : void {
         var _local2:AccountData = null;
         if(Boolean(this.isEmailValid()) && Boolean(this.isPasswordValid()) && Boolean(this.isPasswordVerified()) && Boolean(this.isCheckboxChecked())) {
            _local2 = new AccountData();
            _local2.username = this.emailInput.text();
            _local2.password = this.passwordInput.text();
            this.register.dispatch(_local2);
         }
      }

      private function isCheckboxChecked() : Boolean {
         var _local1:Boolean = this.checkbox.isChecked();
         if(!_local1) {
            this.checkbox.setError(TextKey.REGISTER_WEB_ACCOUNT_CHECK_ERROR);
         }
         return _local1;
      }

      private function isEmailValid() : Boolean {
         var _local1:Boolean = EmailValidator.isValidEmail(this.emailInput.text());
         if(!_local1) {
            this.emailInput.setError(TextKey.INVALID_EMAIL_ADDRESS);
         }
         return _local1;
      }

      private function isPasswordValid() : Boolean {
         var _local1:* = this.passwordInput.text().length >= 5;
         if(!_local1) {
            this.passwordInput.setError(TextKey.REGISTER_WEB_SHORT_ERROR);
         }
         return _local1;
      }

      private function isPasswordVerified() : Boolean {
         var _local1:* = this.passwordInput.text() == this.retypePasswordInput.text();
         if(!_local1) {
            this.retypePasswordInput.setError(TextKey.REGISTER_WEB_MATCH_ERROR);
         }
         return _local1;
      }

      public function showError(param1:String) : void {
         this.emailInput.setError(param1);
      }
   }
}
