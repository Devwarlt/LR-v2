package com.company.assembleegameclient.screens {
import com.company.assembleegameclient.LOEBUILD_1f4c42c309fe6bc45253d598cfdf9b99.LOEBUILD_9ef2cbbbd6e1617e4401a08c93ad0f9c;
import com.company.assembleegameclient.LOEBUILD_1f4c42c309fe6bc45253d598cfdf9b99.LOEBUILD_7ebef6bdf3535c86294f666e62e89578;
import com.company.assembleegameclient.ui.tooltip.ClassToolTip;
import com.company.assembleegameclient.ui.tooltip.ToolTip;
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.Currency;
import com.company.assembleegameclient.util.FameUtil;
import com.company.rotmg.graphics.FullCharBoxGraphic;
import com.company.rotmg.graphics.LockedCharBoxGraphic;
import com.company.rotmg.graphics.StarGraphic;
import com.company.util.AssetLibrary;
import com.company.util.GTween;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.geom.ColorTransform;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.util.components.LegacyBuyButton;

import org.osflash.signals.natives.NativeSignal;

public class CharacterBox extends Sprite {

      public static const DELETE_CHAR:String = "DELETE_CHAR";

      public static const ENTER_NAME:String = "ENTER_NAME";

      private static const fullCT:ColorTransform = new ColorTransform(0.8,0.8,0.8);

      private static const emptyCT:ColorTransform = new ColorTransform(0.2,0.2,0.2);

      private var SaleTag:Class;

      public var playerXML_:XML = null;

      public var charStats_:LOEBUILD_9ef2cbbbd6e1617e4401a08c93ad0f9c;

      public var model:PlayerModel;

      public var available_:Boolean;

      private var graphicContainer_:Sprite;

      private var graphic_:Sprite;

      private var bitmap_:Bitmap;

      private var statusText_:TextFieldDisplayConcrete;

      private var classNameText_:TextFieldDisplayConcrete;

      private var buyButton_:LegacyBuyButton;

      private var cost:int = 0;

      private var lock_:Bitmap;

      private var saleText_:TextFieldDisplayConcrete;

      private var unlockedText_:TextFieldDisplayConcrete;

      private var saleTag_;

      public var buyButtonClicked_:NativeSignal;

      public var characterSelectClicked_:NativeSignal;

      public function CharacterBox(param1:XML, param2:LOEBUILD_9ef2cbbbd6e1617e4401a08c93ad0f9c, param3:PlayerModel, param4:Boolean = false) {
         var _local5:Sprite = null;
         this.SaleTag = CharacterBox_SaleTag;
         super();
         this.model = param3;
         this.playerXML_ = param1;
         this.charStats_ = param2;
         this.available_ = Boolean(param4) || Boolean(param3.isLevelRequirementsMet(this.objectType()));
         if(!this.available_) {
            this.graphic_ = new LockedCharBoxGraphic();
            this.cost = this.playerXML_.UnlockCost;
         } else {
            this.graphic_ = new FullCharBoxGraphic();
         }
         this.graphicContainer_ = new Sprite();
         addChild(this.graphicContainer_);
         this.graphicContainer_.addChild(this.graphic_);
         this.characterSelectClicked_ = new NativeSignal(this.graphicContainer_,MouseEvent.CLICK,MouseEvent);
         this.bitmap_ = new Bitmap(null);
         this.setImage(AnimatedChar.DOWN,AnimatedChar.STAND,0);
         this.graphic_.addChild(this.bitmap_);
         this.classNameText_ = new TextFieldDisplayConcrete().setSize(14).setColor(16777215).setAutoSize(TextFieldAutoSize.CENTER).setTextWidth(this.graphic_.width).setBold(true);
         this.classNameText_.setStringBuilder(new LineBuilder().setParams(this.playerXML_.DisplayId));
         this.classNameText_.filters = [new DropShadowFilter(0,0,0,1,4,4)];
         this.graphic_.addChild(this.classNameText_);
         this.setBuyButton();
         this.setStatusButton();
         if(this.available_) {
            _local5 = this.getStars(FameUtil.numStars(param3.getBestFame(this.objectType())),FameUtil.STARS.length);
            _local5.y = 60;
            _local5.x = this.graphic_.width / 2 - _local5.width / 2;
            _local5.filters = [new DropShadowFilter(0,0,0,1,4,4)];
            this.graphicContainer_.addChild(_local5);
            this.classNameText_.y = 74;
         } else {
            addChild(this.buyButton_);
            this.lock_ = new Bitmap(AssetLibrary.getImageFromSet("lofiInterface2",5));
            this.lock_.scaleX = 2;
            this.lock_.scaleY = 2;
            this.lock_.x = 4;
            this.lock_.y = 8;
            addChild(this.lock_);
            addChild(this.statusText_);
            this.classNameText_.y = 78;
         }
      }

      public function objectType() : int {
         return int(this.playerXML_.@type);
      }

      public function unlock() : void {
         var _local1:Sprite = null;
         var _local2:GTween = null;
         if(this.available_ == false) {
            this.available_ = true;
            this.graphicContainer_.removeChild(this.graphic_);
            this.graphic_ = new FullCharBoxGraphic();
            this.graphicContainer_.addChild(this.graphic_);
            this.setImage(AnimatedChar.DOWN,AnimatedChar.STAND,0);
            this.graphic_.addChild(this.bitmap_);
            this.graphic_.addChild(this.classNameText_);
            if(contains(this.statusText_)) {
               removeChild(this.statusText_);
            }
            if(contains(this.buyButton_)) {
               removeChild(this.buyButton_);
            }
            if(Boolean(this.lock_) && Boolean(contains(this.lock_))) {
               removeChild(this.lock_);
            }
            if(Boolean(this.saleTag_) && Boolean(contains(this.saleTag_))) {
               removeChild(this.saleTag_);
            }
            if(Boolean(this.saleText_) && Boolean(contains(this.saleText_))) {
               removeChild(this.saleText_);
            }
            _local1 = this.getStars(FameUtil.numStars(this.model.getBestFame(this.objectType())),FameUtil.STARS.length);
            _local1.y = 60;
            _local1.x = this.graphic_.width / 2 - _local1.width / 2;
            _local1.filters = [new DropShadowFilter(0,0,0,1,4,4)];
            addChild(_local1);
            this.classNameText_.y = 74;
            if(!this.unlockedText_) {
               this.getCharacterUnlockText();
            }
            addChild(this.unlockedText_);
            _local2 = new GTween(this.unlockedText_,2.5,{
               "alpha":0,
               "y":-30
            });
            _local2.onComplete = this.removeUnlockText;
         }
      }

      private function removeUnlockText(param1:GTween) : void {
         removeChild(this.unlockedText_);
      }

      public function getTooltip() : ToolTip {
         return new ClassToolTip(this.playerXML_,this.model,this.charStats_);
      }

      public function setOver(param1:Boolean) : void {
         if(!this.available_) {
            return;
         }
         if(param1) {
            transform.colorTransform = new ColorTransform(1.2,1.2,1.2);
         } else {
            transform.colorTransform = new ColorTransform(1,1,1);
         }
      }

      private function setImage(param1:int, param2:int, param3:Number) : void {
         this.bitmap_.bitmapData = LOEBUILD_7ebef6bdf3535c86294f666e62e89578.getImage(null,this.playerXML_,param1,param2,param3,this.available_,false);
         this.bitmap_.x = this.graphic_.width / 2 - this.bitmap_.bitmapData.width / 2;
      }

      private function getStars(param1:int, param2:int) : Sprite {
         var _local5:Sprite = null;
         var _local3:Sprite = new Sprite();
         var _local4:int = 0;
         var _local6:int = 0;
         while(_local4 < param1) {
            _local5 = new StarGraphic();
            _local5.x = _local6;
            _local5.transform.colorTransform = fullCT;
            _local3.addChild(_local5);
            _local6 = _local6 + _local5.width;
            _local4++;
         }
         while(_local4 < param2) {
            _local5 = new StarGraphic();
            _local5.x = _local6;
            _local5.transform.colorTransform = emptyCT;
            _local3.addChild(_local5);
            _local6 = _local6 + _local5.width;
            _local4++;
         }
         return _local3;
      }

      public function setSale(param1:int) : void {
         if(!this.saleTag_) {
            this.saleTag_ = new this.SaleTag();
            this.saleTag_.x = 38;
            this.saleTag_.y = 8;
            addChild(this.saleTag_);
         }
         if(!this.saleText_) {
            this.setSaleText();
            addChild(this.saleText_);
         }
         this.saleText_.setStringBuilder(new LineBuilder().setParams(TextKey.PERCENT_OFF,{"percent":String(param1)}));
      }

      private function setBuyButton() : void {
         this.buyButton_ = new LegacyBuyButton(TextKey.BUY_FOR,13,this.cost,Currency.GOLD);
         this.buyButton_.y = this.buyButton_.y + this.graphic_.height;
         this.buyButton_.setWidth(this.graphic_.width);
         this.buyButtonClicked_ = new NativeSignal(this.buyButton_,MouseEvent.CLICK,MouseEvent);
      }

      private function setStatusButton() : void {
         this.statusText_ = new TextFieldDisplayConcrete().setSize(14).setColor(16711680).setAutoSize(TextFieldAutoSize.CENTER).setBold(true).setTextWidth(this.graphic_.width);
         this.statusText_.setStringBuilder(new LineBuilder().setParams(TextKey.LOCKED));
         this.statusText_.filters = [new DropShadowFilter(0,0,0,1,4,4)];
         this.statusText_.y = 58;
      }

      private function setSaleText() : void {
         this.saleText_ = new TextFieldDisplayConcrete().setSize(14).setColor(16777215).setAutoSize(TextFieldAutoSize.CENTER).setBold(true).setTextHeight(this.saleTag_.height).setTextWidth(this.saleTag_.width);
         this.saleText_.x = 42;
         this.saleText_.y = 12;
      }

      private function getCharacterUnlockText() : void {
         this.unlockedText_ = new TextFieldDisplayConcrete().setSize(14).setColor(65280).setBold(true).setAutoSize(TextFieldAutoSize.CENTER);
         this.unlockedText_.filters = [new DropShadowFilter(0,0,0,1,4,4)];
         this.unlockedText_.setStringBuilder(new LineBuilder().setParams(TextKey.UNLOCK_CLASS));
         this.unlockedText_.y = -20;
      }

      public function setIsBuyButtonEnabled(param1:Boolean) : void {
         this.buyButton_.setEnabled(param1);
      }
   }
}
