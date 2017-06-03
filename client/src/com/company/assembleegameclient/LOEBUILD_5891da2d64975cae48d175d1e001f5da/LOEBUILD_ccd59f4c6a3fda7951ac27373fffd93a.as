package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da {
import com.company.assembleegameclient.LOEBUILD_1f4c42c309fe6bc45253d598cfdf9b99.RemoteTexture;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles.EffectProperties;
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.AnimatedChars;
import com.company.assembleegameclient.util.AssetLoader;
import com.company.assembleegameclient.util.MaskedImage;
import com.company.util.AssetLibrary;

import flash.display.BitmapData;
import flash.utils.Dictionary;

import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.core.StaticInjectorContext;

public class LOEBUILD_ccd59f4c6a3fda7951ac27373fffd93a extends TextureData {

      public static var remoteTexturesUsed:Boolean = false;

      private var isUsingLocalTextures:Boolean;

      public function LOEBUILD_ccd59f4c6a3fda7951ac27373fffd93a(param1:XML) {
         var _local2:XML = null;
         super();
         this.isUsingLocalTextures = this.getWhetherToUseLocalTextures();
         if(param1.hasOwnProperty("Texture")) {
            this.parse(XML(param1.Texture));
         } else if(param1.hasOwnProperty("AnimatedTexture")) {
            this.parse(XML(param1.AnimatedTexture));
         } else if(param1.hasOwnProperty("RemoteTexture")) {
            this.parse(XML(param1.RemoteTexture));
         } else if(param1.hasOwnProperty("RandomTexture")) {
            this.parse(XML(param1.RandomTexture));
         } else {
            this.parse(param1);
         }
         for each(_local2 in param1.AltTexture) {
            this.parse(_local2);
         }
         if(param1.hasOwnProperty("Mask")) {
            this.parse(XML(param1.Mask));
         }
         if(param1.hasOwnProperty("Effect")) {
            this.parse(XML(param1.Effect));
         }
      }

      override public function getTexture(param1:int = 0) : BitmapData {
         if(randomTextureData_ == null) {
            return texture_;
         }
         var _local2:TextureData = randomTextureData_[param1 % randomTextureData_.length];
         return _local2.getTexture(param1);
      }

      override public function getAltTextureData(param1:int) : TextureData {
         if(altTextures_ == null) {
            return null;
         }
         return altTextures_[param1];
      }

      private function getWhetherToUseLocalTextures() : Boolean {
         var _local1:ApplicationSetup = StaticInjectorContext.getInjector().getInstance(ApplicationSetup);
         return _local1.useLocalTextures();
      }

      private function parse(param1:XML) : void {
         var _local2:MaskedImage = null;
         var _local3:RemoteTexture = null;
         var _local4:XML = null;
         switch(param1.name().toString()) {
            case "Texture":
               texture_ = AssetLibrary.getImageFromSet(String(param1.File),int(param1.Index));
               break;
            case "Mask":
               mask_ = AssetLibrary.getImageFromSet(String(param1.File),int(param1.Index));
               break;
            case "Effect":
               effectProps_ = new EffectProperties(param1);
               break;
            case "AnimatedTexture":
               animatedChar_ = AnimatedChars.getAnimatedChar(String(param1.File),int(param1.Index));
               _local2 = animatedChar_.imageFromAngle(0,AnimatedChar.STAND,0);
               texture_ = _local2.image_;
               mask_ = _local2.mask_;
               break;
            case "RemoteTexture":
               texture_ = AssetLibrary.getImageFromSet("lofiObj3",255);
               if(this.isUsingLocalTextures) {
                  _local3 = new RemoteTexture(param1.Id,param1.Instance,this.onRemoteTexture);
                  _local3.run();
                  if(!AssetLoader.currentXmlIsTesting) {
                     remoteTexturesUsed = true;
                  }
               }
               remoteTextureDir_ = !!param1.hasOwnProperty("Right")?int(AnimatedChar.RIGHT):int(AnimatedChar.DOWN);
               break;
            case "RandomTexture":
               randomTextureData_ = new Vector.<TextureData>();
               for each(_local4 in param1.children()) {
                  randomTextureData_.push(new LOEBUILD_ccd59f4c6a3fda7951ac27373fffd93a(_local4));
               }
               break;
            case "AltTexture":
               if(altTextures_ == null) {
                  altTextures_ = new Dictionary();
               }
               altTextures_[int(param1.@id)] = new LOEBUILD_ccd59f4c6a3fda7951ac27373fffd93a(param1);
         }
      }

      private function onRemoteTexture(param1:BitmapData) : void {
         if(param1.width > 16) {
            AnimatedChars.add("remoteTexture",param1,null,param1.width / 7,param1.height,param1.width,param1.height,remoteTextureDir_);
            animatedChar_ = AnimatedChars.getAnimatedChar("remoteTexture",0);
            texture_ = animatedChar_.imageFromAngle(0,AnimatedChar.STAND,0).image_;
         } else {
            texture_ = param1;
         }
      }
   }
}
