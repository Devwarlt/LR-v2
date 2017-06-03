package com.company.assembleegameclient.account.ui {
import com.company.assembleegameclient.account.ui.LOEBUILD_4725dcf446a342f1473a8228e42dfa48.LOEBUILD_8318ce1c96df6ce21eb2ed428c6d0f85;
import com.company.assembleegameclient.account.ui.LOEBUILD_4725dcf446a342f1473a8228e42dfa48.LOEBUILD_8ba219ec2bd30c58b2939423aa97781b;
import com.company.assembleegameclient.util.offer.Offer;
import com.company.assembleegameclient.util.offer.Offers;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;

import kabam.lib.ui.api.Layout;
import kabam.lib.ui.impl.VerticalLayout;
import kabam.rotmg.account.core.model.MoneyConfig;

public class LOEBUILD_cb72693e3c4f933869f7a6ea4f77ddb2 extends Sprite {

      private var offers:Offers;

      private var config:MoneyConfig;

      private var choices:Vector.<LOEBUILD_62967dbbfb62a7d1ad36cb3513ba9e20>;

      private var group:LOEBUILD_8ba219ec2bd30c58b2939423aa97781b;

      public function LOEBUILD_cb72693e3c4f933869f7a6ea4f77ddb2(param1:Offers, param2:MoneyConfig) {
         super();
         this.offers = param1;
         this.config = param2;
         this.makeGoldChoices();
         this.alignGoldChoices();
         this.makeSelectionGroup();
      }

      public function getChoice() : LOEBUILD_62967dbbfb62a7d1ad36cb3513ba9e20 {
         return this.group.getSelected() as LOEBUILD_62967dbbfb62a7d1ad36cb3513ba9e20;
      }

      private function makeGoldChoices() : void {
         var _local1:int = this.offers.offerList.length;
         this.choices = new Vector.<LOEBUILD_62967dbbfb62a7d1ad36cb3513ba9e20>(_local1,true);
         var _local2:int = 0;
         while(_local2 < _local1) {
            this.choices[_local2] = this.makeGoldChoice(this.offers.offerList[_local2]);
            _local2++;
         }
      }

      private function makeGoldChoice(param1:Offer) : LOEBUILD_62967dbbfb62a7d1ad36cb3513ba9e20 {
         var _local2:LOEBUILD_62967dbbfb62a7d1ad36cb3513ba9e20 = new LOEBUILD_62967dbbfb62a7d1ad36cb3513ba9e20(param1,this.config);
         _local2.addEventListener(MouseEvent.CLICK,this.onSelected);
         addChild(_local2);
         return _local2;
      }

      private function onSelected(param1:MouseEvent) : void {
         var _local2:LOEBUILD_8318ce1c96df6ce21eb2ed428c6d0f85 = param1.currentTarget as LOEBUILD_8318ce1c96df6ce21eb2ed428c6d0f85;
         this.group.setSelected(_local2.getValue());
      }

      private function alignGoldChoices() : void {
         var _local1:Vector.<DisplayObject> = this.castChoicesToDisplayList();
         var _local2:Layout = new VerticalLayout();
         _local2.setPadding(5);
         _local2.layout(_local1);
      }

      private function castChoicesToDisplayList() : Vector.<DisplayObject> {
         var _local1:int = this.choices.length;
         var _local2:Vector.<DisplayObject> = new Vector.<DisplayObject>(0);
         var _local3:int = 0;
         while(_local3 < _local1) {
            _local2[_local3] = this.choices[_local3];
            _local3++;
         }
         return _local2;
      }

      private function makeSelectionGroup() : void {
         var _local1:Vector.<LOEBUILD_8318ce1c96df6ce21eb2ed428c6d0f85> = this.castBoxesToSelectables();
         this.group = new LOEBUILD_8ba219ec2bd30c58b2939423aa97781b(_local1);
         this.group.setSelected(this.choices[0].getValue());
      }

      private function castBoxesToSelectables() : Vector.<LOEBUILD_8318ce1c96df6ce21eb2ed428c6d0f85> {
         var _local1:int = this.choices.length;
         var _local2:Vector.<LOEBUILD_8318ce1c96df6ce21eb2ed428c6d0f85> = new Vector.<LOEBUILD_8318ce1c96df6ce21eb2ed428c6d0f85>(0);
         var _local3:int = 0;
         while(_local3 < _local1) {
            _local2[_local3] = this.choices[_local3];
            _local3++;
         }
         return _local2;
      }

      public function showBonuses(param1:Boolean) : void {
         var _local2:int = this.choices.length;
         while(_local2--) {
            this.choices[_local2].showBonus(param1);
         }
      }
   }
}
