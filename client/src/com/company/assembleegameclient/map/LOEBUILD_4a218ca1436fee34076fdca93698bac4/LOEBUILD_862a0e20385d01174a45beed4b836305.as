package com.company.assembleegameclient.map.LOEBUILD_4a218ca1436fee34076fdca93698bac4 {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.filters.GlowFilter;
import flash.geom.Matrix;
import flash.geom.Point;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class LOEBUILD_862a0e20385d01174a45beed4b836305 extends Sprite implements LOEBUILD_9842b5c73c563ba5cc56f3d815afd768 {

      public const MAX_DRIFT:int = 40;

      public var go_:GameObject;

      public var offset_:Point;

      public var color_:uint;

      public var lifetime_:int;

      public var offsetTime_:int;

      private var startTime_:int = 0;

      private var textDisplay:TextFieldDisplayConcrete;

      public function LOEBUILD_862a0e20385d01174a45beed4b836305(param1:GameObject, param2:uint, param3:int, param4:int = 0) {
         super();
         this.go_ = param1;
         this.offset_ = new Point(0,-param1.texture_.height * (param1.size_ / 100) * 5 - 20);
         this.color_ = param2;
         this.lifetime_ = param3;
         this.offsetTime_ = param4;
         this.textDisplay = new TextFieldDisplayConcrete().setSize(24).setColor(param2).setBold(true);
         this.textDisplay.filters = [new GlowFilter(0,1,4,4,2,1)];
         addChild(this.textDisplay);
         visible = false;
      }

      public function draw(param1:Camera, param2:int) : Boolean {
         if(this.startTime_ == 0) {
            this.startTime_ = param2 + this.offsetTime_;
         }
         if(param2 < this.startTime_) {
            visible = false;
            return true;
         }
         var _local3:int = param2 - this.startTime_;
         if(_local3 > this.lifetime_ || this.go_ != null && this.go_.map_ == null) {
            return false;
         }
         if(this.go_ == null || !this.go_.drawn_) {
            visible = false;
            return true;
         }
         visible = true;
         x = (this.go_ != null?this.go_.posS_[0]:0) + (this.offset_ != null?this.offset_.x:0);
         var _local4:Number = _local3 / this.lifetime_ * this.MAX_DRIFT;
         y = (this.go_ != null?this.go_.posS_[1]:0) + (this.offset_ != null?this.offset_.y:0) - _local4;
         return true;
      }

      public function getGameObject() : GameObject {
         return this.go_;
      }

      public function dispose() : void {
         parent.removeChild(this);
      }

      public function setStringBuilder(param1:StringBuilder) : void {
         this.textDisplay.textChanged.add(this.onTextChanged);
         this.textDisplay.setStringBuilder(param1);
      }

      private function onTextChanged() : void {
         var _local2:Bitmap = null;
         var _local1:BitmapData = new BitmapData(this.textDisplay.width,this.textDisplay.height,true,0);
         _local2 = new Bitmap(_local1);
         _local1.draw(this.textDisplay,new Matrix());
         _local2.x = _local2.x - _local2.width * 0.5;
         _local2.y = _local2.y - _local2.height * 0.5;
         addChild(_local2);
         removeChild(this.textDisplay);
         this.textDisplay = null;
      }
   }
}
