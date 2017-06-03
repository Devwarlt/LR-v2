package com.company.assembleegameclient.LOEBUILD_1f4c42c309fe6bc45253d598cfdf9b99 {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.AnimatedChars;
import com.company.assembleegameclient.util.MaskedImage;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
import com.company.util.CachingColorTransformer;

import flash.display.BitmapData;
import flash.geom.ColorTransform;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.data.PetsModel;

public class LOEBUILD_7ebef6bdf3535c86294f666e62e89578 {

      public var charXML_:XML;

      public var name_:String = null;

      private var pet:PetVO;

      public function LOEBUILD_7ebef6bdf3535c86294f666e62e89578(param1:XML, param2:String) {
         var _local3:XML = null;
         var _local4:int = 0;
         var _local5:PetVO = null;
         super();
         this.charXML_ = param1;
         this.name_ = param2;
         if(this.charXML_.hasOwnProperty("Pet")) {
            _local3 = new XML(this.charXML_.Pet);
            _local4 = _local3.@instanceId;
            _local5 = StaticInjectorContext.getInjector().getInstance(PetsModel).getPetVO(_local4);
            _local5.apply(_local3);
            this.setPetVO(_local5);
         }
      }

      public static function getImage(param1:LOEBUILD_7ebef6bdf3535c86294f666e62e89578, param2:XML, param3:int, param4:int, param5:Number, param6:Boolean, param7:Boolean) : BitmapData {
         var _local8:AnimatedChar = AnimatedChars.getAnimatedChar(String(param2.AnimatedTexture.File),int(param2.AnimatedTexture.Index));
         var _local9:MaskedImage = _local8.imageFromDir(param3,param4,param5);
         var _local10:int = param1 != null?int(param1.tex1()):int(null);
         var _local11:int = param1 != null?int(param1.tex2()):int(null);
         var _local12:BitmapData = TextureRedrawer.resize(_local9.image_,_local9.mask_,100,false,_local10,_local11);
         _local12 = GlowRedrawer.outlineGlow(_local12,0);
         if(!param6) {
            _local12 = CachingColorTransformer.transformBitmapData(_local12,new ColorTransform(0,0,0,0.5,0,0,0,0));
         } else if(!param7) {
            _local12 = CachingColorTransformer.transformBitmapData(_local12,new ColorTransform(0.75,0.75,0.75,1,0,0,0,0));
         }
         return _local12;
      }

      public static function compare(param1:LOEBUILD_7ebef6bdf3535c86294f666e62e89578, param2:LOEBUILD_7ebef6bdf3535c86294f666e62e89578) : Number {
         var _local3:Number = !!LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.charIdUseMap.hasOwnProperty(param1.charId())?Number(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.charIdUseMap[param1.charId()]):Number(0);
         var _local4:Number = !!LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.charIdUseMap.hasOwnProperty(param2.charId())?Number(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.charIdUseMap[param2.charId()]):Number(0);
         if(_local3 != _local4) {
            return _local4 - _local3;
         }
         return param2.xp() - param1.xp();
      }

      public function charId() : int {
         return int(this.charXML_.@id);
      }

      public function name() : String {
         return this.name_;
      }

      public function objectType() : int {
         return int(this.charXML_.ObjectType);
      }

      public function skinType() : int {
         return int(this.charXML_.Texture);
      }

      public function level() : int {
         return int(this.charXML_.Level);
      }

      public function tex1() : int {
         return int(this.charXML_.Tex1);
      }

      public function tex2() : int {
         return int(this.charXML_.Tex2);
      }

      public function xp() : int {
         return int(this.charXML_.Exp);
      }

      public function fame() : int {
         return int(this.charXML_.CurrentFame);
      }

      public function displayId() : String {
         return LOEBUILD_efda783509bc93eea698457c87bbee3f.typeToDisplayId_[this.objectType()];
      }

      public function getPetVO() : PetVO {
         return this.pet;
      }

      public function setPetVO(param1:PetVO) : void {
         this.pet = param1;
      }
   }
}
