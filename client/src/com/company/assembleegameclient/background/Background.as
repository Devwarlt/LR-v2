package com.company.assembleegameclient.background {
import com.company.assembleegameclient.map.Camera;

import flash.display.Sprite;

public class Background extends Sprite {

      public static const NO_BACKGROUND:int = 0;

      public static const STAR_BACKGROUND:int = 1;

      public static const NEXUS_BACKGROUND:int = 2;

      public static const NUM_BACKGROUND:int = 3;

      public function Background() {
         super();
         visible = false;
      }

      public static function getBackground(param1:int) : Background {
         switch(param1) {
            case NO_BACKGROUND:
               return null;
            case STAR_BACKGROUND:
               return new LOEBUILD_2f7564d11dae17cf2e641ed7747c1dc5();
            case NEXUS_BACKGROUND:
               return new LOEBUILD_f7196ae5919086469aef24622b313bda();
            default:
               return null;
         }
      }

      public function draw(param1:Camera, param2:int) : void {
      }
   }
}
