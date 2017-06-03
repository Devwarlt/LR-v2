package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da {
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.GameSprite;
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.ui.panels.ArenaPortalPanel;
import com.company.assembleegameclient.ui.panels.Panel;

import flash.display.BitmapData;
import flash.display.IGraphicsData;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.text.view.BitmapTextFactory;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class ArenaPortal extends Portal implements LOEBUILD_5e926ae2981199c65b99066bd9e14d29 {

      public function ArenaPortal(param1:XML) {
         super(param1);
         isInteractive_ = true;
         name_ = "";
      }

      override public function getPanel(param1:GameSprite) : Panel {
         return new ArenaPortalPanel(param1,this);
      }

      override public function draw(param1:Vector.<IGraphicsData>, param2:Camera, param3:int) : void {
         super.draw(param1,param2,param3);
         drawName(param1,param2);
      }

      override protected function makeNameBitmapData() : BitmapData {
         var _local1:StringBuilder = new StaticStringBuilder(name_);
         var _local2:BitmapTextFactory = StaticInjectorContext.getInjector().getInstance(BitmapTextFactory);
         return _local2.make(_local1,16,16777215,true,IDENTITY_MATRIX,true);
      }
   }
}
