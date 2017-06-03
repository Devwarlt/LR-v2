package com.company.assembleegameclient.util {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;
import com.company.rotmg.graphics.StarGraphic;
import com.company.util.AssetLibrary;

import flash.display.BitmapData;
import flash.display.Sprite;
import flash.filters.DropShadowFilter;
import flash.geom.ColorTransform;

public class FameUtil {

      public static const STARS:Vector.<int> = new <int>[20,150,400,800,2000];

      private static const lightBlueCT:ColorTransform = new ColorTransform(138 / 255,152 / 255,222 / 255);

      private static const darkBlueCT:ColorTransform = new ColorTransform(49 / 255,77 / 255,219 / 255);

      private static const redCT:ColorTransform = new ColorTransform(193 / 255,39 / 255,45 / 255);

      private static const orangeCT:ColorTransform = new ColorTransform(247 / 255,147 / 255,30 / 255);

      private static const yellowCT:ColorTransform = new ColorTransform(255 / 255,255 / 255,0 / 255);

      public static const COLORS:Vector.<ColorTransform> = new <ColorTransform>[lightBlueCT,darkBlueCT,redCT,orangeCT,yellowCT];

      public function FameUtil() {
         super();
      }

      public static function maxStars() : int {
         return LOEBUILD_efda783509bc93eea698457c87bbee3f.playerChars_.length * STARS.length;
      }

      public static function numStars(param1:int) : int {
         var _local2:int = 0;
         while(_local2 < STARS.length && param1 >= STARS[_local2]) {
            _local2++;
         }
         return _local2;
      }

      public static function nextStarFame(param1:int, param2:int) : int {
         var _local3:int = Math.max(param1,param2);
         var _local4:int = 0;
         while(_local4 < STARS.length) {
            if(STARS[_local4] > _local3) {
               return STARS[_local4];
            }
            _local4++;
         }
         return -1;
      }

      public static function numAllTimeStars(param1:int, param2:int, param3:XML) : int {
         var _local6:XML = null;
         var _local4:int = 0;
         var _local5:int = 0;
         for each(_local6 in param3.ClassStats) {
            if(param1 == int(_local6.@objectType)) {
               _local5 = int(_local6.BestFame);
            } else {
               _local4 = _local4 + FameUtil.numStars(_local6.BestFame);
            }
         }
         _local4 = _local4 + FameUtil.numStars(Math.max(_local5,param2));
         return _local4;
      }

      public static function numStarsToBigImage(param1:int) : Sprite {
         var _local2:Sprite = numStarsToImage(param1);
         _local2.filters = [new DropShadowFilter(0,0,0,1,4,4,2)];
         _local2.scaleX = 1.4;
         _local2.scaleY = 1.4;
         return _local2;
      }

      public static function numStarsToImage(param1:int) : Sprite {
         var _local2:Sprite = new StarGraphic();
         if(param1 < LOEBUILD_efda783509bc93eea698457c87bbee3f.playerChars_.length) {
            _local2.transform.colorTransform = lightBlueCT;
         } else if(param1 < LOEBUILD_efda783509bc93eea698457c87bbee3f.playerChars_.length * 2) {
            _local2.transform.colorTransform = darkBlueCT;
         } else if(param1 < LOEBUILD_efda783509bc93eea698457c87bbee3f.playerChars_.length * 3) {
            _local2.transform.colorTransform = redCT;
         } else if(param1 < LOEBUILD_efda783509bc93eea698457c87bbee3f.playerChars_.length * 4) {
            _local2.transform.colorTransform = orangeCT;
         } else if(param1 < LOEBUILD_efda783509bc93eea698457c87bbee3f.playerChars_.length * 5) {
            _local2.transform.colorTransform = yellowCT;
         }
         return _local2;
      }

      public static function numStarsToIcon(param1:int) : Sprite {
         var _local2:Sprite = null;
         var _local3:Sprite = null;
         _local2 = numStarsToImage(param1);
         _local3 = new Sprite();
         _local3.graphics.beginFill(0,0.4);
         var _local4:int = _local2.width / 2 + 2;
         var _local5:int = _local2.height / 2 + 2;
         _local3.graphics.drawCircle(_local4,_local5,_local4);
         _local2.x = 2;
         _local2.y = 1;
         _local3.addChild(_local2);
         _local3.filters = [new DropShadowFilter(0,0,0,0.5,6,6,1)];
         return _local3;
      }

      public static function getFameIcon() : BitmapData {
         var _local1:BitmapData = AssetLibrary.getImageFromSet("lofiObj3",224);
         return TextureRedrawer.redraw(_local1,40,true,0);
      }
   }
}
