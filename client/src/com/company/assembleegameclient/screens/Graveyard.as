package com.company.assembleegameclient.screens {
import com.company.assembleegameclient.LOEBUILD_1f4c42c309fe6bc45253d598cfdf9b99.LOEBUILD_7ef38360d46d56d4f3d5cdf71860fef5;

import flash.display.Sprite;

import kabam.rotmg.core.model.PlayerModel;

public class Graveyard extends Sprite {

      private var lines_:Vector.<GraveyardLine>;

      private var hasCharacters_:Boolean = false;

      public function Graveyard(param1:PlayerModel) {
         var _local2:LOEBUILD_7ef38360d46d56d4f3d5cdf71860fef5 = null;
         this.lines_ = new Vector.<GraveyardLine>();
         super();
         for each(_local2 in param1.getNews()) {
            if(_local2.isCharDeath()) {
               this.addLine(new GraveyardLine(_local2.getIcon(),_local2.title_,_local2.tagline_,_local2.link_,_local2.date_,param1.getAccountId()));
               this.hasCharacters_ = true;
            }
         }
      }

      public function hasCharacters() : Boolean {
         return this.hasCharacters_;
      }

      public function addLine(param1:GraveyardLine) : void {
         param1.y = 4 + this.lines_.length * (GraveyardLine.HEIGHT + 4);
         this.lines_.push(param1);
         addChild(param1);
      }
   }
}
