package kabam.rotmg.arena.component {
import flash.display.Shape;
import flash.display.Sprite;
import flash.text.TextFieldAutoSize;

import com.company.util.VerticalAlign;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.util.graphics.BevelRect;
import kabam.rotmg.util.graphics.GraphicsHelper;

public class HostQuerySpeechBubble extends Sprite {

      private const WIDTH:int = 174;

      private const HEIGHT:int = 225;

      private const BEVEL:int = 4;

      private const POINT:int = 6;

      private const PADDING:int = 8;

      public function HostQuerySpeechBubble(param1:String) {
         super();
         addChild(this.makeBubble());
         addChild(this.makeText(param1));
      }

      private function makeBubble() : Shape {
         var _local1:Shape = new Shape();
         this.drawBubble(_local1);
         return _local1;
      }

      private function drawBubble(param1:Shape) : void {
         var _local2:GraphicsHelper = new GraphicsHelper();
         var _local3:BevelRect = new BevelRect(this.WIDTH,this.HEIGHT,this.BEVEL);
         var _local4:int = 21;
         param1.graphics.beginFill(14737632);
         _local2.drawBevelRect(0,0,_local3,param1.graphics);
         param1.graphics.endFill();
         param1.graphics.beginFill(14737632);
         param1.graphics.moveTo(0,_local4 - this.POINT);
         param1.graphics.lineTo(-this.POINT,_local4);
         param1.graphics.lineTo(0,_local4 + this.POINT);
         param1.graphics.endFill();
      }

      private function makeText(param1:String) : TextFieldDisplayConcrete {
         var _local2:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(16).setLeading(3).setAutoSize(TextFieldAutoSize.LEFT).setVerticalAlign(com.company.util.VerticalAlign.TOP).setMultiLine(true).setWordWrap(true).setPosition(this.PADDING,this.PADDING).setTextWidth(this.WIDTH - 2 * this.PADDING).setTextHeight(this.HEIGHT - 2 * this.PADDING);
         _local2.setStringBuilder(new LineBuilder().setParams(param1));
         return _local2;
      }
   }
}
