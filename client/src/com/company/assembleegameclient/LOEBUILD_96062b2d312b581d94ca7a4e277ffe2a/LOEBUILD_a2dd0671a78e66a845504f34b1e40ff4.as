package com.company.assembleegameclient.LOEBUILD_96062b2d312b581d94ca7a4e277ffe2a {
import com.company.assembleegameclient.util.BitmapDataSpy;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.geom.Rectangle;

public class LOEBUILD_a2dd0671a78e66a845504f34b1e40ff4 {

      private static const CHUNK_SIZE:int = 256;

      public var width_:int;

      public var height_:int;

      public var fillColor_:uint;

      private var maxChunkX_:int;

      private var maxChunkY_:int;

      private var chunks_:Vector.<BitmapData>;

      public function LOEBUILD_a2dd0671a78e66a845504f34b1e40ff4(param1:int, param2:int, param3:Boolean, param4:uint) {
         var _local6:int = 0;
         var _local7:int = 0;
         var _local8:int = 0;
         super();
         this.width_ = param1;
         this.height_ = param2;
         this.fillColor_ = param4;
         this.maxChunkX_ = Math.ceil(this.width_ / CHUNK_SIZE);
         this.maxChunkY_ = Math.ceil(this.height_ / CHUNK_SIZE);
         this.chunks_ = new Vector.<BitmapData>(this.maxChunkX_ * this.maxChunkY_,true);
         var _local5:int = 0;
         while(_local5 < this.maxChunkX_) {
            _local6 = 0;
            while(_local6 < this.maxChunkY_) {
               _local7 = Math.min(CHUNK_SIZE,this.width_ - _local5 * CHUNK_SIZE);
               _local8 = Math.min(CHUNK_SIZE,this.height_ - _local6 * CHUNK_SIZE);
               this.chunks_[_local5 + _local6 * this.maxChunkX_] = new BitmapDataSpy(_local7,_local8,param3,this.fillColor_);
               _local6++;
            }
            _local5++;
         }
      }

      public function copyTo(param1:BitmapData, param2:Rectangle, param3:Rectangle) : void {
         var _local12:int = 0;
         var _local13:BitmapData = null;
         var _local14:Rectangle = null;
         var _local4:Number = param3.width / param2.width;
         var _local5:Number = param3.height / param2.height;
         var _local6:int = int(param3.x / CHUNK_SIZE);
         var _local7:int = int(param3.y / CHUNK_SIZE);
         var _local8:int = Math.ceil(param3.right / CHUNK_SIZE);
         var _local9:int = Math.ceil(param3.bottom / CHUNK_SIZE);
         var _local10:Matrix = new Matrix();
         var _local11:int = _local6;
         while(_local11 < _local8) {
            _local12 = _local7;
            while(_local12 < _local9) {
               _local13 = this.chunks_[_local11 + _local12 * this.maxChunkX_];
               _local10.identity();
               _local10.scale(_local4,_local5);
               _local10.translate(param3.x - _local11 * CHUNK_SIZE - param2.x * _local4,param3.y - _local12 * CHUNK_SIZE - param2.x * _local5);
               _local14 = new Rectangle(param3.x - _local11 * CHUNK_SIZE,param3.y - _local12 * CHUNK_SIZE,param3.width,param3.height);
               _local13.draw(param1,_local10,null,null,_local14,false);
               _local12++;
            }
            _local11++;
         }
      }

      public function copyFrom(param1:Rectangle, param2:BitmapData, param3:Rectangle) : void {
         var _local13:int = 0;
         var _local14:BitmapData = null;
         var _local4:Number = param3.width / param1.width;
         var _local5:Number = param3.height / param1.height;
         var _local6:int = Math.max(0,int(param1.x / CHUNK_SIZE));
         var _local7:int = Math.max(0,int(param1.y / CHUNK_SIZE));
         var _local8:int = Math.min(this.maxChunkX_ - 1,int(param1.right / CHUNK_SIZE));
         var _local9:int = Math.min(this.maxChunkY_ - 1,int(param1.bottom / CHUNK_SIZE));
         var _local10:Rectangle = new Rectangle();
         var _local11:Matrix = new Matrix();
         var _local12:int = _local6;
         while(_local12 <= _local8) {
            _local13 = _local7;
            while(_local13 <= _local9) {
               _local14 = this.chunks_[_local12 + _local13 * this.maxChunkX_];
               _local11.identity();
               _local11.translate(param3.x / _local4 - param1.x + _local12 * CHUNK_SIZE,param3.y / _local5 - param1.y + _local13 * CHUNK_SIZE);
               _local11.scale(_local4,_local5);
               param2.draw(_local14,_local11,null,null,param3,false);
               _local13++;
            }
            _local12++;
         }
      }

      public function erase(param1:Rectangle) : void {
         var _local8:int = 0;
         var _local9:BitmapData = null;
         var _local2:int = int(param1.x / CHUNK_SIZE);
         var _local3:int = int(param1.y / CHUNK_SIZE);
         var _local4:int = Math.ceil(param1.right / CHUNK_SIZE);
         var _local5:int = Math.ceil(param1.bottom / CHUNK_SIZE);
         var _local6:Rectangle = new Rectangle();
         var _local7:int = _local2;
         while(_local7 < _local4) {
            _local8 = _local3;
            while(_local8 < _local5) {
               _local9 = this.chunks_[_local7 + _local8 * this.maxChunkX_];
               _local6.x = param1.x - _local7 * CHUNK_SIZE;
               _local6.y = param1.y - _local8 * CHUNK_SIZE;
               _local6.right = param1.right - _local7 * CHUNK_SIZE;
               _local6.bottom = param1.bottom - _local8 * CHUNK_SIZE;
               _local9.fillRect(_local6,this.fillColor_);
               _local8++;
            }
            _local7++;
         }
      }

      public function getDebugSprite() : Sprite {
         var _local3:int = 0;
         var _local4:BitmapData = null;
         var _local5:Bitmap = null;
         var _local1:Sprite = new Sprite();
         var _local2:int = 0;
         while(_local2 < this.maxChunkX_) {
            _local3 = 0;
            while(_local3 < this.maxChunkY_) {
               _local4 = this.chunks_[_local2 + _local3 * this.maxChunkX_];
               _local5 = new Bitmap(_local4);
               _local5.x = _local2 * CHUNK_SIZE;
               _local5.y = _local3 * CHUNK_SIZE;
               _local1.addChild(_local5);
               _local3++;
            }
            _local2++;
         }
         return _local1;
      }
   }
}
