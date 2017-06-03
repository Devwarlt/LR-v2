package com.company.util {
import flash.display.CapsStyle;
import flash.display.GraphicsEndFill;
import flash.display.GraphicsPath;
import flash.display.GraphicsPathCommand;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.geom.Matrix;

public class GraphicsUtil {

      public static const END_FILL:GraphicsEndFill = new GraphicsEndFill();

      public static const QUAD_COMMANDS:Vector.<int> = new <int>[GraphicsPathCommand.MOVE_TO,GraphicsPathCommand.LINE_TO,GraphicsPathCommand.LINE_TO,GraphicsPathCommand.LINE_TO];

      public static const DEBUG_STROKE:GraphicsStroke = new GraphicsStroke(1,false,LineScaleMode.NORMAL,CapsStyle.NONE,JointStyle.ROUND,3,new GraphicsSolidFill(16711680));

      public static const END_STROKE:GraphicsStroke = new GraphicsStroke();

      private static const TWO_PI:Number = 2 * Math.PI;

      public static const ALL_CUTS:Array = [true,true,true,true];

      public function GraphicsUtil() {
         super();
      }

      public static function clearPath(param1:GraphicsPath) : void {
         param1.commands.length = 0;
         param1.data.length = 0;
      }

      public static function getRectPath(param1:int, param2:int, param3:int, param4:int) : GraphicsPath {
         return new GraphicsPath(QUAD_COMMANDS,new <Number>[param1,param2,param1 + param3,param2,param1 + param3,param2 + param4,param1,param2 + param4]);
      }

      public static function getGradientMatrix(param1:Number, param2:Number, param3:Number = 0.0, param4:Number = 0.0, param5:Number = 0.0) : Matrix {
         var _local6:Matrix = new Matrix();
         _local6.createGradientBox(param1,param2,param3,param4,param5);
         return _local6;
      }

      public static function drawRect(param1:int, param2:int, param3:int, param4:int, param5:GraphicsPath) : void {
         param5.moveTo(param1,param2);
         param5.lineTo(param1 + param3,param2);
         param5.lineTo(param1 + param3,param2 + param4);
         param5.lineTo(param1,param2 + param4);
      }

      public static function drawCircle(param1:Number, param2:Number, param3:Number, param4:GraphicsPath, param5:int = 8) : void {
         var _local8:Number = NaN;
         var _local9:Number = NaN;
         var _local10:Number = NaN;
         var _local11:Number = NaN;
         var _local12:Number = NaN;
         var _local13:Number = NaN;
         var _local6:Number = 1 + 1 / (param5 * 1.75);
         param4.moveTo(param1 + param3,param2);
         var _local7:int = 1;
         while(_local7 <= param5) {
            _local8 = TWO_PI * _local7 / param5;
            _local9 = TWO_PI * (_local7 - 0.5) / param5;
            _local10 = param1 + param3 * Math.cos(_local8);
            _local11 = param2 + param3 * Math.sin(_local8);
            _local12 = param1 + param3 * _local6 * Math.cos(_local9);
            _local13 = param2 + param3 * _local6 * Math.sin(_local9);
            param4.curveTo(_local12,_local13,_local10,_local11);
            _local7++;
         }
      }

      public static function drawCutEdgeRect(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Array, param7:GraphicsPath) : void {
         if(param6[0] != 0) {
            param7.moveTo(param1,param2 + param5);
            param7.lineTo(param1 + param5,param2);
         } else {
            param7.moveTo(param1,param2);
         }
         if(param6[1] != 0) {
            param7.lineTo(param1 + param3 - param5,param2);
            param7.lineTo(param1 + param3,param2 + param5);
         } else {
            param7.lineTo(param1 + param3,param2);
         }
         if(param6[2] != 0) {
            param7.lineTo(param1 + param3,param2 + param4 - param5);
            param7.lineTo(param1 + param3 - param5,param2 + param4);
         } else {
            param7.lineTo(param1 + param3,param2 + param4);
         }
         if(param6[3] != 0) {
            param7.lineTo(param1 + param5,param2 + param4);
            param7.lineTo(param1,param2 + param4 - param5);
         } else {
            param7.lineTo(param1,param2 + param4);
         }
         if(param6[0] != 0) {
            param7.lineTo(param1,param2 + param5);
         } else {
            param7.lineTo(param1,param2);
         }
      }

      public static function drawDiamond(param1:Number, param2:Number, param3:Number, param4:GraphicsPath) : void {
         param4.moveTo(param1,param2 - param3);
         param4.lineTo(param1 + param3,param2);
         param4.lineTo(param1,param2 + param3);
         param4.lineTo(param1 - param3,param2);
      }
   }
}
