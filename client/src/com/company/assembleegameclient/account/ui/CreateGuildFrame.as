package com.company.assembleegameclient.account.ui {
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.GameSprite;
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.LOEBUILD_16908b0605f2645dfcb4c3a8d248cef3.LOEBUILD_50840d80ddb06f7e096ad2c5cf1fbb1e;
import kabam.rotmg.assets.model.Player;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;

import flash.events.MouseEvent;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.game.model.GameModel;
import kabam.rotmg.text.model.TextKey;

import org.osflash.signals.Signal;

public class CreateGuildFrame extends Frame {

      public const close:Signal = new Signal();

      private var name_:LOEBUILD_b5d88c64baa451896772d5efdf29f2bf;

      private var gs_:GameSprite;

      public function CreateGuildFrame(param1:GameSprite) {
         super(TextKey.GUILD_TITLE,TextKey.FRAME_CANCEL,TextKey.GUILD_CREATE,"/createGuild");
         this.gs_ = param1;
         this.name_ = new LOEBUILD_b5d88c64baa451896772d5efdf29f2bf(TextKey.GUILD_NAME,false);
         this.name_.inputText_.restrict = "A-Za-z ";
         var _local2:int = 20;
         this.name_.inputText_.maxChars = _local2;
         addTextInputField(this.name_);
         addPlainText(TextKey.FRAME_MAX_CHAR,{"maxChars":_local2});
         addPlainText(TextKey.FRAME_RESTRICT_CHAR);
         addPlainText(TextKey.GUILD_WARNING);
         leftButton_.addEventListener(MouseEvent.CLICK,this.onCancel);
         rightButton_.addEventListener(MouseEvent.CLICK,this.onCreate);
      }

      private function onCancel(param1:MouseEvent) : void {
         this.close.dispatch();
      }

      private function onCreate(param1:MouseEvent) : void {
         this.gs_.addEventListener(LOEBUILD_50840d80ddb06f7e096ad2c5cf1fbb1e.EVENT,this.onResult);
         this.gs_.gsc_.createGuild(this.name_.text());
         disable();
      }

      private function onResult(param1:LOEBUILD_50840d80ddb06f7e096ad2c5cf1fbb1e) : void {
         var _local2:Player = null;
         this.gs_.removeEventListener(LOEBUILD_50840d80ddb06f7e096ad2c5cf1fbb1e.EVENT,this.onResult);
         if(param1.success_) {
            _local2 = StaticInjectorContext.getInjector().getInstance(GameModel).player;
            if(_local2 != null) {
               _local2.fame_ = _local2.fame_ - LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.GUILD_CREATION_PRICE;
            }
            this.close.dispatch();
         } else {
            this.name_.setError(param1.errorKey,param1.errorTokens);
            enable();
         }
      }
   }
}
