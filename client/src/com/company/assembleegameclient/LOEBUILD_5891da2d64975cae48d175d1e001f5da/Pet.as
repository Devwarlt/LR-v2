package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da {
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.GameSprite;
import com.company.assembleegameclient.ui.panels.Panel;
import com.company.assembleegameclient.ui.tooltip.TextToolTip;
import com.company.assembleegameclient.ui.tooltip.ToolTip;
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.AnimatedChars;
import com.company.assembleegameclient.util.MaskedImage;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.game.signals.TextPanelMessageUpdateSignal;
import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.data.PetsModel;
import kabam.rotmg.pets.view.petPanel.PetPanel;
import kabam.rotmg.text.model.TextKey;

public class Pet extends GameObject implements LOEBUILD_5e926ae2981199c65b99066bd9e14d29 {

      private var textPanelUpdateSignal:TextPanelMessageUpdateSignal;

      public var vo:PetVO;

      public var skin:AnimatedChar;

      public var defaultSkin:AnimatedChar;

      public var skinId:int;

      public var isDefaultAnimatedChar:Boolean = false;

      private var petsModel:PetsModel;

      public function Pet(param1:XML) {
         super(param1);
         isInteractive_ = true;
         this.textPanelUpdateSignal = StaticInjectorContext.getInjector().getInstance(TextPanelMessageUpdateSignal);
         this.petsModel = StaticInjectorContext.getInjector().getInstance(PetsModel);
         this.petsModel.getActivePet();
      }

      public function getTooltip() : ToolTip {
         var _local1:ToolTip = new TextToolTip(3552822,10197915,TextKey.CLOSEDGIFTCHEST_TITLE,TextKey.TEXTPANEL_GIFTCHESTISEMPTY,200);
         return _local1;
      }

      public function getPanel(param1:GameSprite) : Panel {
         return new PetPanel(param1,this.vo);
      }

      public function setSkin(param1:int) : void {
         var _local5:MaskedImage = null;
         this.skinId = param1;
         var _local2:XML = LOEBUILD_efda783509bc93eea698457c87bbee3f.getXMLfromId(LOEBUILD_efda783509bc93eea698457c87bbee3f.getIdFromType(param1));
         var _local3:String = _local2.AnimatedTexture.File;
         var _local4:int = _local2.AnimatedTexture.Index;
         if(this.skin == null) {
            this.isDefaultAnimatedChar = true;
            this.skin = AnimatedChars.getAnimatedChar(_local3,_local4);
            this.defaultSkin = this.skin;
         } else {
            this.skin = AnimatedChars.getAnimatedChar(_local3,_local4);
         }
         this.isDefaultAnimatedChar = this.skin == this.defaultSkin;
         _local5 = this.skin.imageFromAngle(0,AnimatedChar.STAND,0);
         animatedChar_ = this.skin;
         texture_ = _local5.image_;
         mask_ = _local5.mask_;
      }

      public function setDefaultSkin() : void {
         var _local1:MaskedImage = null;
         this.skinId = -1;
         if(this.defaultSkin == null) {
            return;
         }
         _local1 = this.defaultSkin.imageFromAngle(0,AnimatedChar.STAND,0);
         this.isDefaultAnimatedChar = true;
         animatedChar_ = this.defaultSkin;
         texture_ = _local1.image_;
         mask_ = _local1.mask_;
      }
   }
}
