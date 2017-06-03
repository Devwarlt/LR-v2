package kabam.rotmg.ui.view {
import flash.display.Sprite;

public class CharacterWindowBackground extends Sprite {

      public function CharacterWindowBackground() {
         super();
         var _local1:Sprite = new Sprite();
         _local1.graphics.beginFill(3552822);
         _local1.graphics.drawRect(0,0,200,600);
         addChild(_local1);
      }
   }
}
