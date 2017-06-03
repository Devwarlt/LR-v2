package com.company.assembleegameclient.ui.guild {
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.LOEBUILD_6615c4f9bea4fdaf620bf1ad513a54c1;
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.LOEBUILD_16908b0605f2645dfcb4c3a8d248cef3.LOEBUILD_50840d80ddb06f7e096ad2c5cf1fbb1e;
import kabam.rotmg.assets.model.Player;
import com.company.assembleegameclient.screens.TitleMenuOption;
import com.company.assembleegameclient.ui.dialogs.Dialog;
import com.company.rotmg.graphics.ScreenGraphic;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;

public class GuildChronicleScreen extends Sprite {

      private var gs_:LOEBUILD_6615c4f9bea4fdaf620bf1ad513a54c1;

      private var container:Sprite;

      private var guildPlayerList_:GuildPlayerList;

      private var continueButton_:TitleMenuOption;

      public function GuildChronicleScreen(param1:LOEBUILD_6615c4f9bea4fdaf620bf1ad513a54c1) {
         super();
         this.gs_ = param1;
         graphics.clear();
         graphics.beginFill(2829099,0.8);
         graphics.drawRect(0,0,800,600);
         graphics.endFill();
         addChild(this.container = new Sprite());
         this.addList();
         addChild(new ScreenGraphic());
         this.continueButton_ = new TitleMenuOption(TextKey.OPTIONS_CONTINUE_BUTTON,36,false);
         this.continueButton_.setAutoSize(TextFieldAutoSize.CENTER);
         this.continueButton_.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
         this.continueButton_.addEventListener(MouseEvent.CLICK,this.onContinueClick);
         addChild(this.continueButton_);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }

      private function addList() : void {
         if(Boolean(this.guildPlayerList_) && Boolean(this.guildPlayerList_.parent)) {
            this.container.removeChild(this.guildPlayerList_);
         }
         var _local1:Player = this.gs_.map.player_;
         this.guildPlayerList_ = new GuildPlayerList(50,0,_local1 == null?"":_local1.name_,_local1.guildRank_);
         this.guildPlayerList_.addEventListener(GuildPlayerListEvent.SET_RANK,this.onSetRank);
         this.guildPlayerList_.addEventListener(GuildPlayerListEvent.REMOVE_MEMBER,this.onRemoveMember);
         this.container.addChild(this.guildPlayerList_);
      }

      private function removeList() : void {
         this.guildPlayerList_.removeEventListener(GuildPlayerListEvent.SET_RANK,this.onSetRank);
         this.guildPlayerList_.removeEventListener(GuildPlayerListEvent.REMOVE_MEMBER,this.onRemoveMember);
         this.container.removeChild(this.guildPlayerList_);
         this.guildPlayerList_ = null;
      }

      private function onSetRank(param1:GuildPlayerListEvent) : void {
         this.removeList();
         this.gs_.addEventListener(LOEBUILD_50840d80ddb06f7e096ad2c5cf1fbb1e.EVENT,this.onSetRankResult);
         this.gs_.gsc_.changeGuildRank(param1.name_,param1.rank_);
      }

      private function onSetRankResult(param1:LOEBUILD_50840d80ddb06f7e096ad2c5cf1fbb1e) : void {
         this.gs_.removeEventListener(LOEBUILD_50840d80ddb06f7e096ad2c5cf1fbb1e.EVENT,this.onSetRankResult);
         if(!param1.success_) {
            this.showError(param1.errorKey);
         } else {
            this.addList();
         }
      }

      private function onRemoveMember(param1:GuildPlayerListEvent) : void {
         this.removeList();
         this.gs_.addEventListener(LOEBUILD_50840d80ddb06f7e096ad2c5cf1fbb1e.EVENT,this.onRemoveResult);
         this.gs_.gsc_.guildRemove(param1.name_);
      }

      private function onRemoveResult(param1:LOEBUILD_50840d80ddb06f7e096ad2c5cf1fbb1e) : void {
         this.gs_.removeEventListener(LOEBUILD_50840d80ddb06f7e096ad2c5cf1fbb1e.EVENT,this.onRemoveResult);
         if(!param1.success_) {
            this.showError(param1.errorKey);
         } else {
            this.addList();
         }
      }

      private function showError(param1:String) : void {
         var _local2:Dialog = new Dialog(TextKey.GUILD_CHRONICLE_LEFT,param1,TextKey.GUILD_CHRONICLE_RIGHT,null,"/guildError");
         _local2.addEventListener(Dialog.LEFT_BUTTON,this.onErrorTextDone);
         stage.addChild(_local2);
      }

      private function onErrorTextDone(param1:Event) : void {
         var _local2:Dialog = param1.currentTarget as Dialog;
         stage.removeChild(_local2);
         this.addList();
      }

      private function onContinueClick(param1:MouseEvent) : void {
         this.close();
      }

      private function onAddedToStage(param1:Event) : void {
         this.continueButton_.x = stage.stageWidth / 2;
         this.continueButton_.y = 550;
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown,false,1);
         stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp,false,1);
      }

      private function onRemovedFromStage(param1:Event) : void {
         stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown,false);
         stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp,false);
      }

      private function onKeyDown(param1:KeyboardEvent) : void {
         param1.stopImmediatePropagation();
      }

      private function onKeyUp(param1:KeyboardEvent) : void {
         param1.stopImmediatePropagation();
      }

      private function close() : void {
         stage.focus = null;
         parent.removeChild(this);
      }
   }
}
