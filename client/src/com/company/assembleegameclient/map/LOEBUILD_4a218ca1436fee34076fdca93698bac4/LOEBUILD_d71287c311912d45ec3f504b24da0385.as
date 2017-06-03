package com.company.assembleegameclient.map.LOEBUILD_4a218ca1436fee34076fdca93698bac4 {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;
import kabam.rotmg.assets.model.Player;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.util.GraphicsUtil;

import flash.display.CapsStyle;
import flash.display.GraphicsPath;
import flash.display.GraphicsPathCommand;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.IGraphicsData;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.geom.Point;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.ui.model.HUDModel;

public class LOEBUILD_d71287c311912d45ec3f504b24da0385 extends Sprite implements LOEBUILD_9842b5c73c563ba5cc56f3d815afd768 {

      public var go_:GameObject;

      public var lifetime_:int;

      public var hideable_:Boolean;

      public var offset_:Point;

      public var text_:TextField;

      private var backgroundFill_:GraphicsSolidFill;

      private var outlineFill_:GraphicsSolidFill;

      private var lineStyle_:GraphicsStroke;

      private var path_:GraphicsPath;

      private var graphicsData_:Vector.<IGraphicsData>;

      private var senderName:String;

      private var isTrade:Boolean;

      private var isGuild:Boolean;

      private var startTime_:int = 0;

      public function LOEBUILD_d71287c311912d45ec3f504b24da0385(param1:GameObject, param2:String, param3:String, param4:Boolean, param5:Boolean, param6:uint, param7:Number, param8:uint, param9:Number, param10:uint, param11:int, param12:Boolean, param13:Boolean) {
         this.offset_ = new Point();
         this.backgroundFill_ = new GraphicsSolidFill(0,1);
         this.outlineFill_ = new GraphicsSolidFill(16777215,1);
         this.lineStyle_ = new GraphicsStroke(2,false,LineScaleMode.NORMAL,CapsStyle.NONE,JointStyle.ROUND,3,this.outlineFill_);
         this.path_ = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
         this.graphicsData_ = new <IGraphicsData>[lineStyle_,backgroundFill_,path_,GraphicsUtil.END_FILL,GraphicsUtil.END_STROKE];
         super();
         this.go_ = param1;
         this.senderName = param3;
         this.isTrade = param4;
         this.isGuild = param5;
         this.lifetime_ = param11 * 1000;
         this.hideable_ = param13;
         this.text_ = new TextField();
         this.text_.autoSize = TextFieldAutoSize.LEFT;
         this.text_.embedFonts = true;
         this.text_.width = 150;
         var _local14:TextFormat = new TextFormat();
         _local14.font = "Myriad Pro";
         _local14.size = 14;
         _local14.bold = param12;
         _local14.color = param10;
         this.text_.defaultTextFormat = _local14;
         this.text_.selectable = false;
         this.text_.mouseEnabled = false;
         this.text_.multiline = true;
         this.text_.wordWrap = true;
         this.text_.text = param2;
         addChild(this.text_);
         var _local15:int = this.text_.textWidth + 4;
         this.offset_.x = -_local15 / 2;
         this.backgroundFill_.color = param6;
         this.backgroundFill_.alpha = param7;
         this.outlineFill_.color = param8;
         this.outlineFill_.alpha = param9;
         graphics.clear();
         GraphicsUtil.clearPath(this.path_);
         GraphicsUtil.drawCutEdgeRect(-6,-6,_local15 + 12,height + 12,4,[1,1,1,1],this.path_);
         this.path_.commands.splice(6,0,GraphicsPathCommand.LINE_TO,GraphicsPathCommand.LINE_TO,GraphicsPathCommand.LINE_TO);
         var _local16:int = height;
         this.path_.data.splice(12,0,_local15 / 2 + 8,_local16 + 6,_local15 / 2,_local16 + 18,_local15 / 2 - 8,_local16 + 6);
         graphics.drawGraphicsData(this.graphicsData_);
         filters = [new DropShadowFilter(0,0,0,1,16,16)];
         this.offset_.y = -height - this.go_.texture_.height * (param1.size_ / 100) * 5 - 2;
         visible = false;
         addEventListener(MouseEvent.RIGHT_CLICK,this.onSpeechBalloonRightClicked);
      }

      private function onSpeechBalloonRightClicked(param1:MouseEvent) : void {
         var hmod:HUDModel = null;
         var aPlayer:Player = null;
         var e:MouseEvent = param1;
         var playerObjectId:int = this.go_.objectId_;
         try {
            hmod = StaticInjectorContext.getInjector().getInstance(HUDModel);
            if(hmod.gameSprite.map.goDict_[playerObjectId] != null && hmod.gameSprite.map.goDict_[playerObjectId] is Player && hmod.gameSprite.map.player_.objectId_ != playerObjectId) {
               aPlayer = hmod.gameSprite.map.goDict_[playerObjectId] as Player;
               hmod.gameSprite.addChatPlayerMenu(aPlayer,e.stageX,e.stageY);
            } else if(!this.isTrade && this.senderName != null && this.senderName != "" && hmod.gameSprite.map.player_.name_ != this.senderName) {
               hmod.gameSprite.addChatPlayerMenu(null,e.stageX,e.stageY,this.senderName,this.isGuild);
            } else if(Boolean(this.isTrade) && this.senderName != null && this.senderName != "" && hmod.gameSprite.map.player_.name_ != this.senderName) {
               hmod.gameSprite.addChatPlayerMenu(null,e.stageX,e.stageY,this.senderName,false,true);
            }
            return;
         }
         catch(e:Error) {
            return;
         }
      }

      public function draw(param1:Camera, param2:int) : Boolean {
         if(this.startTime_ == 0) {
            this.startTime_ = param2;
         }
         var _local3:int = param2 - this.startTime_;
         if(_local3 > this.lifetime_ || this.go_ != null && this.go_.map_ == null) {
            return false;
         }
         if(this.go_ == null || !this.go_.drawn_) {
            visible = false;
            return true;
         }
         if(Boolean(this.hideable_) && !LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.textBubbles) {
            visible = false;
            return true;
         }
         visible = true;
         x = int(this.go_.posS_[0] + this.offset_.x);
         y = int(this.go_.posS_[1] + this.offset_.y);
         return true;
      }

      public function getGameObject() : GameObject {
         return this.go_;
      }

      public function dispose() : void {
         parent.removeChild(this);
      }
   }
}
