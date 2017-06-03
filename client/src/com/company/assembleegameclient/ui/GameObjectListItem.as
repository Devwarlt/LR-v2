package com.company.assembleegameclient.ui {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;
import kabam.rotmg.assets.model.Player;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.util.MoreColorUtil;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.filters.DropShadowFilter;
import flash.geom.ColorTransform;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.TemplateBuilder;

import org.osflash.signals.Signal;

public class GameObjectListItem extends Sprite {

      public var portrait:Bitmap;

      private var text:TextFieldDisplayConcrete;

      private var builder:TemplateBuilder;

      private var color:uint;

      public var isLongVersion:Boolean;

      public var go:GameObject;

      public var textReady:Signal;

      private var objname:String;

      private var type:int;

      private var level:int;

      private var positionClassBelow:Boolean;

      public function GameObjectListItem(param1:uint, param2:Boolean, param3:GameObject, param4:Boolean = false) {
         super();
         this.positionClassBelow = param4;
         this.isLongVersion = param2;
         this.color = param1;
         this.portrait = new Bitmap();
         this.portrait.x = -4;
         this.portrait.y = !!param4?Number(-1):Number(-4);
         addChild(this.portrait);
         this.text = new TextFieldDisplayConcrete().setSize(13).setColor(param1).setHTML(param2);
         if(!param2) {
            this.text.setTextWidth(66).setTextHeight(20).setBold(true);
         }
         this.text.x = 32;
         this.text.y = 6;
         this.text.filters = [new DropShadowFilter(0,0,0)];
         addChild(this.text);
         this.textReady = this.text.textChanged;
         this.draw(param3);
      }

      public function draw(param1:GameObject, param2:ColorTransform = null) : void {
         var _local3:Boolean = false;
         _local3 = this.isClear();
         this.go = param1;
         visible = param1 != null;
         if(Boolean(visible) && (Boolean(this.hasChanged()) || Boolean(_local3))) {
            this.redraw();
            transform.colorTransform = param2 || MoreColorUtil.identity;
         }
      }

      public function clear() : void {
         this.go = null;
         visible = false;
      }

      public function isClear() : Boolean {
         return this.go == null && visible == false;
      }

      private function hasChanged() : Boolean {
         var _local1:Boolean = this.go.name_ != this.objname || this.go.level_ != this.level || this.go.objectType_ != this.type;
         _local1 && this.updateData();
         return _local1;
      }

      private function updateData() : void {
         this.objname = this.go.name_;
         this.level = this.go.level_;
         this.type = this.go.objectType_;
      }

      private function redraw() : void {
         this.portrait.bitmapData = this.go.getPortrait();
         this.text.setStringBuilder(this.prepareText());
         this.text.setColor(this.getDrawColor());
         this.text.update();
      }

      private function prepareText() : TemplateBuilder {
         this.builder = this.builder || new TemplateBuilder();
         if(this.isLongVersion) {
            this.applyLongTextToBuilder();
         } else if(this.isNameDefined()) {
            this.builder.setTemplate(this.objname);
         } else {
            this.builder.setTemplate(LOEBUILD_efda783509bc93eea698457c87bbee3f.typeToDisplayId_[this.type]);
         }
         return this.builder;
      }

      private function applyLongTextToBuilder() : void {
         var _local1:String = null;
         var _local2:Object = {};
         if(this.isNameDefined()) {
            if(this.positionClassBelow) {
               _local1 = "<b>{name}</b>\n(Lvl: {level})";
            } else {
               _local1 = "<b>{name}</b>\n(Lvl: {level})";
            }
             _local2.name = this.go.name_;
            /*if(this.go.name_.length > 8 && !this.positionClassBelow) {
               _local2.name = this.go.name_.slice(0,6) + "...";
            } else {
               _local2.name = this.go.name_;
            }*/
            _local2.type = LOEBUILD_efda783509bc93eea698457c87bbee3f.typeToDisplayId_[this.type];
            _local2.level = this.level < 1?"":" " + this.level;
         } else {
            _local1 = "<b>{name}</b>";
            _local2.name = LOEBUILD_efda783509bc93eea698457c87bbee3f.typeToDisplayId_[this.type];
         }
         this.builder.setTemplate(_local1,_local2);
      }

      private function isNameDefined() : Boolean {
         return this.go.name_ != null && this.go.name_ != "";
      }

      private function getDrawColor() : int {
         var _local1:Player = this.go as Player;
         if(_local1 == null) {
            return this.color;
         }
         if(_local1.isFellowGuild_) {
            return LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.FELLOW_GUILD_COLOR;
         }
         if(_local1.nameChosen_) {
            return LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.NAME_CHOSEN_COLOR;
         }
         return this.color;
      }
   }
}
