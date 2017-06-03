package kabam.rotmg.account.web.view {
import com.company.assembleegameclient.screens.TitleMenuOption;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.account.core.view.AccountInfoView;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class WebAccountInfoView extends Sprite implements AccountInfoView {

      private static const FONT_SIZE:int = 18;

      private var _login:Signal;

      private var _register:Signal;

      private var userName:String = "";

      private var isRegistered:Boolean;

      private var accountText:TextFieldDisplayConcrete;

      private var registerButton:TitleMenuOption;

      private var loginButton:TitleMenuOption;

      public function WebAccountInfoView() {
         super();
         this.makeUIElements();
         this.makeSignals();
      }

      public function get login() : Signal {
         return this._login;
      }

      public function get register() : Signal {
         return this._register;
      }

      private function makeUIElements() : void {
         this.makeAccountText();
         this.makeLoginButton();
         this.makeRegisterButton();
      }

      private function makeSignals() : void {
         this._login = new NativeMappedSignal(this.loginButton,MouseEvent.CLICK);
         this._register = new NativeMappedSignal(this.registerButton,MouseEvent.CLICK);
      }

      private function makeAccountText() : void {
         this.accountText = this.makeTextFieldConcrete();
         this.accountText.setStringBuilder(new LineBuilder().setParams(TextKey.GUEST_ACCOUNT));
      }

      private function makeTextFieldConcrete() : TextFieldDisplayConcrete {
         var _local1:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
         _local1.setAutoSize(TextFieldAutoSize.RIGHT);
         _local1.setSize(FONT_SIZE).setColor(11776947);
         _local1.filters = [new DropShadowFilter(0,0,0,1,4,4)];
         return _local1;
      }

      private function makeLoginButton() : void {
         this.loginButton = new TitleMenuOption(TextKey.LOG_IN,FONT_SIZE,false);
         this.loginButton.setAutoSize(TextFieldAutoSize.RIGHT);
      }

      private function makeRegisterButton() : void {
         this.registerButton = new TitleMenuOption(TextKey.REGISTER,FONT_SIZE,false);
         this.registerButton.setAutoSize(TextFieldAutoSize.RIGHT);
      }

      private function makeDividerText() : DisplayObject {
         var _local1:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
         _local1.setColor(11776947).setAutoSize(TextFieldAutoSize.RIGHT).setSize(FONT_SIZE);
         _local1.filters = [new DropShadowFilter(0,0,0,1,4,4)];
         _local1.setStringBuilder(new StaticStringBuilder(" - "));
         return _local1;
      }

      public function setInfo(param1:String, param2:Boolean) : void {
         this.userName = param1;
         this.isRegistered = param2;
         this.updateUI();
      }

      private function updateUI() : void {
         this.removeUIElements();
         if(this.isRegistered) {
            this.showUIForRegisteredAccount();
         } else {
            this.showUIForGuestAccount();
         }
      }

      private function removeUIElements() : void {
         while(numChildren) {
            removeChildAt(0);
         }
      }

      private function showUIForRegisteredAccount() : void {
//         this.accountText.setStringBuilder(new LineBuilder().setParams(TextKey.LOGGED_IN_TEXT,{"userName": "hidden"}));
         this.loginButton.setTextKey(TextKey.LOG_OUT);
         this.addAndAlignHorizontally(this.loginButton);
      }

      private function showUIForGuestAccount() : void {
//         this.accountText.setStringBuilder(new LineBuilder().setParams(TextKey.GUEST_ACCOUNT,{"userName": "hidden"}));
         this.loginButton.setTextKey(TextKey.LOG_IN);
         this.addAndAlignHorizontally(this.registerButton,this.makeDividerText(),this.loginButton);
      }

      private function addAndAlignHorizontally(... rest) : void {
         var _local2:DisplayObject = null;
         var _local3:int = 0;
         var _local4:int = 0;
         var _local5:DisplayObject = null;
         for each(_local2 in rest) {
            addChild(_local2);
         }
         _local3 = 0;
         _local4 = rest.length;
         while(_local4--) {
            _local5 = rest[_local4];
            _local5.x = _local3;
            _local3 = _local3 - _local5.width;
         }
      }
   }
}
