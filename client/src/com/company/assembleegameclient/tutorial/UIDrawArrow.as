package com.company.assembleegameclient.tutorial {
import com.company.util.ConversionUtil;
import com.company.util.PointUtil;

import flash.display.Graphics;
import flash.geom.Point;

public class UIDrawArrow {

      public var p0_:Point;

      public var p1_:Point;

      public var color_:uint;

      public const ANIMATION_MS:int = 500;

      public function UIDrawArrow(param1:XML) {
         super();
         var _local2:Array = ConversionUtil.toPointPair(param1);
         this.p0_ = _local2[0];
         this.p1_ = _local2[1];
         this.color_ = uint(param1.@color);
      }

      public function draw(param1:int, param2:Graphics, param3:int) : void {
         var _local6:Point = null;
         var _local4:Point = new Point();
         if(param3 < this.ANIMATION_MS) {
            _local4.x = this.p0_.x + (this.p1_.x - this.p0_.x) * param3 / this.ANIMATION_MS;
            _local4.y = this.p0_.y + (this.p1_.y - this.p0_.y) * param3 / this.ANIMATION_MS;
         } else {
            _local4.x = this.p1_.x;
            _local4.y = this.p1_.y;
         }
         param2.lineStyle(param1,this.color_);
         param2.moveTo(this.p0_.x,this.p0_.y);
         param2.lineTo(_local4.x,_local4.y);
         var _local5:Number = PointUtil.angleTo(_local4,this.p0_);
         _local6 = PointUtil.pointAt(_local4,_local5 + Math.PI / 8,30);
         param2.lineTo(_local6.x,_local6.y);
         _local6 = PointUtil.pointAt(_local4,_local5 - Math.PI / 8,30);
         param2.moveTo(_local4.x,_local4.y);
         param2.lineTo(_local6.x,_local6.y);
      }
   }
}
