package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Square;

import flash.display.IGraphicsData;

public class SpiderWeb extends GameObject {

      private var wallFound_:Boolean = false;

      public function SpiderWeb(param1:XML) {
         super(param1);
      }

      override public function draw(param1:Vector.<IGraphicsData>, param2:Camera, param3:int) : void {
         if(!this.wallFound_) {
            this.wallFound_ = this.findWall();
         }
         if(this.wallFound_) {
            super.draw(param1,param2,param3);
         }
      }

      private function findWall() : Boolean {
         var _local1:Square = null;
         _local1 = map_.lookupSquare(x_ - 1,y_);
         if(_local1 != null && _local1.obj_ is Wall) {
            return true;
         }
         _local1 = map_.lookupSquare(x_,y_ - 1);
         if(_local1 != null && _local1.obj_ is Wall) {
            obj3D_.setPosition(x_,y_,0,90);
            return true;
         }
         _local1 = map_.lookupSquare(x_ + 1,y_);
         if(_local1 != null && _local1.obj_ is Wall) {
            obj3D_.setPosition(x_,y_,0,180);
            return true;
         }
         _local1 = map_.lookupSquare(x_,y_ + 1);
         if(_local1 != null && _local1.obj_ is Wall) {
            obj3D_.setPosition(x_,y_,0,270);
            return true;
         }
         return false;
      }
   }
}
