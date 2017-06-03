package kabam.rotmg.fortune.components {
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.AssetLibrary;
import com.company.util.MoreColorUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.filters.ColorMatrixFilter;

public class CrystalMain extends Sprite {

      public static const ANIMATION_STAGE_PULSE:int = 0;

      public static const ANIMATION_STAGE_BUZZING:int = 1;

      public static const ANIMATION_STAGE_INNERROTATION:int = 2;

      public static const ANIMATION_STAGE_FLASH:int = 3;

      public static const ANIMATION_STAGE_WAITING:int = 4;

      public static const GLOW_COLOR:int = 0;

      public var bigCrystal:Bitmap;

      private var crystalFrames:Vector.<Bitmap>;

      private const STARTING_FRAME_INDEX:Number = 176;

      private var animationDuration_:Number = 210;

      private var startFrame_:Number = 0;

      private var numFramesofLoop_:Number;

      public var size_:int = 150;

      public function CrystalMain() {
         var _local1:BitmapData = null;
         var _local2:uint = 0;
         var _local3:Bitmap = null;
         super();
         this.crystalFrames = new Vector.<Bitmap>();
         _local2 = 0;
         while(_local2 < 3) {
            _local1 = AssetLibrary.getImageFromSet("lofiCharBig",this.STARTING_FRAME_INDEX + _local2);
            _local1 = TextureRedrawer.redraw(_local1,this.size_,true,GLOW_COLOR,false);
            _local3 = new Bitmap(_local1);
            _local3.filters = [new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix)];
            this.crystalFrames.push(_local3);
            _local2++;
         }
         _local2 = 0;
         while(_local2 < 3) {
            _local1 = AssetLibrary.getImageFromSet("lofiCharBig",this.STARTING_FRAME_INDEX + 16 + _local2);
            _local1 = TextureRedrawer.redraw(_local1,this.size_,true,GLOW_COLOR,false);
            this.crystalFrames.push(new Bitmap(_local1));
            _local2++;
         }
         _local2 = 0;
         while(_local2 < 7) {
            _local1 = AssetLibrary.getImageFromSet("lofiCharBig",this.STARTING_FRAME_INDEX + 32 + _local2);
            _local1 = TextureRedrawer.redraw(_local1,this.size_,true,GLOW_COLOR,false);
            this.crystalFrames.push(new Bitmap(_local1));
            _local2++;
         }
         _local2 = 0;
         while(_local2 < 7) {
            _local1 = AssetLibrary.getImageFromSet("lofiCharBig",this.STARTING_FRAME_INDEX + 48 + _local2);
            _local1 = TextureRedrawer.redraw(_local1,this.size_,true,GLOW_COLOR,false);
            this.crystalFrames.push(new Bitmap(_local1));
            _local2++;
         }
         _local2 = 0;
         while(_local2 < 5) {
            _local1 = AssetLibrary.getImageFromSet("lofiCharBig",this.STARTING_FRAME_INDEX + 64 + _local2);
            _local1 = TextureRedrawer.redraw(_local1,this.size_,true,GLOW_COLOR,false);
            this.crystalFrames.push(new Bitmap(_local1));
            _local2++;
         }
         _local2 = 0;
         while(_local2 < 8) {
            _local1 = AssetLibrary.getImageFromSet("lofiCharBig",this.STARTING_FRAME_INDEX + 80 + _local2);
            _local1 = TextureRedrawer.redraw(_local1,this.size_,true,GLOW_COLOR,false);
            this.crystalFrames.push(new Bitmap(_local1));
            _local2++;
         }
         this.reset();
         _local1 = AssetLibrary.getImageFromSet("lofiCharBig",32);
         _local1 = TextureRedrawer.redraw(_local1,this.size_,true,GLOW_COLOR,false);
         this.bigCrystal = new Bitmap(_local1);
         addChild(this.bigCrystal);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }

      public function reset() : void {
         this.setAnimationStage(ANIMATION_STAGE_FLASH);
      }

      public function setXPos(param1:Number) : void {
         this.x = param1 - this.width / 2;
      }

      public function setYPos(param1:Number) : void {
         this.y = param1 - this.height / 2;
      }

      public function getCenterX() : Number {
         return this.x + this.width / 2;
      }

      public function getCenterY() : Number {
         return this.y + this.height / 2;
      }

      public function drawAnimation(param1:int, param2:int) : void {
         removeChild(this.bigCrystal);
         this.bigCrystal = this.crystalFrames[this.startFrame_ + uint(param1 / this.animationDuration_ % this.numFramesofLoop_)];
         addChild(this.bigCrystal);
      }

      public function setAnimationDuration(param1:Number) : void {
         this.animationDuration_ = param1;
      }

      public function setAnimation(param1:Number, param2:Number) : void {
         this.startFrame_ = param1;
         this.numFramesofLoop_ = param2;
      }

      public function setAnimationStage(param1:int) : void {
         switch(param1) {
            case ANIMATION_STAGE_PULSE:
               this.setAnimation(0,0);
               this.setAnimationDuration(250);
               break;
            case ANIMATION_STAGE_BUZZING:
               this.setAnimation(3,3);
               this.setAnimationDuration(10);
               break;
            case ANIMATION_STAGE_INNERROTATION:
               this.setAnimation(6,7);
               this.setAnimationDuration(80);
               break;
            case ANIMATION_STAGE_FLASH:
               this.setAnimation(13,7);
               this.setAnimationDuration(210);
               break;
            case ANIMATION_STAGE_WAITING:
               this.setAnimation(20,13);
               this.setAnimationDuration(120);
               break;
            default:
               this.setAnimation(13,7);
         }
      }

      private function onRemovedFromStage(param1:Event) : void {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         this.bigCrystal = null;
         this.crystalFrames = null;
      }
   }
}
