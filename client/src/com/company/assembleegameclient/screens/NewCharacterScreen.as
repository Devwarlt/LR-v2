package com.company.assembleegameclient.screens {
import com.company.assembleegameclient.LOEBUILD_1f4c42c309fe6bc45253d598cfdf9b99.LOEBUILOD_1839b10431d757564a37f7352035160a;
import com.company.assembleegameclient.LOEBUILD_93fb40ec02c008121fa9199899b31202.LOEBUILD_2362742ab4407cb8a5feed3a3a43e749;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;
import com.company.googleanalytics.GA;
import com.company.rotmg.graphics.ScreenGraphic;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.game.view.CreditDisplay;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.ui.view.components.ScreenBase;

import org.osflash.signals.Signal;

public class NewCharacterScreen extends Sprite {

      private var backButton_:TitleMenuOption;

      private var creditDisplay_:CreditDisplay;

      private var boxes_:Object;

      public var tooltip:Signal;

      public var close:Signal;

      public var selected:Signal;

      public var buy:Signal;

      private var isInitialized:Boolean = false;

      public function NewCharacterScreen() {
         this.boxes_ = {};
         super();
         this.tooltip = new Signal(Sprite);
         this.selected = new Signal(int);
         this.close = new Signal();
         this.buy = new Signal(int);
         addChild(new ScreenBase());
         addChild(new AccountScreen());
         addChild(new ScreenGraphic());
      }

      public function initialize(param1:PlayerModel) : void {
         var _local2:int = 0;
         var _local3:XML = null;
         var _local4:int = 0;
         var _local5:String = null;
         var _local6:Boolean = false;
         var _local7:CharacterBox = null;
         if(this.isInitialized) {
            return;
         }
         this.isInitialized = true;
         this.backButton_ = new TitleMenuOption(LOEBUILD_2362742ab4407cb8a5feed3a3a43e749.BACK,36,false);
         this.backButton_.addEventListener(MouseEvent.CLICK,this.onBackClick);
         this.backButton_.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
         addChild(this.backButton_);
         this.creditDisplay_ = new CreditDisplay();
         this.creditDisplay_.draw(param1.getCredits(),param1.getFame());
         addChild(this.creditDisplay_);
         _local2 = 0;
         while(_local2 < LOEBUILD_efda783509bc93eea698457c87bbee3f.playerChars_.length) {
            _local3 = LOEBUILD_efda783509bc93eea698457c87bbee3f.playerChars_[_local2];
            _local4 = int(_local3.@type);
            _local5 = _local3.@id;
            if(!param1.isClassAvailability(_local5,LOEBUILOD_1839b10431d757564a37f7352035160a.UNAVAILABLE)) {
               _local6 = param1.isClassAvailability(_local5,LOEBUILOD_1839b10431d757564a37f7352035160a.UNRESTRICTED);
               _local7 = new CharacterBox(_local3,param1.getCharStats()[_local4],param1,_local6);
               _local7.x = 50 + 140 * int(_local2 % 5) + 70 - _local7.width / 2;
               _local7.y = 88 + 140 * int(_local2 / 5);
               this.boxes_[_local4] = _local7;
               _local7.addEventListener(MouseEvent.ROLL_OVER,this.onCharBoxOver);
               _local7.addEventListener(MouseEvent.ROLL_OUT,this.onCharBoxOut);
               _local7.characterSelectClicked_.add(this.onCharBoxClick);
               _local7.buyButtonClicked_.add(this.onBuyClicked);
               if(_local4 == 784 && !_local7.available_) {
                  _local7.setSale(75);
               }
               addChild(_local7);
            }
            _local2++;
         }
         this.backButton_.x = 800 / 2 - this.backButton_.width / 2;
         this.backButton_.y = 550;
         this.creditDisplay_.x = 800;
         this.creditDisplay_.y = 20;
         GA.global().trackPageview("/newCharScreen");
      }

      private function onBackClick(param1:Event) : void {
         this.close.dispatch();
      }

      private function onCharBoxOver(param1:MouseEvent) : void {
         var _local2:CharacterBox = param1.currentTarget as CharacterBox;
         _local2.setOver(true);
         this.tooltip.dispatch(_local2.getTooltip());
      }

      private function onCharBoxOut(param1:MouseEvent) : void {
         var _local2:CharacterBox = param1.currentTarget as CharacterBox;
         _local2.setOver(false);
         this.tooltip.dispatch(null);
      }

      private function onCharBoxClick(param1:MouseEvent) : void {
         this.tooltip.dispatch(null);
         var _local2:CharacterBox = param1.currentTarget.parent as CharacterBox;
         if(!_local2.available_) {
            return;
         }
         var _local3:int = _local2.objectType();
         var _local4:String = LOEBUILD_efda783509bc93eea698457c87bbee3f.typeToDisplayId_[_local3];
         GA.global().trackEvent("character","create",_local4);
         this.selected.dispatch(_local3);
      }

      public function updateCreditsAndFame(param1:int, param2:int) : void {
         this.creditDisplay_.draw(param1,param2);
      }

      public function update(param1:PlayerModel) : void {
         var _local3:XML = null;
         var _local4:int = 0;
         var _local5:String = null;
         var _local6:Boolean = false;
         var _local7:CharacterBox = null;
         var _local2:int = 0;
         while(_local2 < LOEBUILD_efda783509bc93eea698457c87bbee3f.playerChars_.length) {
            _local3 = LOEBUILD_efda783509bc93eea698457c87bbee3f.playerChars_[_local2];
            _local4 = int(_local3.@type);
            _local5 = String(_local3.@id);
            if(!param1.isClassAvailability(_local5,LOEBUILOD_1839b10431d757564a37f7352035160a.UNAVAILABLE)) {
               _local6 = param1.isClassAvailability(_local5,LOEBUILOD_1839b10431d757564a37f7352035160a.UNRESTRICTED);
               _local7 = this.boxes_[_local4];
               if(_local7) {
                  _local7.setIsBuyButtonEnabled(true);
                  if(Boolean(_local6) || Boolean(param1.isLevelRequirementsMet(_local4))) {
                     _local7.unlock();
                  }
               }
            }
            _local2++;
         }
      }

      private function onBuyClicked(param1:MouseEvent) : void {
         var _local3:int = 0;
         var _local2:CharacterBox = param1.currentTarget.parent as CharacterBox;
         if(Boolean(_local2) && !_local2.available_) {
            _local3 = int(_local2.playerXML_.@type);
            _local2.setIsBuyButtonEnabled(false);
            this.buy.dispatch(_local3);
         }
      }
   }
}
