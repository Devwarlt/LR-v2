package kabam.rotmg.pets.view.components {
import com.company.util.GraphicsUtil;

import flash.display.GraphicsPath;
import flash.display.GraphicsPathWinding;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.display.Sprite;
import flash.geom.ColorTransform;

public class FeedFuseArrow extends Sprite {

      private var designFill_:GraphicsSolidFill;

      private var designPath_:GraphicsPath;

      private const designGraphicsData_:Vector.<IGraphicsData> = new <IGraphicsData>[designFill_,designPath_,GraphicsUtil.END_FILL];

      public function FeedFuseArrow() {
         this.designFill_ = new GraphicsSolidFill(16777215,1);
         this.designPath_ = new GraphicsPath(new Vector.<int>(),new Vector.<Number>(),GraphicsPathWinding.NON_ZERO);
         super();
         this.setColor(6710886);
      }

      public function setColor(param1:uint) : void {
         graphics.clear();
         GraphicsUtil.clearPath(this.designPath_);
         this.designFill_.color = param1;
         this.drawArrow();
         GraphicsUtil.drawRect(26,11.5,24,19,this.designPath_);
         graphics.drawGraphicsData(this.designGraphicsData_);
      }

      public function highlight(param1:Boolean) : void {
         var _local2:ColorTransform = transform.colorTransform;
         _local2.color = !!param1?uint(16777103):uint(2368548);
         transform.colorTransform = _local2;
      }

      private function drawArrow() : void {
         this.designPath_.moveTo(0,20);
         this.designPath_.lineTo(26,0);
         this.designPath_.lineTo(26,40);
         this.designPath_.lineTo(0,20);
         graphics.drawGraphicsData(this.designGraphicsData_);
      }
   }
}
