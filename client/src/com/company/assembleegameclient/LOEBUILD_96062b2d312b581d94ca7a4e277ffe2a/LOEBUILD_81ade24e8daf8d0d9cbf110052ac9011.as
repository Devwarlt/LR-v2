package com.company.assembleegameclient.LOEBUILD_96062b2d312b581d94ca7a4e277ffe2a {
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.GameSprite;
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.LOEBUILD_16908b0605f2645dfcb4c3a8d248cef3.LOEBUILD_a35bea838a74542d05b740b68b18431e;
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.LOEBUILD_16908b0605f2645dfcb4c3a8d248cef3.LOEBUILD_c7f41ff76637f7e98124a836c410d43a;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;

import flash.display.Sprite;
import flash.events.Event;

import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.servers.api.Server;

public class LOEBUILD_81ade24e8daf8d0d9cbf110052ac9011 extends Sprite {

      private var model:PlayerModel;

      private var server:Server;

      private var editingScreen_:LOEBUILD_34f4ffe74fc5ca3d97e6960de054082e;

      private var gameSprite_:GameSprite;

      public function LOEBUILD_81ade24e8daf8d0d9cbf110052ac9011() {
         super();
         this.editingScreen_ = new LOEBUILD_34f4ffe74fc5ca3d97e6960de054082e();
         this.editingScreen_.addEventListener(LOEBUILD_450e33d9168342a7d1649030f2d5b4e0.MAP_TEST,this.onMapTest);
         addChild(this.editingScreen_);
      }

      public function initialize(param1:PlayerModel, param2:Server) : void {
         this.model = param1;
         this.server = param2;
      }

      private function onMapTest(param1:LOEBUILD_450e33d9168342a7d1649030f2d5b4e0) : void {
         removeChild(this.editingScreen_);
         this.gameSprite_ = new GameSprite(this.server,LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.MAPTEST_GAMEID,false,this.model.getSavedCharacters()[0].charId(),-1,null,this.model,param1.mapJSON_,false);
         this.gameSprite_.isEditor = true;
         this.gameSprite_.addEventListener(Event.COMPLETE,this.onMapTestDone);
         this.gameSprite_.addEventListener(LOEBUILD_c7f41ff76637f7e98124a836c410d43a.RECONNECT,this.onMapTestDone);
         this.gameSprite_.addEventListener(LOEBUILD_a35bea838a74542d05b740b68b18431e.DEATH,this.onMapTestDone);
         addChild(this.gameSprite_);
      }

      private function onMapTestDone(param1:Event) : void {
         this.cleanupGameSprite();
         addChild(this.editingScreen_);
      }

      private function onClientUpdate(param1:Event) : void {
         this.cleanupGameSprite();
         addChild(this.editingScreen_);
      }

      private function cleanupGameSprite() : void {
         this.gameSprite_.removeEventListener(Event.COMPLETE,this.onMapTestDone);
         this.gameSprite_.removeEventListener(LOEBUILD_c7f41ff76637f7e98124a836c410d43a.RECONNECT,this.onMapTestDone);
         this.gameSprite_.removeEventListener(LOEBUILD_a35bea838a74542d05b740b68b18431e.DEATH,this.onMapTestDone);
         removeChild(this.gameSprite_);
         this.gameSprite_ = null;
      }
   }
}
