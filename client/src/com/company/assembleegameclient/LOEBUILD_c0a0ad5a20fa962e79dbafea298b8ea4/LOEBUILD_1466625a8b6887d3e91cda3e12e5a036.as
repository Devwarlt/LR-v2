package com.company.assembleegameclient.LOEBUILD_c0a0ad5a20fa962e79dbafea298b8ea4 {
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.GraphicsUtil;
import com.company.util.MoreColorUtil;

import flash.display.BitmapData;
import flash.display.GraphicsBitmapFill;
import flash.display.GraphicsPath;
import flash.display.GraphicsPathCommand;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Vector3D;

import kabam.rotmg.stage3D.GraphicsFillExtra;

public class LOEBUILD_1466625a8b6887d3e91cda3e12e5a036 {

      public static const blackBitmap:BitmapData = new BitmapData(1,1,true,4278190080);

      public var obj_:Object3D;

      public var indices_:Vector.<int>;

      public var useTexture_:Boolean;

      public var softwareException_:Boolean = false;

      public var texture_:BitmapData = null;

      public var normalL_:Vector3D = null;

      public var normalW_:Vector3D;

      public var shade_:Number = 1.0;

      private var path_:GraphicsPath;

      private var solidFill_:GraphicsSolidFill;

      public const bitmapFill_:GraphicsBitmapFill = new GraphicsBitmapFill();

      private var tToS_:Matrix;

      private var tempMatrix_:Matrix;

      public function LOEBUILD_1466625a8b6887d3e91cda3e12e5a036(param1:Object3D, param2:Vector.<int>, param3:Boolean = true) {
         this.solidFill_ = new GraphicsSolidFill(16777215,1);
         this.tToS_ = new Matrix();
         this.tempMatrix_ = new Matrix();
         super();
         this.obj_ = param1;
         this.indices_ = param2;
         this.useTexture_ = param3;
         var _local4:Vector.<int> = new Vector.<int>();
         var _local5:int = 0;
         while(_local5 < this.indices_.length) {
            _local4.push(_local5 == 0?GraphicsPathCommand.MOVE_TO:GraphicsPathCommand.LINE_TO);
            _local5++;
         }
         var _local6:Vector.<Number> = new Vector.<Number>();
         _local6.length = this.indices_.length * 2;
         this.path_ = new GraphicsPath(_local4,_local6);
      }

      public function dispose() : void {
         this.indices_ = null;
         this.path_.commands = null;
         this.path_.data = null;
         this.path_ = null;
      }

      public function computeLighting() : void {
         this.normalW_ = new Vector3D();
         LOEBUILD_cad663cd4c34f1ddf52d04241c00872b.computeNormal(this.obj_.getVecW(this.indices_[0]),this.obj_.getVecW(this.indices_[1]),this.obj_.getVecW(this.indices_[this.indices_.length - 1]),this.normalW_);
         this.shade_ = LOEBUILD_5fe0c2152923c7a7c0d090673e2d5532.shadeValue(this.normalW_,0.75);
         if(this.normalL_ != null) {
            this.normalW_ = this.obj_.lToW_.deltaTransformVector(this.normalL_);
         }
      }

      public function draw(param1:Vector.<IGraphicsData>, param2:uint, param3:BitmapData) : void {
         var _local13:int = 0;
         var _local4:int = this.indices_[0] * 2;
         var _local5:int = this.indices_[1] * 2;
         var _local6:int = this.indices_[this.indices_.length - 1] * 2;
         var _local7:Vector.<Number> = this.obj_.vS_;
         var _local8:Number = _local7[_local5] - _local7[_local4];
         var _local9:Number = _local7[_local5 + 1] - _local7[_local4 + 1];
         var _local10:Number = _local7[_local6] - _local7[_local4];
         var _local11:Number = _local7[_local6 + 1] - _local7[_local4 + 1];
         if(_local8 * _local11 - _local9 * _local10 < 0) {
            return;
         }
         if(!LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.GPURender && (!this.useTexture_ || param3 == null)) {
            this.solidFill_.color = MoreColorUtil.transformColor(new ColorTransform(this.shade_,this.shade_,this.shade_),param2);
            param1.push(this.solidFill_);
         } else {
            if(param3 == null && Boolean(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.GPURender)) {
               param3 = blackBitmap;
            } else {
               param3 = TextureRedrawer.redrawFace(param3,this.shade_);
            }
            this.bitmapFill_.bitmapData = param3;
            this.bitmapFill_.matrix = this.tToS(param3);
            param1.push(this.bitmapFill_);
         }
         var _local12:int = 0;
         while(_local12 < this.indices_.length) {
            _local13 = this.indices_[_local12];
            this.path_.data[_local12 * 2] = _local7[_local13 * 2];
            this.path_.data[_local12 * 2 + 1] = _local7[_local13 * 2 + 1];
            _local12++;
         }
         param1.push(this.path_);
         param1.push(GraphicsUtil.END_FILL);
         if(Boolean(this.softwareException_) && Boolean(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.isGpuRender()) && this.bitmapFill_ != null) {
            GraphicsFillExtra.setSoftwareDraw(this.bitmapFill_,true);
         }
      }

      private function tToS(param1:BitmapData) : Matrix {
         var _local2:Vector.<Number> = this.obj_.uvts_;
         var _local3:int = this.indices_[0] * 3;
         var _local4:int = this.indices_[1] * 3;
         var _local5:int = this.indices_[this.indices_.length - 1] * 3;
         var _local6:Number = _local2[_local3] * param1.width;
         var _local7:Number = _local2[_local3 + 1] * param1.height;
         this.tToS_.a = _local2[_local4] * param1.width - _local6;
         this.tToS_.b = _local2[_local4 + 1] * param1.height - _local7;
         this.tToS_.c = _local2[_local5] * param1.width - _local6;
         this.tToS_.d = _local2[_local5 + 1] * param1.height - _local7;
         this.tToS_.tx = _local6;
         this.tToS_.ty = _local7;
         this.tToS_.invert();
         _local3 = this.indices_[0] * 2;
         _local4 = this.indices_[1] * 2;
         _local5 = this.indices_[this.indices_.length - 1] * 2;
         var _local8:Vector.<Number> = this.obj_.vS_;
         this.tempMatrix_.a = _local8[_local4] - _local8[_local3];
         this.tempMatrix_.b = _local8[_local4 + 1] - _local8[_local3 + 1];
         this.tempMatrix_.c = _local8[_local5] - _local8[_local3];
         this.tempMatrix_.d = _local8[_local5 + 1] - _local8[_local3 + 1];
         this.tempMatrix_.tx = _local8[_local3];
         this.tempMatrix_.ty = _local8[_local3 + 1];
         this.tToS_.concat(this.tempMatrix_);
         return this.tToS_;
      }
   }
}
