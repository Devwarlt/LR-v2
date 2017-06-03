package com.company.assembleegameclient.util {
import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
import com.company.util.AssetLibrary;
import com.company.util.PointUtil;

import flash.display.BitmapData;
import flash.display.Shader;
import flash.filters.BitmapFilterQuality;
import flash.filters.GlowFilter;
import flash.filters.ShaderFilter;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

public class TextureRedrawer {

      public static const magic:int = 12;

      public static const minSize:int = 2 * magic;

      private static const BORDER:int = 4;

      public static const OUTLINE_FILTER:GlowFilter = new GlowFilter(0,0.8,1.4,1.4,255,BitmapFilterQuality.LOW,false,false);

      private static var cache_:Dictionary = new Dictionary();

      private static var faceCache_:Dictionary = new Dictionary();

      private static var redrawCaches:Dictionary = new Dictionary();

      public static var sharedTexture_:BitmapData = null;

      private static var textureShaderEmbed_:Class = TextureRedrawer_textureShaderEmbed_;

      private static var textureShaderData_:ByteArray = new textureShaderEmbed_() as ByteArray;

      private static var colorTexture1:BitmapData = new BitmapDataSpy(1,1,false);

      private static var colorTexture2:BitmapData = new BitmapDataSpy(1,1,false);

      public function TextureRedrawer() {
         super();
      }

      public static function redraw(param1:BitmapData, param2:int, param3:Boolean, param4:uint, param5:Boolean = true, param6:Number = 5) : BitmapData {
         var _local7:String = getHash(param2,param3,param4,param6);
         if(Boolean(param5) && Boolean(isCached(param1,_local7))) {
            return redrawCaches[param1][_local7];
         }
         var _local8:BitmapData = resize(param1,null,param2,param3,0,0,param6);
         _local8 = GlowRedrawer.outlineGlow(_local8,param4,1.4,param5);
         if(param5) {
            cache(param1,_local7,_local8);
         }
         return _local8;
      }

      private static function getHash(param1:int, param2:Boolean, param3:uint, param4:Number) : String {
         return param1.toString() + "," + param3.toString() + "," + param2 + "," + param4;
      }

      private static function cache(param1:BitmapData, param2:String, param3:BitmapData) : void {
         if(!(param1 in redrawCaches)) {
            redrawCaches[param1] = {};
         }
         redrawCaches[param1][param2] = param3;
      }

      private static function isCached(param1:BitmapData, param2:String) : Boolean {
         if(param1 in redrawCaches) {
            if(param2 in redrawCaches[param1]) {
               return true;
            }
         }
         return false;
      }

      public static function resize(param1:BitmapData, param2:BitmapData, param3:int, param4:Boolean, param5:int, param6:int, param7:Number = 5) : BitmapData {
         if(param2 != null && (param5 != 0 || param6 != 0)) {
            param1 = retexture(param1,param2,param5,param6);
            param3 = param3 / 5;
         }
         var _local8:int = param7 * (param3 / 100) * param1.width;
         var _local9:int = param7 * (param3 / 100) * param1.height;
         var _local10:Matrix = new Matrix();
         _local10.scale(_local8 / param1.width,_local9 / param1.height);
         _local10.translate(magic,magic);
         var _local11:BitmapData = new BitmapDataSpy(_local8 + minSize,_local9 + (!!param4?magic:1) + magic,true,0);
         _local11.draw(param1,_local10);
         return _local11;
      }

      public static function redrawSolidSquare(param1:uint, param2:int) : BitmapData {
         var _local3:Dictionary = cache_[param2];
         if(_local3 == null) {
            _local3 = new Dictionary();
            cache_[param2] = _local3;
         }
         var _local4:BitmapData = _local3[param1];
         if(_local4 != null) {
            return _local4;
         }
         _local4 = new BitmapDataSpy(param2 + 4 + 4,param2 + 4 + 4,true,0);
         _local4.fillRect(new Rectangle(4,4,param2,param2),4278190080 | param1);
         _local4.applyFilter(_local4,_local4.rect,PointUtil.ORIGIN,OUTLINE_FILTER);
         _local3[param1] = _local4;
         return _local4;
      }

      public static function clearCache() : void {
         var _local1:BitmapData;
         var _local2:Dictionary;
         var _local3:Dictionary;
         for each(_local2 in cache_) {
            for each(_local1 in _local2) {
               _local1.dispose();
            }
         }
         cache_ = new Dictionary();
         for each(_local3 in faceCache_) {
            for each(_local1 in _local3) {
               _local1.dispose();
            }
         }
         faceCache_ = new Dictionary();
      }

      public static function redrawFace(param1:BitmapData, param2:Number) : BitmapData {
         if(param2 == 1) {
            return param1;
         }
         var _local3:Dictionary = faceCache_[param2];
         if(_local3 == null) {
            _local3 = new Dictionary();
            faceCache_[param2] = _local3;
         }
         var _local4:BitmapData = _local3[param1];
         if(_local4 != null) {
            return _local4;
         }
         _local4 = param1.clone();
         _local4.colorTransform(_local4.rect,new ColorTransform(param2,param2,param2));
         _local3[param1] = _local4;
         return _local4;
      }

      private static function getTexture(param1:int, param2:BitmapData) : BitmapData {
         var _local3:BitmapData = null;
         var _local4:* = param1 >> 24 & 255;
         var _local5:* = param1 & 16777215;
         switch(_local4) {
            case 0:
               _local3 = param2;
               break;
            case 1:
               param2.setPixel(0,0,_local5);
               _local3 = param2;
               break;
            case 4:
               _local3 = AssetLibrary.getImageFromSet("textile4x4",_local5);
               break;
            case 5:
               _local3 = AssetLibrary.getImageFromSet("textile5x5",_local5);
               break;
            case 9:
               _local3 = AssetLibrary.getImageFromSet("textile9x9",_local5);
               break;
            case 10:
               _local3 = AssetLibrary.getImageFromSet("textile10x10",_local5);
               break;
            case 255:
               _local3 = sharedTexture_;
               break;
            default:
               _local3 = param2;
         }
         return _local3;
      }

      private static function retexture(param1:BitmapData, param2:BitmapData, param3:int, param4:int) : BitmapData {
         var _local5:Matrix = new Matrix();
         _local5.scale(5,5);
         var _local6:BitmapData = new BitmapDataSpy(param1.width * 5,param1.height * 5,true,0);
         _local6.draw(param1,_local5);
         var _local7:BitmapData = getTexture(param3,colorTexture1);
         var _local8:BitmapData = getTexture(param4,colorTexture2);
         var _local9:Shader = new Shader(textureShaderData_);
         _local9.data.src.input = _local6;
         _local9.data.mask.input = param2;
         _local9.data.texture1.input = _local7;
         _local9.data.texture2.input = _local8;
         _local9.data.texture1Size.value = [param3 == 0?0:_local7.width];
         _local9.data.texture2Size.value = [param4 == 0?0:_local8.width];
         _local6.applyFilter(_local6,_local6.rect,PointUtil.ORIGIN,new ShaderFilter(_local9));
         return _local6;
      }

      private static function getDrawMatrix() : Matrix {
         var _local1:Matrix = new Matrix();
         _local1.scale(8,8);
         _local1.translate(BORDER,BORDER);
         return _local1;
      }
   }
}
