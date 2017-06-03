package kabam.rotmg.account.web.view {
import com.company.assembleegameclient.account.ui.Frame;
import com.company.assembleegameclient.account.ui.LOEBUILD_b5d88c64baa451896772d5efdf29f2bf;

import flash.events.MouseEvent;

import kabam.rotmg.account.web.model.ChangePasswordData;
import kabam.rotmg.text.model.TextKey;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class WebChangePasswordDialog extends Frame {

      public var cancel:Signal;

      public var change:Signal;

      public var password_:LOEBUILD_b5d88c64baa451896772d5efdf29f2bf;

      public var newPassword_:LOEBUILD_b5d88c64baa451896772d5efdf29f2bf;

      public var retypeNewPassword_:LOEBUILD_b5d88c64baa451896772d5efdf29f2bf;

      public function WebChangePasswordDialog() {
         super(TextKey.WEB_CHANGE_PASSWORD_TITLE,TextKey.WEB_CHANGE_PASSWORD_LEFT,TextKey.WEB_CHANGE_PASSWORD_RIGHT,"/changePassword");
         this.password_ = new LOEBUILD_b5d88c64baa451896772d5efdf29f2bf(TextKey.WEB_CHANGE_PASSWORD_PASSWORD,true);
         addTextInputField(this.password_);
         this.newPassword_ = new LOEBUILD_b5d88c64baa451896772d5efdf29f2bf(TextKey.WEB_CHANGE_PASSWORD_NEW_PASSWORD,true);
         addTextInputField(this.newPassword_);
         this.retypeNewPassword_ = new LOEBUILD_b5d88c64baa451896772d5efdf29f2bf(TextKey.WEB_CHANGE_PASSWORD_RETYPE_PASSWORD,true);
         addTextInputField(this.retypeNewPassword_);
         this.cancel = new NativeMappedSignal(leftButton_,MouseEvent.CLICK);
         this.change = new NativeMappedSignal(rightButton_,MouseEvent.CLICK);
      }

      private function onChange(param1:MouseEvent) : void {
         var _local2:ChangePasswordData = null;
         if(Boolean(this.isCurrentPasswordValid()) && Boolean(this.isNewPasswordValid()) && Boolean(this.isNewPasswordVerified())) {
            disable();
            _local2 = new ChangePasswordData();
            _local2.currentPassword = this.password_.text();
            _local2.newPassword = this.newPassword_.text();
            this.change.dispatch(_local2);
         }
      }

      private function isCurrentPasswordValid() : Boolean {
         var _local1:* = this.password_.text().length >= 5;
         if(!_local1) {
            this.password_.setError(TextKey.WEB_CHANGE_PASSWORD_INCORRECT);
         }
         return _local1;
      }

      private function isNewPasswordValid() : Boolean {
         var _local1:* = this.newPassword_.text().length >= 5;
         if(!_local1) {
            this.newPassword_.setError(TextKey.LINK_WEB_ACCOUNT_SHORT);
         }
         return _local1;
      }

      private function isNewPasswordVerified() : Boolean {
         var _local1:* = this.newPassword_.text() == this.retypeNewPassword_.text();
         if(!_local1) {
            this.retypeNewPassword_.setError(TextKey.PASSWORD_DOES_NOT_MATCH);
         }
         return _local1;
      }

      public function setError(param1:String) : void {
         this.password_.setError(param1);
      }

      public function clearError() : void {
         this.password_.clearError();
         this.retypeNewPassword_.clearError();
         this.newPassword_.clearError();
      }
   }
}
