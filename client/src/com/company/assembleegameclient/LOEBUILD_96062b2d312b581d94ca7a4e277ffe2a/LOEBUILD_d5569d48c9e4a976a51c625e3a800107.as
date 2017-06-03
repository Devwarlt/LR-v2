package com.company.assembleegameclient.LOEBUILD_96062b2d312b581d94ca7a4e277ffe2a {
import com.company.assembleegameclient.map.LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5;
import com.company.assembleegameclient.map.LOEBUILD_bc44e55f2b7833506dc8a2b0246803f4;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;
import com.company.assembleegameclient.util.BitmapDataSpy;
import com.company.util.AssetLibrary;
import com.company.util.IntPoint;
import com.company.util.KeyCodes;
import com.company.util.PointUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.ui.Keyboard;
import flash.utils.Dictionary;

class LOEBUILD_d5569d48c9e4a976a51c625e3a800107 extends Sprite {

      private static var transbackgroundEmbed_:Class = MEMap_transbackgroundEmbed_;

      private static var transbackgroundBD_:BitmapData = new transbackgroundEmbed_().bitmapData;

      public static const NUM_SQUARES:int = 1024;

      public static const SQUARE_SIZE:int = 16;

      public static const SIZE:int = 512;

      public static const MIN_ZOOM:Number = 0.0625;

      public static const MAX_ZOOM:Number = 32;

      public var tileDict_:Dictionary;

      public var fullMap_:LOEBUILD_a2dd0671a78e66a845504f34b1e40ff4;

      public var regionMap_:BitmapData;

      public var map_:BitmapData;

      public var overlay_:Shape;

      public var posT_:IntPoint;

      public var zoom_:Number = 1;

      private var mouseRectAnchorT_:IntPoint = null;

      private var mouseMoveAnchorT_:IntPoint = null;

      private var rectWidthOverride:int = 0;

      private var rectHeightOverride:int = 0;

      private var invisibleTexture_:BitmapData;

      private var replaceTexture_:BitmapData;

      public var anchorLock:Boolean = false;

      function LOEBUILD_d5569d48c9e4a976a51c625e3a800107() {
         this.tileDict_ = new Dictionary();
         this.fullMap_ = new LOEBUILD_a2dd0671a78e66a845504f34b1e40ff4(NUM_SQUARES * SQUARE_SIZE,NUM_SQUARES * SQUARE_SIZE,true,0);
         this.regionMap_ = new BitmapDataSpy(NUM_SQUARES,NUM_SQUARES,true,0);
         this.map_ = new BitmapDataSpy(SIZE,SIZE,true,0);
         this.overlay_ = new Shape();
         super();
         graphics.beginBitmapFill(transbackgroundBD_,null,true);
         graphics.drawRect(0,0,SIZE,SIZE);
         addChild(new Bitmap(this.map_));
         addChild(this.overlay_);
         this.posT_ = new IntPoint(NUM_SQUARES / 2 - this.sizeInTiles() / 2,NUM_SQUARES / 2 - this.sizeInTiles() / 2);
         this.invisibleTexture_ = AssetLibrary.getImageFromSet("invisible",0);
         this.replaceTexture_ = AssetLibrary.getImageFromSet("lofiObj3",255);
         this.draw();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }

      public function getType(param1:int, param2:int, param3:int) : int {
         var _local4:LOEBUILD_822148805b3866cb113421c05e57390d = this.getTile(param1,param2);
         if(_local4 == null) {
            return -1;
         }
         return _local4.types_[param3];
      }

      public function getTile(param1:int, param2:int) : LOEBUILD_822148805b3866cb113421c05e57390d {
         return this.tileDict_[param1 + param2 * NUM_SQUARES];
      }

      public function modifyTile(param1:int, param2:int, param3:int, param4:int) : void {
         var _local5:LOEBUILD_822148805b3866cb113421c05e57390d = this.getOrCreateTile(param1,param2);
         if(_local5.types_[param3] == param4) {
            return;
         }
         _local5.types_[param3] = param4;
         this.drawTile(param1,param2,_local5);
      }

      public function getObjectName(param1:int, param2:int) : String {
         var _local3:LOEBUILD_822148805b3866cb113421c05e57390d = this.getTile(param1,param2);
         if(_local3 == null) {
            return null;
         }
         return _local3.objName_;
      }

      public function modifyObjectName(param1:int, param2:int, param3:String) : void {
         var _local4:LOEBUILD_822148805b3866cb113421c05e57390d = this.getOrCreateTile(param1,param2);
         _local4.objName_ = param3;
      }

      public function getAllTiles() : Vector.<IntPoint> {
         var _local2:* = null;
         var _local3:int = 0;
         var _local1:Vector.<IntPoint> = new Vector.<IntPoint>();
         for(_local2 in this.tileDict_) {
            _local3 = int(_local2);
            _local1.push(new IntPoint(_local3 % NUM_SQUARES,_local3 / NUM_SQUARES));
         }
         return _local1;
      }

      public function setTile(param1:int, param2:int, param3:LOEBUILD_822148805b3866cb113421c05e57390d) : void {
         param3 = param3.clone();
         this.tileDict_[param1 + param2 * NUM_SQUARES] = param3;
         this.drawTile(param1,param2,param3);
      }

      public function eraseTile(param1:int, param2:int) : void {
         this.clearTile(param1,param2);
         this.drawTile(param1,param2,null);
      }

      public function clear() : void {
         var _local1:* = null;
         var _local2:int = 0;
         for(_local1 in this.tileDict_) {
            _local2 = int(_local1);
            this.eraseTile(_local2 % NUM_SQUARES,_local2 / NUM_SQUARES);
         }
      }

      public function getTileBounds() : Rectangle {
         var _local5:* = null;
         var _local6:LOEBUILD_822148805b3866cb113421c05e57390d = null;
         var _local7:int = 0;
         var _local8:int = 0;
         var _local9:int = 0;
         var _local1:int = NUM_SQUARES;
         var _local2:int = NUM_SQUARES;
         var _local3:int = 0;
         var _local4:int = 0;
         for(_local5 in this.tileDict_) {
            _local6 = this.tileDict_[_local5];
            if(!_local6.isEmpty()) {
               _local7 = int(_local5);
               _local8 = _local7 % NUM_SQUARES;
               _local9 = _local7 / NUM_SQUARES;
               if(_local8 < _local1) {
                  _local1 = _local8;
               }
               if(_local9 < _local2) {
                  _local2 = _local9;
               }
               if(_local8 + 1 > _local3) {
                  _local3 = _local8 + 1;
               }
               if(_local9 + 1 > _local4) {
                  _local4 = _local9 + 1;
               }
            }
         }
         if(_local1 > _local3) {
            return null;
         }
         return new Rectangle(_local1,_local2,_local3 - _local1,_local4 - _local2);
      }

      private function sizeInTiles() : int {
         return SIZE / (SQUARE_SIZE * this.zoom_);
      }

      private function modifyZoom(param1:Number) : void {
         if(param1 > 1 && this.zoom_ >= MAX_ZOOM || param1 < 1 && this.zoom_ <= MIN_ZOOM) {
            return;
         }
         var _local2:IntPoint = this.mousePosT();
         this.zoom_ = this.zoom_ * param1;
         var _local3:IntPoint = this.mousePosT();
         this.movePosT(_local2.x_ - _local3.x_,_local2.y_ - _local3.y_);
      }

      private function canMove() : Boolean {
         return this.mouseRectAnchorT_ == null && this.mouseMoveAnchorT_ == null;
      }

      private function increaseZoom() : void {
         if(!this.canMove()) {
            return;
         }
         this.modifyZoom(2);
         this.draw();
      }

      private function decreaseZoom() : void {
         if(!this.canMove()) {
            return;
         }
         this.modifyZoom(0.5);
         this.draw();
      }

      private function moveLeft() : void {
         if(!this.canMove()) {
            return;
         }
         this.movePosT(-1,0);
         this.draw();
      }

      private function moveRight() : void {
         if(!this.canMove()) {
            return;
         }
         this.movePosT(1,0);
         this.draw();
      }

      private function moveUp() : void {
         if(!this.canMove()) {
            return;
         }
         this.movePosT(0,-1);
         this.draw();
      }

      private function moveDown() : void {
         if(!this.canMove()) {
            return;
         }
         this.movePosT(0,1);
         this.draw();
      }

      private function movePosT(param1:int, param2:int) : void {
         var _local3:int = 0;
         var _local4:int = NUM_SQUARES - this.sizeInTiles();
         this.posT_.x_ = Math.max(_local3,Math.min(_local4,this.posT_.x_ + param1));
         this.posT_.y_ = Math.max(_local3,Math.min(_local4,this.posT_.y_ + param2));
      }

      private function mousePosT() : IntPoint {
         var _local1:int = Math.max(0,Math.min(SIZE - 1,mouseX));
         var _local2:int = Math.max(0,Math.min(SIZE - 1,mouseY));
         return new IntPoint(this.posT_.x_ + _local1 / (SQUARE_SIZE * this.zoom_),this.posT_.y_ + _local2 / (SQUARE_SIZE * this.zoom_));
      }

      public function mouseRectT() : Rectangle {
         var _local1:IntPoint = this.mousePosT();
         if(this.mouseRectAnchorT_ == null) {
            return new Rectangle(_local1.x_,_local1.y_,1,1);
         }
         return new Rectangle(Math.min(_local1.x_,this.mouseRectAnchorT_.x_),Math.min(_local1.y_,this.mouseRectAnchorT_.y_),Math.abs(_local1.x_ - this.mouseRectAnchorT_.x_) + 1,Math.abs(_local1.y_ - this.mouseRectAnchorT_.y_) + 1);
      }

      private function posTToPosP(param1:IntPoint) : IntPoint {
         return new IntPoint((param1.x_ - this.posT_.x_) * SQUARE_SIZE * this.zoom_,(param1.y_ - this.posT_.y_) * SQUARE_SIZE * this.zoom_);
      }

      private function sizeTToSizeP(param1:int) : Number {
         return param1 * this.zoom_ * SQUARE_SIZE;
      }

      private function mouseRectP() : Rectangle {
         var _local1:Rectangle = this.mouseRectT();
         var _local2:IntPoint = this.posTToPosP(new IntPoint(_local1.x,_local1.y));
         _local1.x = _local2.x_;
         _local1.y = _local2.y_;
         _local1.width = this.sizeTToSizeP(_local1.width) - 1;
         _local1.height = this.sizeTToSizeP(_local1.height) - 1;
         return _local1;
      }

      private function onAddedToStage(param1:Event) : void {
         addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
      }

      private function onRemovedFromStage(param1:Event) : void {
         removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
      }

      private function onKeyDown(param1:KeyboardEvent) : void {
         switch(param1.keyCode) {
            case Keyboard.SHIFT:
               if(this.mouseRectAnchorT_ != null) {
                  break;
               }
               this.mouseRectAnchorT_ = this.mousePosT();
               break;
            case Keyboard.CONTROL:
               if(this.mouseMoveAnchorT_ != null) {
                  break;
               }
               this.mouseMoveAnchorT_ = this.mousePosT();
               break;
            case Keyboard.LEFT:
               this.moveLeft();
               break;
            case Keyboard.RIGHT:
               this.moveRight();
               break;
            case Keyboard.UP:
               this.moveUp();
               break;
            case Keyboard.DOWN:
               this.moveDown();
               break;
            case KeyCodes.MINUS:
               this.decreaseZoom();
               break;
            case KeyCodes.EQUAL:
               this.increaseZoom();
         }
         this.draw();
      }

      private function onKeyUp(param1:KeyboardEvent) : void {
         switch(param1.keyCode) {
            case Keyboard.SHIFT:
               this.mouseRectAnchorT_ = null;
               break;
            case Keyboard.CONTROL:
               this.mouseMoveAnchorT_ = null;
         }
         this.draw();
      }

      private function onMouseWheel(param1:MouseEvent) : void {
         if(param1.delta > 0) {
            this.increaseZoom();
         } else if(param1.delta < 0) {
            this.decreaseZoom();
         }
      }

      private function onMouseDown(param1:MouseEvent) : void {
         var _local7:int = 0;
         var _local2:Rectangle = this.mouseRectT();
         var _local3:Vector.<IntPoint> = new Vector.<IntPoint>();
         var _local4:int = Math.max(_local2.x + this.rectWidthOverride,_local2.right);
         var _local5:int = Math.max(_local2.y + this.rectHeightOverride,_local2.bottom);
         var _local6:int = _local2.x;
         while(_local6 < _local4) {
            _local7 = _local2.y;
            while(_local7 < _local5) {
               _local3.push(new IntPoint(_local6,_local7));
               _local7++;
            }
            _local6++;
         }
         dispatchEvent(new LOEBUILD_9193e2fe6dbacd2489b5fbd9c60957b1(_local3));
      }

      public function freezeSelect() : void {
         var _local1:Rectangle = this.mouseRectT();
         this.rectWidthOverride = _local1.width;
         this.rectHeightOverride = _local1.height;
      }

      public function clearSelect() : void {
         this.rectHeightOverride = 0;
         this.rectWidthOverride = 0;
      }

      private function onMouseMove(param1:MouseEvent) : void {
         var _local2:IntPoint = null;
         if(!param1.shiftKey) {
            this.mouseRectAnchorT_ = null;
         } else if(this.mouseRectAnchorT_ == null) {
            this.mouseRectAnchorT_ = this.mousePosT();
         }
         if(!param1.ctrlKey) {
            this.mouseMoveAnchorT_ = null;
         } else if(this.mouseMoveAnchorT_ == null) {
            this.mouseMoveAnchorT_ = this.mousePosT();
         }
         if(param1.buttonDown) {
            dispatchEvent(new LOEBUILD_9193e2fe6dbacd2489b5fbd9c60957b1(new <IntPoint>[this.mousePosT()]));
         }
         if(this.mouseMoveAnchorT_ != null) {
            _local2 = this.mousePosT();
            this.movePosT(this.mouseMoveAnchorT_.x_ - _local2.x_,this.mouseMoveAnchorT_.y_ - _local2.y_);
            this.draw();
         } else {
            this.drawOverlay();
         }
      }

      private function getOrCreateTile(param1:int, param2:int) : LOEBUILD_822148805b3866cb113421c05e57390d {
         var _local3:int = param1 + param2 * NUM_SQUARES;
         var _local4:LOEBUILD_822148805b3866cb113421c05e57390d = this.tileDict_[_local3];
         if(_local4 != null) {
            return _local4;
         }
         _local4 = new LOEBUILD_822148805b3866cb113421c05e57390d();
         this.tileDict_[_local3] = _local4;
         return _local4;
      }

      private function clearTile(param1:int, param2:int) : void {
         delete this.tileDict_[param1 + param2 * NUM_SQUARES];
      }

      private function drawTile(param1:int, param2:int, param3:LOEBUILD_822148805b3866cb113421c05e57390d) : void {
         var _local5:BitmapData = null;
         var _local6:BitmapData = null;
         var _local7:uint = 0;
         var _local4:Rectangle = new Rectangle(param1 * SQUARE_SIZE,param2 * SQUARE_SIZE,SQUARE_SIZE,SQUARE_SIZE);
         this.fullMap_.erase(_local4);
         this.regionMap_.setPixel32(param1,param2,0);
         if(param3 == null) {
            return;
         }
         if(param3.types_[LOEBUILD_359b71e88f40029251366609358a302f.GROUND] != -1) {
            _local5 = LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5.getBitmapData(param3.types_[LOEBUILD_359b71e88f40029251366609358a302f.GROUND]);
            this.fullMap_.copyTo(_local5,_local5.rect,_local4);
         }
         if(param3.types_[LOEBUILD_359b71e88f40029251366609358a302f.OBJECT] != -1) {
            _local6 = LOEBUILD_efda783509bc93eea698457c87bbee3f.getTextureFromType(param3.types_[LOEBUILD_359b71e88f40029251366609358a302f.OBJECT]);
            if(_local6 == null || _local6 == this.invisibleTexture_) {
               this.fullMap_.copyTo(this.replaceTexture_,this.replaceTexture_.rect,_local4);
            } else {
               this.fullMap_.copyTo(_local6,_local6.rect,_local4);
            }
         }
         if(param3.types_[LOEBUILD_359b71e88f40029251366609358a302f.REGION] != -1) {
            _local7 = LOEBUILD_bc44e55f2b7833506dc8a2b0246803f4.getColor(param3.types_[LOEBUILD_359b71e88f40029251366609358a302f.REGION]);
            this.regionMap_.setPixel32(param1,param2,1593835520 | _local7);
         }
      }

      private function drawOverlay() : void {
         var _local1:Rectangle = this.mouseRectP();
         var _local2:Graphics = this.overlay_.graphics;
         _local2.clear();
         _local2.lineStyle(1,16777215);
         _local2.beginFill(16777215,0.1);
         _local2.drawRect(_local1.x,_local1.y,_local1.width,_local1.height);
         _local2.endFill();
         _local2.lineStyle();
      }

      public function draw() : void {
         var _local2:Matrix = null;
         var _local3:int = 0;
         var _local4:BitmapData = null;
         var _local1:int = SIZE / this.zoom_;
         this.map_.fillRect(this.map_.rect,0);
         this.fullMap_.copyFrom(new Rectangle(this.posT_.x_ * SQUARE_SIZE,this.posT_.y_ * SQUARE_SIZE,_local1,_local1),this.map_,this.map_.rect);
         _local2 = new Matrix();
         _local2.identity();
         _local3 = SQUARE_SIZE * this.zoom_;
         if(this.zoom_ > 2) {
            _local4 = new BitmapDataSpy(SIZE / _local3,SIZE / _local3);
            _local4.copyPixels(this.regionMap_,new Rectangle(this.posT_.x_,this.posT_.y_,_local1,_local1),PointUtil.ORIGIN);
            _local2.scale(_local3,_local3);
            this.map_.draw(_local4,_local2);
         } else {
            _local2.translate(-this.posT_.x_,-this.posT_.y_);
            _local2.scale(_local3,_local3);
            this.map_.draw(this.regionMap_,_local2,null,null,this.map_.rect);
         }
         this.drawOverlay();
      }
   }
}
