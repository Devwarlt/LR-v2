package com.company.assembleegameclient.screens.charrects {
import com.company.assembleegameclient.LOEBUILD_1f4c42c309fe6bc45253d598cfdf9b99.LOEBUILD_7ebef6bdf3535c86294f666e62e89578;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.FameUtil;
import com.company.util.BitmapUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;

import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class CreateNewCharacterRect extends CharacterRect {

      private var bitmap_:Bitmap;

      public function CreateNewCharacterRect(param1:PlayerModel) {
         var _local2:int = 0;
         super();
         super.className = new LineBuilder().setParams(TextKey.CREATE_NEW_CHARACTER_RECT_NEW_CHARACTER);
         super.color = 2368548;
         super.overColor = 7829367;
         super.init();
         this.makeBitmap();
         if(param1.getNumStars() != FameUtil.maxStars()) {
            _local2 = FameUtil.maxStars() - param1.getNumStars();
            super.makeTaglineIcon();
            super.makeTaglineText(new LineBuilder().setParams(TextKey.CREATE_NEW_CHARACTER_RECT_TAGLINE,{"remainingStars":_local2}));
            taglineText.x = taglineText.x + taglineIcon.width;
         }
      }

      public function makeBitmap() : void {
         var _local1:XML = LOEBUILD_efda783509bc93eea698457c87bbee3f.playerChars_[int(LOEBUILD_efda783509bc93eea698457c87bbee3f.playerChars_.length * Math.random())];
         var _local2:BitmapData = LOEBUILD_7ebef6bdf3535c86294f666e62e89578.getImage(null,_local1,AnimatedChar.RIGHT,AnimatedChar.STAND,0,false,false);
         _local2 = BitmapUtil.cropToBitmapData(_local2,6,6,_local2.width - 12,_local2.height - 6);
         this.bitmap_ = new Bitmap();
         this.bitmap_.bitmapData = _local2;
         this.bitmap_.x = CharacterRectConstants.ICON_POS_X;
         this.bitmap_.y = CharacterRectConstants.ICON_POS_Y;
         selectContainer.addChild(this.bitmap_);
      }
   }
}
