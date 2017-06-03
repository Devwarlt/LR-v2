package com.company.assembleegameclient.ui.panels {
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.GameSprite;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.Portal;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_3d035f7e69af9b21fea3e879f88e0ea2;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.assembleegameclient.tutorial.Tutorial;
import com.company.assembleegameclient.tutorial.doneAction;
import com.company.assembleegameclient.ui.DeprecatedTextButton;
import com.company.googleanalytics.GA;

import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;
import kabam.rotmg.ui.view.SignalWaiter;

import org.osflash.signals.Signal;

public class PortalPanel extends Panel {

      private const LOCKED:String = "Locked ";

      private const TEXT_PATTERN:RegExp = new RegExp("\\{\"text\":\"(.+)\"}");

      public var owner_:Portal;

      private var nameText_:TextFieldDisplayConcrete;

      private var enterButton_:DeprecatedTextButton;

      private var fullText_:TextFieldDisplayConcrete;

      public const exitGameSignal:Signal = new Signal();

      private const waiter:SignalWaiter = new SignalWaiter();

      public function PortalPanel(param1:GameSprite, param2:Portal) {
         super(param1);
         this.owner_ = param2;
         this.nameText_ = new TextFieldDisplayConcrete().setSize(18).setColor(16777215).setBold(true).setTextWidth(WIDTH).setHorizontalAlign(TextFormatAlign.CENTER);
         this.nameText_.filters = [new DropShadowFilter(0,0,0)];
         addChild(this.nameText_);
         this.waiter.push(this.nameText_.textChanged);
         this.enterButton_ = new DeprecatedTextButton(16,TextKey.PANEL_ENTER);
         addChild(this.enterButton_);
         this.waiter.push(this.enterButton_.textChanged);
         this.fullText_ = new TextFieldDisplayConcrete().setSize(18).setColor(16711680).setHTML(true).setBold(true).setAutoSize(TextFieldAutoSize.CENTER);
         var _local3:String = !!this.owner_.lockedPortal_?TextKey.PORTAL_PANEL_LOCKED:TextKey.PORTAL_PANEL_FULL;
         this.fullText_.setStringBuilder(new LineBuilder().setParams(_local3).setPrefix("<p align=\"center\">").setPostfix("</p>"));
         this.fullText_.filters = [new DropShadowFilter(0,0,0)];
         this.fullText_.textChanged.addOnce(this.alignUI);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         this.waiter.complete.addOnce(this.alignUI);
      }

      private function alignUI() : void {
         this.nameText_.y = 6;
         this.enterButton_.x = WIDTH / 2 - this.enterButton_.width / 2;
         this.enterButton_.y = HEIGHT - this.enterButton_.height - 4;
         this.fullText_.y = HEIGHT - 30;
         this.fullText_.x = WIDTH / 2;
      }

      private function onAddedToStage(param1:Event) : void {
         this.enterButton_.addEventListener(MouseEvent.CLICK,this.onEnterSpriteClick);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }

      private function onRemovedFromStage(param1:Event) : void {
         stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }

      private function onEnterSpriteClick(param1:MouseEvent) : void {
         this.enterPortal();
      }

      private function onKeyDown(param1:KeyboardEvent) : void {
         if(param1.keyCode == LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.interact && stage.focus == null) {
            this.enterPortal();
         }
      }

      private function enterPortal() : void {
         var _local1:String = LOEBUILD_efda783509bc93eea698457c87bbee3f.typeToDisplayId_[this.owner_.objectType_];
         if(_local1 == "Nexus Portal") {
            GA.global().trackEvent("enterPortal",_local1);
         } else {
            GA.global().trackEvent("enterPortal",this.owner_.getName());
         }
         doneAction(gs_,Tutorial.ENTER_PORTAL_ACTION);
         gs_.gsc_.usePortal(this.owner_.objectId_);
         this.exitGameSignal.dispatch();
      }

      override public function draw() : void {
         this.updateNameText();
         if(!this.owner_.lockedPortal_ && Boolean(this.owner_.active_) && Boolean(contains(this.fullText_))) {
            removeChild(this.fullText_);
            addChild(this.enterButton_);
         } else if((Boolean(this.owner_.lockedPortal_) || !this.owner_.active_) && Boolean(contains(this.enterButton_))) {
            removeChild(this.enterButton_);
            addChild(this.fullText_);
         }
      }

      private function updateNameText() : void {
         var _local1:String = this.getName();
         var _local2:StringBuilder = new LOEBUILD_3d035f7e69af9b21fea3e879f88e0ea2().makeBuilder(_local1);
         this.nameText_.setStringBuilder(_local2);
         this.nameText_.x = (WIDTH - this.nameText_.width) * 0.5;
         this.nameText_.y = this.nameText_.height > 30?Number(0):Number(6);
      }

      private function getName() : String {
         var _local1:String = this.owner_.getName();
         if(Boolean(this.owner_.lockedPortal_) && _local1.indexOf(this.LOCKED) == 0) {
            return _local1.substr(this.LOCKED.length);
         }
         return this.parseJson(_local1);
      }

      private function parseJson(param1:String) : String {
         var _local2:Array = param1.match(this.TEXT_PATTERN);
         return !!_local2?_local2[1]:param1;
      }
   }
}
