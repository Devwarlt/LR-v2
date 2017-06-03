package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da {
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.GameSprite;
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.ui.panels.Panel;
import com.company.assembleegameclient.ui.panels.PortalPanel;

import flash.display.BitmapData;
import flash.display.IGraphicsData;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.text.view.BitmapTextFactory;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class Portal extends GameObject implements LOEBUILD_5e926ae2981199c65b99066bd9e14d29 {

      private static const NAME_PARSER:RegExp = new RegExp("(^\\s+)\\s\\(([0-9]+)\\/[0-9]+\\)");

      public var nexusPortal_:Boolean;

      public var lockedPortal_:Boolean;

      public var active_:Boolean = true;

      public function Portal(param1:XML) {
         super(param1);
         isInteractive_ = true;
         this.nexusPortal_ = param1.hasOwnProperty("NexusPortal");
         this.lockedPortal_ = param1.hasOwnProperty("LockedPortal");
      }

      override protected function makeNameBitmapData() : BitmapData {
         var _local1:Array = name_.match(NAME_PARSER);
         var _local2:StringBuilder = new LOEBUILD_3d035f7e69af9b21fea3e879f88e0ea2().makeBuilder(name_);
         var _local3:BitmapTextFactory = StaticInjectorContext.getInjector().getInstance(BitmapTextFactory);
         return _local3.make(_local2,16,16777215,true,IDENTITY_MATRIX,true);
      }

      override public function draw(param1:Vector.<IGraphicsData>, param2:Camera, param3:int) : void {
         super.draw(param1,param2,param3);
         if(this.nexusPortal_) {
            drawName(param1,param2);
         }
      }

      public function getPanel(param1:GameSprite) : Panel {
         return new PortalPanel(param1,this);
      }
   }
}
