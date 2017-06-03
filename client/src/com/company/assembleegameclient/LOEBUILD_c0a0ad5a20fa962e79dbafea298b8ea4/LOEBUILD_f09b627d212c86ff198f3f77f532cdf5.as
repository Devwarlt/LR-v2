package com.company.assembleegameclient.LOEBUILD_c0a0ad5a20fa962e79dbafea298b8ea4 {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.GraphicsUtil;
import com.company.util.Triangle;

import flash.display.BitmapData;
import flash.display.GraphicsBitmapFill;
import flash.display.GraphicsPath;
import flash.display.GraphicsPathCommand;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.geom.Utils3D;
import flash.geom.Vector3D;

public class LOEBUILD_f09b627d212c86ff198f3f77f532cdf5 {

      private static const blackOutFill_:GraphicsSolidFill = new GraphicsSolidFill(0,1);

      public var origTexture_:BitmapData;

      public var vin_:Vector.<Number>;

      public var uvt_:Vector.<Number>;

      public var vout_:Vector.<Number>;

      public var backfaceCull_:Boolean;

      public var shade_:Number = 1.0;

      public var blackOut_:Boolean = false;

      private var needGen_:Boolean = true;

      private var textureMatrix_:LOEBUILD_564a5d93991a252df798213e5b179eb8 = null;

      public var bitmapFill_:GraphicsBitmapFill;

      private var path_:GraphicsPath;

      public function LOEBUILD_f09b627d212c86ff198f3f77f532cdf5(param1:BitmapData, param2:Vector.<Number>, param3:Vector.<Number>, param4:Boolean = false, param5:Boolean = false) {
         var _local7:Vector3D = null;
         this.vout_ = new Vector.<Number>();
         this.bitmapFill_ = new GraphicsBitmapFill(null,null,false,false);
         this.path_ = new GraphicsPath(new Vector.<int>(),null);
         super();
         this.origTexture_ = param1;
         this.vin_ = param2;
         this.uvt_ = param3;
         this.backfaceCull_ = param4;
         if(param5) {
            _local7 = new Vector3D();
            LOEBUILD_cad663cd4c34f1ddf52d04241c00872b.computeNormalVec(param2,_local7);
            this.shade_ = LOEBUILD_5fe0c2152923c7a7c0d090673e2d5532.shadeValue(_local7,0.75);
         }
         this.path_.commands.push(GraphicsPathCommand.MOVE_TO);
         var _local6:int = 3;
         while(_local6 < this.vin_.length) {
            this.path_.commands.push(GraphicsPathCommand.LINE_TO);
            _local6 = _local6 + 3;
         }
         this.path_.data = this.vout_;
      }

      public function dispose() : void {
         this.origTexture_ = null;
         this.vin_ = null;
         this.uvt_ = null;
         this.vout_ = null;
         this.textureMatrix_ = null;
         this.bitmapFill_ = null;
         this.path_.commands = null;
         this.path_.data = null;
         this.path_ = null;
      }

      public function setTexture(param1:BitmapData) : void {
         if(this.origTexture_ == param1) {
            return;
         }
         this.origTexture_ = param1;
         this.needGen_ = true;
      }

      public function setUVT(param1:Vector.<Number>) : void {
         this.uvt_ = param1;
         this.needGen_ = true;
      }

      public function maxY() : Number {
         var _local1:Number = -Number.MAX_VALUE;
         var _local2:int = this.vout_.length;
         var _local3:int = 0;
         while(_local3 < _local2) {
            if(this.vout_[_local3 + 1] > _local1) {
               _local1 = this.vout_[_local3 + 1];
            }
            _local3 = _local3 + 2;
         }
         return _local1;
      }

      public function draw(param1:Vector.<IGraphicsData>, param2:Camera) : Boolean {
         var _local10:Vector.<Number> = null;
         var _local11:Number = NaN;
         var _local12:Number = NaN;
         var _local13:Number = NaN;
         var _local14:Number = NaN;
         var _local15:int = 0;
         Utils3D.projectVectors(param2.wToS_,this.vin_,this.vout_,this.uvt_);
         if(this.backfaceCull_) {
            _local10 = this.vout_;
            _local11 = _local10[2] - _local10[0];
            _local12 = _local10[3] - _local10[1];
            _local13 = _local10[4] - _local10[0];
            _local14 = _local10[5] - _local10[1];
            if(_local11 * _local14 - _local12 * _local13 > 0) {
               return false;
            }
         }
         var _local3:Number = param2.clipRect_.x - 10;
         var _local4:Number = param2.clipRect_.y - 10;
         var _local5:Number = param2.clipRect_.right + 10;
         var _local6:Number = param2.clipRect_.bottom + 10;
         var _local7:Boolean = true;
         var _local8:int = this.vout_.length;
         var _local9:int = 0;
         while(_local9 < _local8) {
            _local15 = _local9 + 1;
            if(this.vout_[_local9] >= _local3 && this.vout_[_local9] <= _local5 && this.vout_[_local15] >= _local4 && this.vout_[_local15] <= _local6) {
               _local7 = false;
               break;
            }
            _local9 = _local9 + 2;
         }
         if(_local7) {
            return false;
         }
         if(this.blackOut_) {
            param1.push(blackOutFill_);
            param1.push(this.path_);
            param1.push(GraphicsUtil.END_FILL);
            return true;
         }
         if(this.needGen_) {
            this.generateTextureMatrix();
         }
         this.textureMatrix_.calculateTextureMatrix(this.vout_);
         this.bitmapFill_.bitmapData = this.textureMatrix_.texture_;
         this.bitmapFill_.matrix = this.textureMatrix_.tToS_;
         param1.push(this.bitmapFill_);
         param1.push(this.path_);
         param1.push(GraphicsUtil.END_FILL);
         return true;
      }

      public function contains(param1:Number, param2:Number) : Boolean {
         if(Triangle.containsXY(this.vout_[0],this.vout_[1],this.vout_[2],this.vout_[3],this.vout_[4],this.vout_[5],param1,param2)) {
            return true;
         }
         if(this.vout_.length == 8 && Boolean(Triangle.containsXY(this.vout_[0],this.vout_[1],this.vout_[4],this.vout_[5],this.vout_[6],this.vout_[7],param1,param2))) {
            return true;
         }
         return false;
      }

      private function generateTextureMatrix() : void {
         var _local1:BitmapData = TextureRedrawer.redrawFace(this.origTexture_,this.shade_);
         if(this.textureMatrix_ == null) {
            this.textureMatrix_ = new LOEBUILD_564a5d93991a252df798213e5b179eb8(_local1,this.uvt_);
         } else {
            this.textureMatrix_.texture_ = _local1;
            this.textureMatrix_.calculateUVMatrix(this.uvt_);
         }
         this.needGen_ = false;
      }
   }
}
