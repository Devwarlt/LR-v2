package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Square;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.BasicObject;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_6f1c25ed1523962f1bbf9dee9be5092b.Animations;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.GraphicsUtil;

import flash.display.BitmapData;
import flash.display.GraphicsBitmapFill;
import flash.display.GraphicsPath;
import flash.display.IGraphicsData;
import flash.geom.Matrix;
import flash.geom.Vector3D;

public class XMLParticle extends BasicObject {

      public var texture_:BitmapData = null;

      public var animations_:Animations = null;

      public var size_:int;

      public var durationLeft_:Number;

      public var moveVec_:Vector3D;

      protected var bitmapFill_:GraphicsBitmapFill;

      protected var path_:GraphicsPath;

      protected var vS_:Vector.<Number>;

      protected var uvt_:Vector.<Number>;

      protected var fillMatrix_:Matrix;

      public function XMLParticle(param1:ParticleProperties) {
         this.bitmapFill_ = new GraphicsBitmapFill(null,null,false,false);
         this.path_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS,null);
         this.vS_ = new Vector.<Number>();
         this.uvt_ = new Vector.<Number>();
         this.fillMatrix_ = new Matrix();
         super();
         objectId_ = getNextFakeObjectId();
         this.size_ = param1.size_;
         z_ = param1.z_;
         this.durationLeft_ = param1.duration_;
         this.texture_ = param1.textureData_.getTexture(objectId_);
         if(param1.animationsData_ != null) {
            this.animations_ = new Animations(param1.animationsData_);
         }
         this.moveVec_ = new Vector3D();
         var _local2:Number = Math.PI * 2 * Math.random();
         this.moveVec_.x = Math.cos(_local2) * 0.1 * 5;
         this.moveVec_.y = Math.sin(_local2) * 0.1 * 5;
      }

      public function moveTo(param1:Number, param2:Number) : Boolean {
         var _local3:Square = map_.getSquare(param1,param2);
         if(_local3 == null) {
            return false;
         }
         x_ = param1;
         y_ = param2;
         square_ = _local3;
         return true;
      }

      override public function update(param1:int, param2:int) : Boolean {
         var _local3:Number = param2 / 1000;
         this.durationLeft_ = this.durationLeft_ - _local3;
         if(this.durationLeft_ <= 0) {
            return false;
         }
         x_ = x_ + this.moveVec_.x * _local3;
         y_ = y_ + this.moveVec_.y * _local3;
         return true;
      }

      override public function draw(param1:Vector.<IGraphicsData>, param2:Camera, param3:int) : void {
         var _local7:BitmapData = null;
         var _local4:BitmapData = this.texture_;
         if(this.animations_ != null) {
            _local7 = this.animations_.getTexture(param3);
            if(_local7 != null) {
               _local4 = _local7;
            }
         }
         _local4 = TextureRedrawer.redraw(_local4,this.size_,true,0);
         var _local5:int = _local4.width;
         var _local6:int = _local4.height;
         this.vS_.length = 0;
         this.vS_.push(posS_[3] - _local5 / 2,posS_[4] - _local6,posS_[3] + _local5 / 2,posS_[4] - _local6,posS_[3] + _local5 / 2,posS_[4],posS_[3] - _local5 / 2,posS_[4]);
         this.path_.data = this.vS_;
         this.bitmapFill_.bitmapData = _local4;
         this.fillMatrix_.identity();
         this.fillMatrix_.translate(this.vS_[0],this.vS_[1]);
         this.bitmapFill_.matrix = this.fillMatrix_;
         param1.push(this.bitmapFill_);
         param1.push(this.path_);
         param1.push(GraphicsUtil.END_FILL);
      }
   }
}
