package com.company.assembleegameclient.ui.tooltip {
import com.company.assembleegameclient.LOEBUILD_1f4c42c309fe6bc45253d598cfdf9b99.LOEBUILD_9ef2cbbbd6e1617e4401a08c93ad0f9c;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;
import com.company.assembleegameclient.ui.BottomBar;

import kabam.rotmg.assets.model.Player;
import com.company.assembleegameclient.ui.GameObjectListItem;
import com.company.assembleegameclient.ui.LineBreakDesign;
import com.company.assembleegameclient.ui.StatusBar;
import com.company.assembleegameclient.ui.panels.itemgrids.EquippedGrid;
import com.company.assembleegameclient.ui.panels.itemgrids.InventoryGrid;
import com.company.assembleegameclient.util.FameUtil;

import flash.filters.DropShadowFilter;

import kabam.rotmg.assets.services.CharacterFactory;
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.ClassesModel;
import kabam.rotmg.constants.GeneralConstants;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class MyPlayerToolTip extends ToolTip {

      private var factory:CharacterFactory;

      private var classes:ClassesModel;

      public var player_:Player;

      private var playerPanel_:GameObjectListItem;

      private var hpBar_:StatusBar;

      private var mpBar_:StatusBar;

      private var lineBreak_:LineBreakDesign;

      private var bestLevel_:TextFieldDisplayConcrete;

      private var nextClassQuest_:TextFieldDisplayConcrete;

      private var eGrid:EquippedGrid;

      private var iGrid:InventoryGrid;

      private var accountName:String;

      private var charXML:XML;

      private var charStats:LOEBUILD_9ef2cbbbd6e1617e4401a08c93ad0f9c;

      public function MyPlayerToolTip(param1:String, param2:XML, param3:LOEBUILD_9ef2cbbbd6e1617e4401a08c93ad0f9c) {
         super(3552822,1,16777215,1);
         this.accountName = param1;
         this.charXML = param2;
         this.charStats = param3;
      }

      public function createUI() : void {
         this.factory = StaticInjectorContext.getInjector().getInstance(CharacterFactory);
         this.classes = StaticInjectorContext.getInjector().getInstance(ClassesModel);
         var _local1:int = int(this.charXML.ObjectType);
         var _local2:XML = LOEBUILD_efda783509bc93eea698457c87bbee3f.xmlLibrary_[_local1];
         this.player_ = Player.fromPlayerXML(this.accountName,this.charXML);
         var _local3:CharacterClass = this.classes.getCharacterClass(this.player_.objectType_);
         var _local4:CharacterSkin = _local3.skins.getSkin(this.charXML.Texture);
         this.player_.animatedChar_ = this.factory.makeCharacter(_local4.template);
         this.playerPanel_ = new GameObjectListItem(11776947,true,this.player_);
         addChild(this.playerPanel_);
         this.hpBar_ = new StatusBar(176,16,TextKey.HUD_HP,2368548,TextKey.STATUS_BAR_HEALTH_POINTS);
         this.hpBar_.x = 6;
         this.hpBar_.y = 40;
         addChild(this.hpBar_);
         this.mpBar_ = new StatusBar(176,16,TextKey.HUD_MP,2368548,TextKey.STATUS_BAR_MANA_POINTS);
         this.mpBar_.x = 6;
         this.mpBar_.y = 64;
         addChild(this.mpBar_);
         this.eGrid = new EquippedGrid(null,this.player_.slotTypes_,this.player_);
         this.eGrid.x = 8;
         this.eGrid.y = 88;
         addChild(this.eGrid);
         this.eGrid.setItems(this.player_.equipment_);
         this.iGrid = new InventoryGrid(null,this.player_,GeneralConstants.NUM_EQUIPMENT_SLOTS);
         this.iGrid.x = 8;
         this.iGrid.y = 132;
         addChild(this.iGrid);
         this.iGrid.setItems(this.player_.equipment_);
         this.lineBreak_ = new LineBreakDesign(100,1842204);
         this.lineBreak_.x = 6;
         this.lineBreak_.y = 228;
         addChild(this.lineBreak_);
         this.makeBestLevelText();
         this.bestLevel_.x = 8;
         this.bestLevel_.y = height - 2;
         var _local5:int = FameUtil.nextStarFame(this.charStats == null?0:int(this.charStats.bestFame()),0);
         if(_local5 > 0) {
            this.makeNextClassQuestText(_local5,_local2);
         }
      }

      public function makeNextClassQuestText(param1:int, param2:XML) : void {
         this.nextClassQuest_ = new TextFieldDisplayConcrete().setSize(13).setColor(16549442).setTextWidth(174);
         this.nextClassQuest_.setStringBuilder(new LineBuilder().setParams(TextKey.MY_PLAYER_TOOL_TIP_NEXT_CLASS_QUEST,{
            "nextStarFame":param1,
            "character":param2.DisplayId
         }));
         this.nextClassQuest_.filters = [new DropShadowFilter(0,0,0)];
         addChild(this.nextClassQuest_);
         waiter.push(this.nextClassQuest_.textChanged);
      }

      public function makeBestLevelText() : void {
         this.bestLevel_ = new TextFieldDisplayConcrete().setSize(14).setColor(6206769);
         var _local1:int = this.charStats == null?0:int(this.charStats.numStars());
         var _local2:String = (this.charStats != null?this.charStats.bestLevel():0).toString();
         var _local3:String = (this.charStats != null?this.charStats.bestFame():0).toString();
         this.bestLevel_.setStringBuilder(new LineBuilder().setParams(TextKey.BESTLEVEL__STATS,{
            "numStars":_local1,
            "bestLevel":_local2,
            "fame":_local3
         }));
         this.bestLevel_.filters = [new DropShadowFilter(0,0,0)];
         addChild(this.bestLevel_);
         waiter.push(this.bestLevel_.textChanged);
      }

      override protected function alignUI() : void {
         if(this.nextClassQuest_) {
            this.nextClassQuest_.x = 8;
            this.nextClassQuest_.y = this.bestLevel_.getBounds(this).bottom - 2;
         }
      }

      override public function draw() : void {
         this.hpBar_.draw(this.player_.hp_,this.player_.maxHP_,this.player_.maxHPBoost_,this.player_.maxHPMax_);
         this.mpBar_.draw(this.player_.mp_,this.player_.maxMP_,this.player_.maxMPBoost_,this.player_.maxMPMax_);
         this.lineBreak_.setWidthColor(width - 10,1842204);
         super.draw();
      }
   }
}
