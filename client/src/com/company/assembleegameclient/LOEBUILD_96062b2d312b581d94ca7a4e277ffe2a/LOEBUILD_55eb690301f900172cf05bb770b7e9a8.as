package com.company.assembleegameclient.LOEBUILD_96062b2d312b581d94ca7a4e277ffe2a {
import com.company.assembleegameclient.map.LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5;
import com.company.assembleegameclient.map.LOEBUILD_bc44e55f2b7833506dc8a2b0246803f4;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;
import com.company.ui.BaseSimpleText;
import com.company.util.GraphicsUtil;

import flash.display.CapsStyle;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.IGraphicsData;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;
import flash.events.Event;
import flash.filters.DropShadowFilter;
import flash.geom.Rectangle;

public class LOEBUILD_55eb690301f900172cf05bb770b7e9a8 extends Sprite {

      public static const WIDTH:int = 134;

      public static const HEIGHT:int = 120;

      private static const CSS_TEXT:String = ".in { margin-left:10px; text-indent: -10px; }";

      private var meMap_:LOEBUILD_d5569d48c9e4a976a51c625e3a800107;

      private var rectText_:BaseSimpleText;

      private var typeText_:BaseSimpleText;

      private var outlineFill_:GraphicsSolidFill;

      private var lineStyle_:GraphicsStroke;

      private var backgroundFill_:GraphicsSolidFill;

      private var path_:GraphicsPath;

      private const graphicsData_:Vector.<IGraphicsData> = new <IGraphicsData>[lineStyle_,backgroundFill_,path_,GraphicsUtil.END_FILL,GraphicsUtil.END_STROKE];

      public function LOEBUILD_55eb690301f900172cf05bb770b7e9a8(param1:LOEBUILD_d5569d48c9e4a976a51c625e3a800107) {
         this.outlineFill_ = new GraphicsSolidFill(16777215,1);
         this.lineStyle_ = new GraphicsStroke(1,false,LineScaleMode.NORMAL,CapsStyle.NONE,JointStyle.ROUND,3,this.outlineFill_);
         this.backgroundFill_ = new GraphicsSolidFill(3552822,1);
         this.path_ = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
         super();
         this.meMap_ = param1;
         this.drawBackground();
         this.rectText_ = new BaseSimpleText(12,16777215,false,WIDTH - 10,0);
         this.rectText_.filters = [new DropShadowFilter(0,0,0)];
         this.rectText_.y = 4;
         this.rectText_.x = 4;
         addChild(this.rectText_);
         this.typeText_ = new BaseSimpleText(12,16777215,false,WIDTH - 10,0);
         this.typeText_.wordWrap = true;
         this.typeText_.filters = [new DropShadowFilter(0,0,0)];
         this.typeText_.x = 4;
         this.typeText_.y = 36;
         addChild(this.typeText_);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }

      private function onAddedToStage(param1:Event) : void {
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }

      private function onRemovedFromStage(param1:Event) : void {
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }

      private function onEnterFrame(param1:Event) : void {
         var _local2:Rectangle = this.meMap_.mouseRectT();
         this.rectText_.text = "Position: " + _local2.x + ", " + _local2.y;
         if(_local2.width > 1 || _local2.height > 1) {
            this.rectText_.text = this.rectText_.text + ("\nRect: " + _local2.width + ", " + _local2.height);
         }
         this.rectText_.useTextDimensions();
         var _local3:LOEBUILD_822148805b3866cb113421c05e57390d = this.meMap_.getTile(_local2.x,_local2.y);
         var _local4:Vector.<int> = _local3 == null?LOEBUILD_359b71e88f40029251366609358a302f.EMPTY_TILE:_local3.types_;
         var _local5:String = _local4[LOEBUILD_359b71e88f40029251366609358a302f.GROUND] == -1?"None":LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5.getIdFromType(_local4[LOEBUILD_359b71e88f40029251366609358a302f.GROUND]);
         var _local6:String = _local4[LOEBUILD_359b71e88f40029251366609358a302f.OBJECT] == -1?"None":LOEBUILD_efda783509bc93eea698457c87bbee3f.getIdFromType(_local4[LOEBUILD_359b71e88f40029251366609358a302f.OBJECT]);
         var _local7:String = _local4[LOEBUILD_359b71e88f40029251366609358a302f.REGION] == -1?"None":LOEBUILD_bc44e55f2b7833506dc8a2b0246803f4.getIdFromType(_local4[LOEBUILD_359b71e88f40029251366609358a302f.REGION]);
         this.typeText_.htmlText = "<span class=\'in\'>" + "Ground: " + _local5 + "\nObject: " + _local6 + (_local3 == null || _local3.objName_ == null?"":" (" + _local3.objName_ + ")") + "\nRegion: " + _local7 + "</span>";
         this.typeText_.useTextDimensions();
      }

      private function drawBackground() : void {
         GraphicsUtil.clearPath(this.path_);
         GraphicsUtil.drawCutEdgeRect(0,0,WIDTH,HEIGHT,4,[1,1,1,1],this.path_);
         graphics.drawGraphicsData(this.graphicsData_);
      }
   }
}
