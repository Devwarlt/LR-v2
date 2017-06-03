package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da {
import com.company.assembleegameclient.LOEBUILD_c0a0ad5a20fa962e79dbafea298b8ea4.LOEBUILD_1466625a8b6887d3e91cda3e12e5a036;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.util.AssetLibrary;

import flash.display.BitmapData;
import flash.geom.Vector3D;

import kabam.rotmg.stage3D.GraphicsFillExtra;

public class LOEBUILD_ab04ce74e60aca041a95de3600eac8f9 extends LOEBUILD_a55e9b971a38a7dec066e9372bf2e198 {

      protected var objectXML_:XML;

      protected var bI_:Number = 0.5;

      protected var tI_:Number = 0.25;

      protected var h_:Number = 1.0;

      protected var wallRepeat_:Boolean;

      protected var topRepeat_:Boolean;

      public function LOEBUILD_ab04ce74e60aca041a95de3600eac8f9(param1:XML) {
         super(param1);
         this.objectXML_ = param1;
         if(param1.hasOwnProperty("BaseIndent")) {
            this.bI_ = 0.5 - Number(param1.BaseIndent);
         }
         if(param1.hasOwnProperty("TopIndent")) {
            this.tI_ = 0.5 - Number(param1.TopIndent);
         }
         if(param1.hasOwnProperty("Height")) {
            this.h_ = Number(param1.Height);
         }
         this.wallRepeat_ = !param1.hasOwnProperty("NoWallTextureRepeat");
         this.topRepeat_ = !param1.hasOwnProperty("NoTopTextureRepeat");
      }

      override protected function buildDot() : void {
         var _local1:Vector3D = new Vector3D(-this.bI_,-this.bI_,0);
         var _local2:Vector3D = new Vector3D(this.bI_,-this.bI_,0);
         var _local3:Vector3D = new Vector3D(this.bI_,this.bI_,0);
         var _local4:Vector3D = new Vector3D(-this.bI_,this.bI_,0);
         var _local5:Vector3D = new Vector3D(-this.tI_,-this.tI_,this.h_);
         var _local6:Vector3D = new Vector3D(this.tI_,-this.tI_,this.h_);
         var _local7:Vector3D = new Vector3D(this.tI_,this.tI_,this.h_);
         var _local8:Vector3D = new Vector3D(-this.tI_,this.tI_,this.h_);
         this.addQuad(_local6,_local5,_local1,_local2,texture_,true,true);
         this.addQuad(_local7,_local6,_local2,_local3,texture_,true,true);
         this.addQuad(_local5,_local8,_local4,_local1,texture_,true,true);
         this.addQuad(_local8,_local7,_local3,_local4,texture_,true,true);
         var _local9:BitmapData = texture_;
         if(this.objectXML_.hasOwnProperty("DotTexture")) {
            _local9 = AssetLibrary.getImageFromSet(String(this.objectXML_.DotTexture.File),int(this.objectXML_.DotTexture.Index));
         }
         this.addTop([_local5,_local6,_local7,_local8],new <Number>[0.25,0.25,0.75,0.25,0.25,0.75],_local9);
      }

      override protected function buildShortLine() : void {
         var _local1:Vector3D = new Vector3D(-this.bI_,-0.5,0);
         var _local2:Vector3D = new Vector3D(this.bI_,-0.5,0);
         var _local3:Vector3D = new Vector3D(this.bI_,this.bI_,0);
         var _local4:Vector3D = new Vector3D(-this.bI_,this.bI_,0);
         var _local5:Vector3D = new Vector3D(-this.tI_,-0.5,this.h_);
         var _local6:Vector3D = new Vector3D(this.tI_,-0.5,this.h_);
         var _local7:Vector3D = new Vector3D(this.tI_,this.tI_,this.h_);
         var _local8:Vector3D = new Vector3D(-this.tI_,this.tI_,this.h_);
         this.addQuad(_local7,_local6,_local2,_local3,texture_,true,false);
         this.addQuad(_local5,_local8,_local4,_local1,texture_,false,true);
         this.addQuad(_local8,_local7,_local3,_local4,texture_,true,true);
         var _local9:BitmapData = texture_;
         if(this.objectXML_.hasOwnProperty("ShortLineTexture")) {
            _local9 = AssetLibrary.getImageFromSet(String(this.objectXML_.ShortLineTexture.File),int(this.objectXML_.ShortLineTexture.Index));
         }
         this.addTop([_local5,_local6,_local7,_local8],new <Number>[0.25,0,0.75,0,0.25,0.75],_local9);
      }

      override protected function buildL() : void {
         var _local1:Vector3D = new Vector3D(-this.bI_,-0.5,0);
         var _local2:Vector3D = new Vector3D(this.bI_,-0.5,0);
         var _local3:Vector3D = new Vector3D(this.bI_,-this.bI_,0);
         var _local4:Vector3D = new Vector3D(0.5,-this.bI_,0);
         var _local5:Vector3D = new Vector3D(0.5,this.bI_,0);
         var _local6:Vector3D = new Vector3D(-this.bI_,this.bI_,0);
         var _local7:Vector3D = new Vector3D(-this.tI_,-0.5,this.h_);
         var _local8:Vector3D = new Vector3D(this.tI_,-0.5,this.h_);
         var _local9:Vector3D = new Vector3D(this.tI_,-this.tI_,this.h_);
         var _local10:Vector3D = new Vector3D(0.5,-this.tI_,this.h_);
         var _local11:Vector3D = new Vector3D(0.5,this.tI_,this.h_);
         var _local12:Vector3D = new Vector3D(-this.tI_,this.tI_,this.h_);
         this.addBit(_local9,_local8,_local2,_local3,texture_,N2,true,true,true);
         this.addBit(_local10,_local9,_local3,_local4,texture_,N2,false,true,false);
         this.addQuad(_local12,_local11,_local5,_local6,texture_,true,false);
         this.addQuad(_local7,_local12,_local6,_local1,texture_,false,true);
         var _local13:BitmapData = texture_;
         if(this.objectXML_.hasOwnProperty("LTexture")) {
            _local13 = AssetLibrary.getImageFromSet(String(this.objectXML_.LTexture.File),int(this.objectXML_.LTexture.Index));
         }
         this.addTop([_local7,_local8,_local9,_local10,_local11,_local12],new <Number>[0.25,0,0.75,0,0.25,0.75],_local13);
      }

      override protected function buildLine() : void {
         var _local1:Vector3D = new Vector3D(-this.bI_,-0.5,0);
         var _local2:Vector3D = new Vector3D(this.bI_,-0.5,0);
         var _local3:Vector3D = new Vector3D(this.bI_,0.5,0);
         var _local4:Vector3D = new Vector3D(-this.bI_,0.5,0);
         var _local5:Vector3D = new Vector3D(-this.tI_,-0.5,this.h_);
         var _local6:Vector3D = new Vector3D(this.tI_,-0.5,this.h_);
         var _local7:Vector3D = new Vector3D(this.tI_,0.5,this.h_);
         var _local8:Vector3D = new Vector3D(-this.tI_,0.5,this.h_);
         this.addQuad(_local7,_local6,_local2,_local3,texture_,false,false);
         this.addQuad(_local5,_local8,_local4,_local1,texture_,false,false);
         var _local9:BitmapData = texture_;
         if(this.objectXML_.hasOwnProperty("LineTexture")) {
            _local9 = AssetLibrary.getImageFromSet(String(this.objectXML_.LineTexture.File),int(this.objectXML_.LineTexture.Index));
         }
         this.addTop([_local5,_local6,_local7,_local8],new <Number>[0.25,0,0.75,0,0.25,1],_local9);
      }

      override protected function buildT() : void {
         var _local1:Vector3D = new Vector3D(-this.bI_,-0.5,0);
         var _local2:Vector3D = new Vector3D(this.bI_,-0.5,0);
         var _local3:Vector3D = new Vector3D(this.bI_,-this.bI_,0);
         var _local4:Vector3D = new Vector3D(0.5,-this.bI_,0);
         var _local5:Vector3D = new Vector3D(0.5,this.bI_,0);
         var _local6:Vector3D = new Vector3D(-0.5,this.bI_,0);
         var _local7:Vector3D = new Vector3D(-0.5,-this.bI_,0);
         var _local8:Vector3D = new Vector3D(-this.bI_,-this.bI_,0);
         var _local9:Vector3D = new Vector3D(-this.tI_,-0.5,this.h_);
         var _local10:Vector3D = new Vector3D(this.tI_,-0.5,this.h_);
         var _local11:Vector3D = new Vector3D(this.tI_,-this.tI_,this.h_);
         var _local12:Vector3D = new Vector3D(0.5,-this.tI_,this.h_);
         var _local13:Vector3D = new Vector3D(0.5,this.tI_,this.h_);
         var _local14:Vector3D = new Vector3D(-0.5,this.tI_,this.h_);
         var _local15:Vector3D = new Vector3D(-0.5,-this.tI_,this.h_);
         var _local16:Vector3D = new Vector3D(-this.tI_,-this.tI_,this.h_);
         this.addBit(_local11,_local10,_local2,_local3,texture_,N2,true);
         this.addBit(_local12,_local11,_local3,_local4,texture_,N2,false);
         this.addQuad(_local14,_local13,_local5,_local6,texture_,false,false);
         this.addBit(_local16,_local15,_local7,_local8,texture_,N0,true);
         this.addBit(_local9,_local16,_local8,_local1,texture_,N0,false);
         var _local17:BitmapData = texture_;
         if(this.objectXML_.hasOwnProperty("TTexture")) {
            _local17 = AssetLibrary.getImageFromSet(String(this.objectXML_.TTexture.File),int(this.objectXML_.TTexture.Index));
         }
         this.addTop([_local9,_local10,_local11,_local12,_local13,_local14,_local15,_local16],new <Number>[0.25,0,0.75,0,0.25,0.25],_local17);
      }

      override protected function buildCross() : void {
         var _local1:Vector3D = new Vector3D(-this.bI_,-0.5,0);
         var _local2:Vector3D = new Vector3D(this.bI_,-0.5,0);
         var _local3:Vector3D = new Vector3D(this.bI_,-this.bI_,0);
         var _local4:Vector3D = new Vector3D(0.5,-this.bI_,0);
         var _local5:Vector3D = new Vector3D(0.5,this.bI_,0);
         var _local6:Vector3D = new Vector3D(this.bI_,this.bI_,0);
         var _local7:Vector3D = new Vector3D(this.bI_,0.5,0);
         var _local8:Vector3D = new Vector3D(-this.bI_,0.5,0);
         var _local9:Vector3D = new Vector3D(-this.bI_,this.bI_,0);
         var _local10:Vector3D = new Vector3D(-0.5,this.bI_,0);
         var _local11:Vector3D = new Vector3D(-0.5,-this.bI_,0);
         var _local12:Vector3D = new Vector3D(-this.bI_,-this.bI_,0);
         var _local13:Vector3D = new Vector3D(-this.tI_,-0.5,this.h_);
         var _local14:Vector3D = new Vector3D(this.tI_,-0.5,this.h_);
         var _local15:Vector3D = new Vector3D(this.tI_,-this.tI_,this.h_);
         var _local16:Vector3D = new Vector3D(0.5,-this.tI_,this.h_);
         var _local17:Vector3D = new Vector3D(0.5,this.tI_,this.h_);
         var _local18:Vector3D = new Vector3D(this.tI_,this.tI_,this.h_);
         var _local19:Vector3D = new Vector3D(this.tI_,0.5,this.h_);
         var _local20:Vector3D = new Vector3D(-this.tI_,0.5,this.h_);
         var _local21:Vector3D = new Vector3D(-this.tI_,this.tI_,this.h_);
         var _local22:Vector3D = new Vector3D(-0.5,this.tI_,this.h_);
         var _local23:Vector3D = new Vector3D(-0.5,-this.tI_,this.h_);
         var _local24:Vector3D = new Vector3D(-this.tI_,-this.tI_,this.h_);
         this.addBit(_local15,_local14,_local2,_local3,texture_,N2,true);
         this.addBit(_local16,_local15,_local3,_local4,texture_,N2,false);
         this.addBit(_local18,_local17,_local5,_local6,texture_,N4,true);
         this.addBit(_local19,_local18,_local6,_local7,texture_,N4,false);
         this.addBit(_local21,_local20,_local8,_local9,texture_,N6,true);
         this.addBit(_local22,_local21,_local9,_local10,texture_,N6,false);
         this.addBit(_local24,_local23,_local11,_local12,texture_,N0,true);
         this.addBit(_local13,_local24,_local12,_local1,texture_,N0,false);
         var _local25:BitmapData = texture_;
         if(this.objectXML_.hasOwnProperty("CrossTexture")) {
            _local25 = AssetLibrary.getImageFromSet(String(this.objectXML_.CrossTexture.File),int(this.objectXML_.CrossTexture.Index));
         }
         this.addTop([_local13,_local14,_local15,_local16,_local17,_local18,_local19,_local20,_local21,_local22,_local23,_local24],new <Number>[0.25,0,0.75,0,0.25,0.25],_local25);
      }

      protected function addQuad(param1:Vector3D, param2:Vector3D, param3:Vector3D, param4:Vector3D, param5:BitmapData, param6:Boolean, param7:Boolean) : void {
         var _local11:Number = NaN;
         var _local12:Number = NaN;
         var _local13:Vector.<Number> = null;
         var _local8:int = obj3D_.vL_.length / 3;
         obj3D_.vL_.push(param1.x,param1.y,param1.z,param2.x,param2.y,param2.z,param3.x,param3.y,param3.z,param4.x,param4.y,param4.z);
         var _local9:Number = !!param6?Number(-(this.bI_ - this.tI_) / (1 - (this.bI_ - this.tI_) - (!!param7?this.bI_ - this.tI_:0))):Number(0);
         obj3D_.uvts_.push(0,0,0,1,0,0,1,1,0,_local9,1,0);
         var _local10:LOEBUILD_1466625a8b6887d3e91cda3e12e5a036 = new LOEBUILD_1466625a8b6887d3e91cda3e12e5a036(obj3D_,new <int>[_local8,_local8 + 1,_local8 + 2,_local8 + 3]);
         _local10.texture_ = param5;
         _local10.bitmapFill_.repeat = this.wallRepeat_;
         obj3D_.faces_.push(_local10);
         if(GraphicsFillExtra.getVertexBuffer(_local10.bitmapFill_) == null && Boolean(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.isGpuRender())) {
            _local11 = 0;
            _local12 = 0;
            if(param6) {
               _local11 = _local9;
            }
            if(param7) {
               _local12 = -_local9;
            }
            if(_local12 == 0 && _local11 == 0 && Boolean(param7) && param4.x == -0.5) {
               _local12 = 0.34;
            }
            _local13 = Vector.<Number>([-0.5,0.5,0,0,0,0.5,0.5,0,1,0,-0.5 + _local11,-0.5,0,0,1,0.5 + _local12,-0.5,0,1,1]);
            GraphicsFillExtra.setVertexBuffer(_local10.bitmapFill_,_local13);
         }
      }

      protected function addBit(param1:Vector3D, param2:Vector3D, param3:Vector3D, param4:Vector3D, param5:BitmapData, param6:Vector3D, param7:Boolean, param8:Boolean = false, param9:Boolean = false) : void {
         var _local12:Vector.<Number> = null;
         var _local10:int = obj3D_.vL_.length / 3;
         obj3D_.vL_.push(param1.x,param1.y,param1.z,param2.x,param2.y,param2.z,param3.x,param3.y,param3.z,param4.x,param4.y,param4.z);
         if(param7) {
            obj3D_.uvts_.push(-0.5 + this.tI_,0,0,0,0,0,0,0,0,-0.5 + this.bI_,1,0);
         } else {
            obj3D_.uvts_.push(1,0,0,1.5 - this.tI_,0,0,0,0,0,1,1,0);
         }
         var _local11:LOEBUILD_1466625a8b6887d3e91cda3e12e5a036 = new LOEBUILD_1466625a8b6887d3e91cda3e12e5a036(obj3D_,new <int>[_local10,_local10 + 1,_local10 + 2,_local10 + 3]);
         _local11.texture_ = param5;
         _local11.bitmapFill_.repeat = this.wallRepeat_;
         _local11.normalL_ = param6;
         if(!LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.isGpuRender() && !param8) {
            obj3D_.faces_.push(_local11);
         } else if(param8) {
            if(param9) {
               _local12 = Vector.<Number>([-0.75,0.5,0,0,0,-0.5,0.5,0,1,0,-0.75,-0.5,0,0,1,-0.5,-0.5,0,1,1]);
            } else {
               _local12 = Vector.<Number>([0.5,0.5,0,0,0,0.75,0.5,0,1,0,0.5,-0.5,0,0,1,0.75,-0.5,0,1,1]);
            }
            GraphicsFillExtra.setVertexBuffer(_local11.bitmapFill_,_local12);
            obj3D_.faces_.push(_local11);
         }
      }

      protected function addTop(param1:Array, param2:Vector.<Number>, param3:BitmapData) : void {
         var _local8:LOEBUILD_1466625a8b6887d3e91cda3e12e5a036 = null;
         var _local10:Vector.<Number> = null;
         var _local11:int = 0;
         var _local12:Array = null;
         var _local13:Array = null;
         var _local14:Array = null;
         var _local15:int = 0;
         var _local16:int = 0;
         var _local17:int = 0;
         var _local4:int = obj3D_.vL_.length / 3;
         var _local5:Vector.<int> = new Vector.<int>();
         var _local6:uint = 0;
         while(_local6 < param1.length) {
            obj3D_.vL_.push(param1[_local6].x,param1[_local6].y,param1[_local6].z);
            _local5.push(_local4 + _local6);
            if(_local6 == 0) {
               obj3D_.uvts_.push(param2[0],param2[1],0);
            } else if(_local6 == 1) {
               obj3D_.uvts_.push(param2[2],param2[3],0);
            } else if(_local6 == param1.length - 1) {
               obj3D_.uvts_.push(param2[4],param2[5],0);
            } else {
               obj3D_.uvts_.push(0,0,0);
            }
            _local6++;
         }
         var _local7:LOEBUILD_1466625a8b6887d3e91cda3e12e5a036 = new LOEBUILD_1466625a8b6887d3e91cda3e12e5a036(obj3D_,_local5);
         _local7.texture_ = param3;
         _local7.bitmapFill_.repeat = this.topRepeat_;
         obj3D_.faces_.push(_local7);
         if(_local5.length == 6 && Boolean(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.isGpuRender())) {
            _local8 = new LOEBUILD_1466625a8b6887d3e91cda3e12e5a036(obj3D_,_local5);
            _local8.texture_ = param3;
            _local8.bitmapFill_.repeat = this.topRepeat_;
            obj3D_.faces_.push(_local8);
         }
         var _local9:int = 0;
         if(_local5.length == 4 && GraphicsFillExtra.getVertexBuffer(_local7.bitmapFill_) == null && Boolean(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.isGpuRender())) {
            _local10 = new Vector.<Number>();
            _local9 = 0;
            while(_local9 < _local5.length) {
               if(_local9 == 3) {
                  _local11 = 2;
               } else if(_local9 == 2) {
                  _local11 = 3;
               } else {
                  _local11 = _local9;
               }
               _local10.push(obj3D_.vL_[_local5[_local11] * 3],obj3D_.vL_[_local5[_local11] * 3 + 1] * -1,obj3D_.vL_[_local5[_local11] * 3 + 2],obj3D_.uvts_[_local5[_local11 != 2?_local11:_local11 - 1] * 3],obj3D_.uvts_[_local5[_local11 != 2?_local11:_local11 + 1] * 3 + 1]);
               _local9++;
            }
            GraphicsFillExtra.setVertexBuffer(_local7.bitmapFill_,_local10);
         } else if(_local5.length == 6 && GraphicsFillExtra.getVertexBuffer(_local7.bitmapFill_) == null && Boolean(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.isGpuRender())) {
            _local12 = [0,1,5,2];
            _local13 = [2,3,5,4];
            _local14 = [5,0,2,1];
            _local15 = 0;
            while(_local15 < 2) {
               if(_local15 == 1) {
                  _local12 = _local13;
               }
               _local10 = new Vector.<Number>();
               _local16 = 0;
               _local17 = 0;
               for each(_local9 in _local12) {
                  if(_local15 == 1) {
                     _local17 = _local14[_local16];
                  } else {
                     _local17 = _local9;
                  }
                  _local10.push(obj3D_.vL_[_local5[_local9] * 3],obj3D_.vL_[_local5[_local9] * 3 + 1] * -1,obj3D_.vL_[_local5[_local9] * 3 + 2],obj3D_.uvts_[_local5[_local17 != 2?_local17:_local17 - 1] * 3],obj3D_.uvts_[_local5[_local17 != 2?_local17:_local17 + 1] * 3 + 1]);
                  _local16++;
               }
               if(_local15 == 1) {
                  GraphicsFillExtra.setVertexBuffer(_local8.bitmapFill_,_local10);
               } else {
                  GraphicsFillExtra.setVertexBuffer(_local7.bitmapFill_,_local10);
               }
               _local15++;
            }
         }
      }
   }
}
