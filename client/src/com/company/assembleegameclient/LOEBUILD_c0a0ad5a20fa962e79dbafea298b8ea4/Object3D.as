package com.company.assembleegameclient.LOEBUILD_c0a0ad5a20fa962e79dbafea298b8ea4 {
import com.company.assembleegameclient.map.Camera;

import flash.display.BitmapData;
import flash.display.IGraphicsData;
import flash.geom.Matrix3D;
import flash.geom.Utils3D;
import flash.geom.Vector3D;

public class Object3D {

      public var model_:LOEBUILD_1cd204050ec7f52020766f99b3129701 = null;

      public var vL_:Vector.<Number>;

      public var uvts_:Vector.<Number>;

      public var faces_:Vector.<LOEBUILD_1466625a8b6887d3e91cda3e12e5a036>;

      public var vS_:Vector.<Number>;

      public var vW_:Vector.<Number>;

      public var lToW_:Matrix3D;

      public function Object3D(param1:LOEBUILD_1cd204050ec7f52020766f99b3129701 = null) {
         var _local2:LOEBUILD_4b3191ab11a28e125ff9a9624cfd674b = null;
         this.faces_ = new Vector.<LOEBUILD_1466625a8b6887d3e91cda3e12e5a036>();
         this.vS_ = new Vector.<Number>();
         this.vW_ = new Vector.<Number>();
         this.lToW_ = new Matrix3D();
         super();
         if(param1 != null) {
            this.model_ = param1;
            this.vL_ = this.model_.vL_;
            this.uvts_ = this.model_.uvts_.concat();
            for each(_local2 in this.model_.faces_) {
               this.faces_.push(new LOEBUILD_1466625a8b6887d3e91cda3e12e5a036(this,_local2.indicies_,_local2.useTexture_));
            }
         } else {
            this.vL_ = new Vector.<Number>();
            this.uvts_ = new Vector.<Number>();
         }
         this.setPosition(0,0,0,0);
      }

      public static function getObject(param1:String) : Object3D {
         var _local2:LOEBUILD_1cd204050ec7f52020766f99b3129701 = LOEBUILD_1cd204050ec7f52020766f99b3129701.getModel(param1);
         return new Object3D(_local2);
      }

      public function dispose() : void {
         var _local1:LOEBUILD_1466625a8b6887d3e91cda3e12e5a036 = null;
         this.vL_ = null;
         this.uvts_ = null;
         for each(_local1 in this.faces_) {
            _local1.dispose();
         }
         this.faces_.length = 0;
         this.faces_ = null;
         this.vS_ = null;
         this.vW_ = null;
         this.lToW_ = null;
      }

      public function setPosition(param1:Number, param2:Number, param3:Number, param4:Number) : void {
         var _local5:LOEBUILD_1466625a8b6887d3e91cda3e12e5a036 = null;
         this.lToW_.identity();
         this.lToW_.appendRotation(param4,Vector3D.Z_AXIS);
         this.lToW_.appendTranslation(param1,param2,param3);
         this.lToW_.transformVectors(this.vL_,this.vW_);
         for each(_local5 in this.faces_) {
            _local5.computeLighting();
         }
      }

      public function getVecW(param1:int) : Vector3D {
         var _local2:int = param1 * 3;
         if(_local2 >= this.vW_.length) {
            return null;
         }
         return new Vector3D(this.vW_[_local2],this.vW_[_local2 + 1],this.vW_[_local2 + 2]);
      }

      public function draw(param1:Vector.<IGraphicsData>, param2:Camera, param3:uint, param4:BitmapData) : void {
         var _local5:LOEBUILD_1466625a8b6887d3e91cda3e12e5a036 = null;
         Utils3D.projectVectors(param2.wToS_,this.vW_,this.vS_,this.uvts_);
         for each(_local5 in this.faces_) {
            _local5.draw(param1,param3,param4);
         }
      }
   }
}
