package com.company.assembleegameclient.sound {
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.googleanalytics.GA;

import flash.media.SoundTransform;

public class SFX {

      private static var sfxTrans_:SoundTransform;

      public function SFX() {
         super();
      }

      public static function load() : void {
         sfxTrans_ = new SoundTransform(!!LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.playSFX?Number(1):Number(0));
      }

      public static function setPlaySFX(param1:Boolean) : void {
         GA.global().trackEvent("sound",!!param1?"soundOn":"soundOff");
         LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.playSFX = param1;
         LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.save();
         SoundEffectLibrary.updateTransform();
      }

      public static function setSFXVolume(param1:Number) : void {
         LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.SFXVolume = param1;
         LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.save();
         SoundEffectLibrary.updateVolume(param1);
      }
   }
}
