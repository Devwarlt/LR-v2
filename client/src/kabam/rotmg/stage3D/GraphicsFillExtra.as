package kabam.rotmg.stage3D {
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;

import flash.display.BitmapData;
import flash.display.GraphicsBitmapFill;
import flash.display.GraphicsSolidFill;
import flash.display3D.Context3DVertexBufferFormat;
import flash.display3D.VertexBuffer3D;
import flash.geom.ColorTransform;
import flash.utils.Dictionary;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.stage3D.proxies.Context3DProxy;

public class GraphicsFillExtra {

      private static var textureOffsets:Dictionary = new Dictionary();

      private static var textureOffsetsSize:uint = 0;

      private static var waterSinks:Dictionary = new Dictionary();

      private static var waterSinksSize:uint = 0;

      private static var colorTransforms:Dictionary = new Dictionary();

      private static var colorTransformsSize:uint = 0;

      private static var vertexBuffers:Dictionary = new Dictionary();

      private static var vertexBuffersSize:uint = 0;

      private static var softwareDraw:Dictionary = new Dictionary();

      private static var softwareDrawSize:uint = 0;

      private static var softwareDrawSolid:Dictionary = new Dictionary();

      private static var softwareDrawSolidSize:uint = 0;

      private static var lastChecked:uint = 0;

      private static const DEFAULT_OFFSET:Vector.<Number> = Vector.<Number>([0,0,0,0]);

      public function GraphicsFillExtra() {
         super();
      }

      public static function setColorTransform(param1:BitmapData, param2:ColorTransform) : void {
         if(!LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.isGpuRender()) {
            return;
         }
         if(colorTransforms[param1] == null) {
            colorTransformsSize++;
         }
         colorTransforms[param1] = param2;
      }

      public static function getColorTransform(param1:BitmapData) : ColorTransform {
         var _local2:ColorTransform = null;
         if(param1 in colorTransforms) {
            _local2 = colorTransforms[param1];
            colorTransforms[param1] = new ColorTransform();
         } else {
            _local2 = new ColorTransform();
            colorTransforms[param1] = _local2;
            colorTransformsSize++;
         }
         return _local2;
      }

      public static function setOffsetUV(param1:GraphicsBitmapFill, param2:Number, param3:Number) : void {
         if(!LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.isGpuRender()) {
            return;
         }
         testOffsetUV(param1);
         textureOffsets[param1][0] = param2;
         textureOffsets[param1][1] = param3;
      }

      public static function getOffsetUV(param1:GraphicsBitmapFill) : Vector.<Number> {
         if(textureOffsets[param1] != null) {
            return textureOffsets[param1];
         }
         return DEFAULT_OFFSET;
      }

      private static function testOffsetUV(param1:GraphicsBitmapFill) : void {
         if(!LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.isGpuRender()) {
            return;
         }
         if(textureOffsets[param1] == null) {
            textureOffsetsSize++;
            textureOffsets[param1] = Vector.<Number>([0,0,0,0]);
         }
      }

      public static function setSinkLevel(param1:GraphicsBitmapFill, param2:Number) : void {
         if(!LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.isGpuRender()) {
            return;
         }
         if(waterSinks[param1] == null) {
            waterSinksSize++;
         }
         waterSinks[param1] = param2;
      }

      public static function getSinkLevel(param1:GraphicsBitmapFill) : Number {
         if(waterSinks[param1] != null && waterSinks[param1] is Number) {
            return waterSinks[param1];
         }
         return 0;
      }

      public static function setVertexBuffer(param1:GraphicsBitmapFill, param2:Vector.<Number>) : void {
         if(!LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.isGpuRender()) {
            return;
         }
         var _local3:Context3DProxy = StaticInjectorContext.getInjector().getInstance(Context3DProxy);
         var _local4:VertexBuffer3D = _local3.GetContext3D().createVertexBuffer(4,5);
         _local4.uploadFromVector(param2,0,4);
         _local3.GetContext3D().setVertexBufferAt(0,_local4,0,Context3DVertexBufferFormat.FLOAT_3);
         _local3.GetContext3D().setVertexBufferAt(1,_local4,3,Context3DVertexBufferFormat.FLOAT_2);
         if(vertexBuffers[param1] == null) {
            vertexBuffersSize++;
         }
         vertexBuffers[param1] = _local4;
      }

      public static function getVertexBuffer(param1:GraphicsBitmapFill) : VertexBuffer3D {
         if(vertexBuffers[param1] != null && vertexBuffers[param1] is VertexBuffer3D) {
            return vertexBuffers[param1];
         }
         return null;
      }

      public static function clearSink(param1:GraphicsBitmapFill) : void {
         if(!LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.isGpuRender()) {
            return;
         }
         if(waterSinks[param1] != null) {
            waterSinksSize--;
            delete waterSinks[param1];
         }
      }

      public static function setSoftwareDraw(param1:GraphicsBitmapFill, param2:Boolean) : void {
         if(!LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.isGpuRender()) {
            return;
         }
         if(softwareDraw[param1] == null) {
            softwareDrawSize++;
         }
         softwareDraw[param1] = param2;
      }

      public static function isSoftwareDraw(param1:GraphicsBitmapFill) : Boolean {
         if(softwareDraw[param1] != null && softwareDraw[param1] is Boolean) {
            return softwareDraw[param1];
         }
         return false;
      }

      public static function setSoftwareDrawSolid(param1:GraphicsSolidFill, param2:Boolean) : void {
         if(!LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.isGpuRender()) {
            return;
         }
         if(softwareDrawSolid[param1] == null) {
            softwareDrawSolidSize++;
         }
         softwareDrawSolid[param1] = param2;
      }

      public static function isSoftwareDrawSolid(param1:GraphicsSolidFill) : Boolean {
         if(softwareDrawSolid[param1] != null && softwareDrawSolid[param1] is Boolean) {
            return softwareDrawSolid[param1];
         }
         return false;
      }

      public static function dispose() : void {
         textureOffsets = new Dictionary();
         waterSinks = new Dictionary();
         colorTransforms = new Dictionary();
         disposeVertexBuffers();
         softwareDraw = new Dictionary();
         softwareDrawSolid = new Dictionary();
         textureOffsetsSize = 0;
         waterSinksSize = 0;
         colorTransformsSize = 0;
         vertexBuffersSize = 0;
         softwareDrawSize = 0;
         softwareDrawSolidSize = 0;
      }

      public static function disposeVertexBuffers() : void {
         var _local1:VertexBuffer3D = null;
         for each(_local1 in vertexBuffers) {
            _local1.dispose();
         }
         vertexBuffers = new Dictionary();
      }

      public static function manageSize() : void {
         if(colorTransformsSize > 2000) {
            colorTransforms = new Dictionary();
            colorTransformsSize = 0;
         }
         if(textureOffsetsSize > 2000) {
            textureOffsets = new Dictionary();
            textureOffsetsSize = 0;
         }
         if(waterSinksSize > 2000) {
            waterSinks = new Dictionary();
            waterSinksSize = 0;
         }
         if(vertexBuffersSize > 1000) {
            disposeVertexBuffers();
            vertexBuffersSize = 0;
         }
         if(softwareDrawSize > 2000) {
            softwareDraw = new Dictionary();
            softwareDrawSize = 0;
         }
         if(softwareDrawSolidSize > 2000) {
            softwareDrawSolid = new Dictionary();
            softwareDrawSolidSize = 0;
         }
      }
   }
}
