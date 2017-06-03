package com.company.assembleegameclient.ui {
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.assembleegameclient.sound.Music;
import com.company.assembleegameclient.sound.SFX;
import com.company.util.AssetLibrary;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.GlowFilter;

public class SoundIcon extends Sprite {

      private var bitmap_:Bitmap;

      public function SoundIcon() {
         this.bitmap_ = new Bitmap();
         super();
         addChild(this.bitmap_);
         this.bitmap_.scaleX = 2;
         this.bitmap_.scaleY = 2;
         this.setBitmap();
         addEventListener(MouseEvent.CLICK,this.onIconClick);
         filters = [new GlowFilter(0,1,4,4,2,1)];
      }

      private function setBitmap() : void {
         this.bitmap_.bitmapData = Boolean(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.playMusic) || Boolean(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.playSFX)?AssetLibrary.getImageFromSet("lofiInterfaceBig",3):AssetLibrary.getImageFromSet("lofiInterfaceBig",4);
      }

      private function onIconClick(param1:MouseEvent) : void {
         var _local2:* = !(Boolean(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.playMusic) || Boolean(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.playSFX));
         Music.setPlayMusic(_local2);
         SFX.setPlaySFX(_local2);
         LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.playPewPew = _local2;
         LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.save();
         this.setBitmap();
      }
   }
}
