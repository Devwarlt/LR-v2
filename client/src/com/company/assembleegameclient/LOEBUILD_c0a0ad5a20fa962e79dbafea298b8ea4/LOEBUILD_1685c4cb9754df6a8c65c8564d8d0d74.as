package com.company.assembleegameclient.LOEBUILD_c0a0ad5a20fa962e79dbafea298b8ea4 {
import com.company.assembleegameclient.map.Camera;
import com.company.util.Trig;

import flash.display.BitmapData;
import flash.display.GraphicsBitmapFill;
import flash.display.GraphicsEndFill;
import flash.display.GraphicsPath;
import flash.display.GraphicsPathCommand;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.geom.Matrix;
import flash.geom.Matrix3D;
import flash.geom.Utils3D;
import flash.geom.Vector3D;

public class LOEBUILD_1685c4cb9754df6a8c65c8564d8d0d74 {

      private static const commands_:Vector.<int> = new <int>[GraphicsPathCommand.MOVE_TO,GraphicsPathCommand.LINE_TO,GraphicsPathCommand.LINE_TO,GraphicsPathCommand.LINE_TO];

      private static const END_FILL:GraphicsEndFill = new GraphicsEndFill();

      public var size_:Number;

      public var posS_:Vector3D;

      private const data_:Vector.<Number> = new Vector.<Number>();

      private const path_:GraphicsPath = new GraphicsPath(commands_,data_);

      private const bitmapFill_:GraphicsBitmapFill = new GraphicsBitmapFill(null,new Matrix(),false,false);

      private const solidFill_:GraphicsSolidFill = new GraphicsSolidFill(0,1);

      public function LOEBUILD_1685c4cb9754df6a8c65c8564d8d0d74(param1:Number) {
         super();
         this.size_ = param1;
      }

      public function setSize(param1:Number) : void {
         this.size_ = param1;
      }

      public function draw(param1:Vector.<IGraphicsData>, param2:Vector3D, param3:Number, param4:Matrix3D, param5:Camera, param6:BitmapData, param7:uint = 0) : void {
         var _local10:Number = NaN;
         var _local11:Number = NaN;
         var _local12:Matrix = null;
         this.posS_ = Utils3D.projectVector(param4,param2);
         if(this.posS_.w < 0) {
            return;
         }
         var _local8:Number = this.posS_.w * Math.sin(param5.pp_.fieldOfView / 2 * Trig.toRadians);
         var _local9:Number = this.size_ / _local8;
         this.data_.length = 0;
         if(param3 == 0) {
            this.data_.push(this.posS_.x - _local9,this.posS_.y - _local9,this.posS_.x + _local9,this.posS_.y - _local9,this.posS_.x + _local9,this.posS_.y + _local9,this.posS_.x - _local9,this.posS_.y + _local9);
         } else {
            _local10 = Math.cos(param3);
            _local11 = Math.sin(param3);
            this.data_.push(this.posS_.x + (_local10 * -_local9 + _local11 * -_local9),this.posS_.y + (_local11 * -_local9 - _local10 * -_local9),this.posS_.x + (_local10 * _local9 + _local11 * -_local9),this.posS_.y + (_local11 * _local9 - _local10 * -_local9),this.posS_.x + (_local10 * _local9 + _local11 * _local9),this.posS_.y + (_local11 * _local9 - _local10 * _local9),this.posS_.x + (_local10 * -_local9 + _local11 * _local9),this.posS_.y + (_local11 * -_local9 - _local10 * _local9));
         }
         if(param6 != null) {
            this.bitmapFill_.bitmapData = param6;
            _local12 = this.bitmapFill_.matrix;
            _local12.identity();
            _local12.scale(2 * _local9 / param6.width,2 * _local9 / param6.height);
            _local12.translate(-_local9,-_local9);
            _local12.rotate(param3);
            _local12.translate(this.posS_.x,this.posS_.y);
            param1.push(this.bitmapFill_);
         } else {
            this.solidFill_.color = param7;
            param1.push(this.solidFill_);
         }
         param1.push(this.path_);
         param1.push(END_FILL);
      }
   }
}
