package com.company.assembleegameclient.LOEBUILD_96062b2d312b581d94ca7a4e277ffe2a {
import com.company.assembleegameclient.ui.tooltip.ToolTip;
import com.company.ui.BaseSimpleText;

import flash.filters.DropShadowFilter;

public class LOEBUILD_2cd8ef38079f92043aece0726158bb30 extends ToolTip {

      private static const MAX_WIDTH:int = 180;

      private var titleText_:BaseSimpleText;

      private var descText_:BaseSimpleText;

      public function LOEBUILD_2cd8ef38079f92043aece0726158bb30(param1:XML) {
         var _local3:XML = null;
         super(3552822,1,10197915,1,true);
         this.titleText_ = new BaseSimpleText(16,16777215,false,MAX_WIDTH - 4,0);
         this.titleText_.setBold(true);
         this.titleText_.wordWrap = true;
         this.titleText_.text = String(param1.@id);
         this.titleText_.useTextDimensions();
         this.titleText_.filters = [new DropShadowFilter(0,0,0,0.5,12,12)];
         this.titleText_.x = 0;
         this.titleText_.y = 0;
         addChild(this.titleText_);
         var _local2:* = "";
         if(param1.hasOwnProperty("Group")) {
            _local2 = _local2 + ("Group: " + param1.Group + "\n");
         }
         if(param1.hasOwnProperty("Static")) {
            _local2 = _local2 + "Static\n";
         }
         if(param1.hasOwnProperty("Enemy")) {
            _local2 = _local2 + "Enemy\n";
            if(param1.hasOwnProperty("MaxHitPoints")) {
               _local2 = _local2 + ("MaxHitPoints: " + param1.MaxHitPoints + "\n");
            }
            if(param1.hasOwnProperty("Defense")) {
               _local2 = _local2 + ("Defense: " + param1.Defense + "\n");
            }
         }
         if(param1.hasOwnProperty("God")) {
            _local2 = _local2 + "God\n";
         }
         if(param1.hasOwnProperty("Quest")) {
            _local2 = _local2 + "Quest\n";
         }
         if(param1.hasOwnProperty("Hero")) {
            _local2 = _local2 + "Hero\n";
         }
         if(param1.hasOwnProperty("Encounter")) {
            _local2 = _local2 + "Encounter\n";
         }
         if(param1.hasOwnProperty("Level")) {
            _local2 = _local2 + ("Level: " + param1.Level + "\n");
         }
         if(param1.hasOwnProperty("Terrain")) {
            _local2 = _local2 + ("Terrain: " + param1.Terrain + "\n");
         }
         for each(_local3 in param1.Projectile) {
            _local2 = _local2 + ("Projectile " + _local3.@id + ": " + _local3.ObjectId + "\n" + "\tDamage: " + _local3.Damage + "\n" + "\tSpeed: " + _local3.Speed + "\n");
            if(_local3.hasOwnProperty("PassesCover")) {
               _local2 = _local2 + "\tPassesCover\n";
            }
            if(_local3.hasOwnProperty("MultiHit")) {
               _local2 = _local2 + "\tMultiHit\n";
            }
            if(_local3.hasOwnProperty("ConditionEffect")) {
               _local2 = _local2 + ("\t" + _local3.ConditionEffect + " for " + _local3.ConditionEffect.@duration + " secs\n");
            }
            if(_local3.hasOwnProperty("Parametric")) {
               _local2 = _local2 + "\tParametric\n";
            }
         }
         this.descText_ = new BaseSimpleText(14,11776947,false,MAX_WIDTH,0);
         this.descText_.wordWrap = true;
         this.descText_.text = String(_local2);
         this.descText_.useTextDimensions();
         this.descText_.filters = [new DropShadowFilter(0,0,0,0.5,12,12)];
         this.descText_.x = 0;
         this.descText_.y = this.titleText_.height + 2;
         addChild(this.descText_);
      }
   }
}
