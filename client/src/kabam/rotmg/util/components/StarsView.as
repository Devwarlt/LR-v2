package kabam.rotmg.util.components {
import com.company.rotmg.graphics.StarGraphic;

import flash.display.Graphics;
import flash.display.Sprite;
import flash.geom.ColorTransform;

public class StarsView extends Sprite {

      private static const TOTAL:int = 5;

      private static const MARGIN:int = 4;

      private static const CORNER:int = 15;

      private static const BACKGROUND_COLOR:uint = 2434341;

      private static const EMPTY_STAR_COLOR:uint = 8618883;

      private static const FILLED_STAR_COLOR:uint = 16777215;

      private const stars:Vector.<StarGraphic> = makeStars();

      private const background:Sprite = makeBackground();

      public function StarsView() {
         super();
      }

      private function makeStars() : Vector.<StarGraphic> {
         var _local1:Vector.<StarGraphic> = this.makeStarList();
         this.layoutStars(_local1);
         return _local1;
      }

      private function makeStarList() : Vector.<StarGraphic> {
         var _local1:Vector.<StarGraphic> = new Vector.<StarGraphic>(TOTAL,true);
         var _local2:int = 0;
         while(_local2 < TOTAL) {
            _local1[_local2] = new StarGraphic();
            addChild(_local1[_local2]);
            _local2++;
         }
         return _local1;
      }

      private function layoutStars(param1:Vector.<StarGraphic>) : void {
         var _local2:int = 0;
         while(_local2 < TOTAL) {
            param1[_local2].x = MARGIN + param1[0].width * _local2;
            param1[_local2].y = MARGIN;
            _local2++;
         }
      }

      private function makeBackground() : Sprite {
         var _local1:Sprite = new Sprite();
         this.drawBackground(_local1.graphics);
         addChildAt(_local1,0);
         return _local1;
      }

      private function drawBackground(param1:Graphics) : void {
         var _local2:StarGraphic = this.stars[0];
         var _local3:int = _local2.width * TOTAL + 2 * MARGIN;
         var _local4:int = _local2.height + 2 * MARGIN;
         param1.clear();
         param1.beginFill(BACKGROUND_COLOR);
         param1.drawRoundRect(0,0,_local3,_local4,CORNER,CORNER);
         param1.endFill();
      }

      public function setStars(param1:int) : void {
         var _local2:int = 0;
         while(_local2 < TOTAL) {
            this.updateStar(_local2,param1);
            _local2++;
         }
      }

      private function updateStar(param1:int, param2:int) : void {
         var _local3:StarGraphic = this.stars[param1];
         var _local4:ColorTransform = _local3.transform.colorTransform;
         _local4.color = param1 < param2?uint(FILLED_STAR_COLOR):uint(EMPTY_STAR_COLOR);
         _local3.transform.colorTransform = _local4;
      }
   }
}
