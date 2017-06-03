package com.company.assembleegameclient.map {
import com.company.util.GraphicsUtil;

import flash.display.GradientType;
import flash.display.GraphicsGradientFill;
import flash.display.GraphicsPath;
import flash.display.IGraphicsData;
import flash.display.Shape;

public class LOEBUILD_f06c851ce2d9a81f297bdf8e78e4e2e9 extends Shape {

      private const s:Number = 600 / Math.sin(Math.PI / 4);

      private const gradientFill_:GraphicsGradientFill = new GraphicsGradientFill(GradientType.RADIAL,[16777215,16777215,16777215],[0,0,0.92],[0,155,255],GraphicsUtil.getGradientMatrix(s,s,0,(600 - s) / 2,(600 - s) / 2));

      private const gradientPath_:GraphicsPath = GraphicsUtil.getRectPath(0,0,600,600);

      private const gradientGraphicsData_:Vector.<IGraphicsData> = new <IGraphicsData>[gradientFill_,gradientPath_,GraphicsUtil.END_FILL];

      public function LOEBUILD_f06c851ce2d9a81f297bdf8e78e4e2e9() {
         super();
         graphics.drawGraphicsData(this.gradientGraphicsData_);
         visible = false;
      }
   }
}
