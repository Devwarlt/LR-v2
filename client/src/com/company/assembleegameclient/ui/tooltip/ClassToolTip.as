package com.company.assembleegameclient.ui.tooltip {
import com.company.assembleegameclient.LOEBUILD_1f4c42c309fe6bc45253d598cfdf9b99.LOEBUILD_9ef2cbbbd6e1617e4401a08c93ad0f9c;
import com.company.assembleegameclient.LOEBUILD_1f4c42c309fe6bc45253d598cfdf9b99.LOEBUILOD_1839b10431d757564a37f7352035160a;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;
import com.company.assembleegameclient.ui.LineBreakDesign;
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.AnimatedChars;
import com.company.assembleegameclient.util.FameUtil;
import com.company.assembleegameclient.util.MaskedImage;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.CachingColorTransformer;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.filters.DropShadowFilter;
import flash.geom.ColorTransform;

import kabam.rotmg.assets.services.IconFactory;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class ClassToolTip extends ToolTip {

      private var portrait_:Bitmap;

      private var nameText_:TextFieldDisplayConcrete;

      private var descriptionText_:TextFieldDisplayConcrete;

      private var lineBreak_:LineBreakDesign;

      private var bestLevel_:TextFieldDisplayConcrete;

      private var toUnlockText_:TextFieldDisplayConcrete;

      private var unlockText_:TextFieldDisplayConcrete;

      private var nextClassQuest_:TextFieldDisplayConcrete;

      private var costText_:TextFieldDisplayConcrete;

      private var coinBitmap_:Bitmap;

      private var showUnlockRequirements:Boolean;

      public function ClassToolTip(param1:XML, param2:PlayerModel, param3:LOEBUILD_9ef2cbbbd6e1617e4401a08c93ad0f9c) {
         var _local8:AppendingLineBuilder = null;
         var _local9:XML = null;
         var _local10:BitmapData = null;
         var _local11:int = 0;
         var _local12:int = 0;
         var _local13:int = 0;
         var _local14:int = 0;
         super(3552822,1,16777215,1);
         var _local4:AnimatedChar = AnimatedChars.getAnimatedChar(String(param1.AnimatedTexture.File),int(param1.AnimatedTexture.Index));
         var _local5:MaskedImage = _local4.imageFromDir(AnimatedChar.RIGHT,AnimatedChar.STAND,0);
         var _local6:int = 4 / _local5.width() * 100;
         var _local7:BitmapData = TextureRedrawer.redraw(_local5.image_,_local6,true,0);
         this.showUnlockRequirements = this.shouldShowUnlockRequirements(param2,param1);
         if(this.showUnlockRequirements) {
            _local7 = CachingColorTransformer.transformBitmapData(_local7,new ColorTransform(0,0,0,0.5,0,0,0,0));
         }
         this.portrait_ = new Bitmap();
         this.portrait_.bitmapData = _local7;
         this.portrait_.x = -4;
         this.portrait_.y = -4;
         addChild(this.portrait_);
         this.nameText_ = new TextFieldDisplayConcrete().setSize(13).setColor(11776947);
         this.nameText_.setBold(true);
         this.nameText_.setStringBuilder(new LineBuilder().setParams(param1.DisplayId));
         this.nameText_.filters = [new DropShadowFilter(0,0,0)];
         waiter.push(this.nameText_.textChanged);
         addChild(this.nameText_);
         this.descriptionText_ = new TextFieldDisplayConcrete().setSize(13).setColor(11776947).setWordWrap(true).setMultiLine(true).setTextWidth(174);
         this.descriptionText_.setStringBuilder(new LineBuilder().setParams(param1.Description));
         this.descriptionText_.filters = [new DropShadowFilter(0,0,0)];
         waiter.push(this.descriptionText_.textChanged);
         addChild(this.descriptionText_);
         this.lineBreak_ = new LineBreakDesign(100,1842204);
         addChild(this.lineBreak_);
         if(this.showUnlockRequirements) {
            this.toUnlockText_ = new TextFieldDisplayConcrete().setSize(13).setColor(11776947).setTextWidth(174).setBold(true);
            this.toUnlockText_.setStringBuilder(new LineBuilder().setParams(TextKey.TO_UNLOCK));
            this.toUnlockText_.filters = [new DropShadowFilter(0,0,0)];
            waiter.push(this.toUnlockText_.textChanged);
            addChild(this.toUnlockText_);
            this.unlockText_ = new TextFieldDisplayConcrete().setSize(13).setColor(16549442).setTextWidth(174).setWordWrap(false).setMultiLine(true);
            _local8 = new AppendingLineBuilder();
            for each(_local9 in param1.UnlockLevel) {
               _local11 = LOEBUILD_efda783509bc93eea698457c87bbee3f.idToType_[_local9.toString()];
               _local12 = int(_local9.@level);
               if(param2.getBestLevel(_local11) < int(_local9.@level)) {
                  _local8.pushParams(TextKey.TO_UNLOCK_REACH_LEVEL,{
                     "unlockLevel":_local12,
                     "typeToDisplay":LOEBUILD_efda783509bc93eea698457c87bbee3f.typeToDisplayId_[_local11]
                  });
               }
            }
            this.unlockText_.setStringBuilder(_local8);
            this.unlockText_.filters = [new DropShadowFilter(0,0,0)];
            waiter.push(this.unlockText_.textChanged);
            addChild(this.unlockText_);
            this.costText_ = new TextFieldDisplayConcrete().setSize(13).setColor(65280);
            this.costText_.setStringBuilder(new LineBuilder().setParams(TextKey.OR_BUY_NOW,{"unlockCost":param1.UnlockCost}));
            this.costText_.filters = [new DropShadowFilter(0,0,0)];
            waiter.push(this.costText_.textChanged);
            addChild(this.costText_);
            _local10 = IconFactory.makeCoin();
            this.coinBitmap_ = new Bitmap(_local10);
            addChild(this.coinBitmap_);
         } else {
            _local13 = param3 == null?0:int(param3.numStars());
            this.bestLevel_ = new TextFieldDisplayConcrete().setSize(14).setColor(6206769).setMultiLine(true);
            this.bestLevel_.setStringBuilder(new LineBuilder().setParams(TextKey.BEST_LEVEL_STATS,{
               "numStars":_local13,
               "bestLevel":(param3 != null?param3.bestLevel():0),
               "fame":(param3 != null?param3.bestFame():0)
            }));
            this.bestLevel_.filters = [new DropShadowFilter(0,0,0)];
            waiter.push(this.bestLevel_.textChanged);
            addChild(this.bestLevel_);
            _local14 = FameUtil.nextStarFame(param3 == null?0:int(param3.bestFame()),0);
            if(_local14 > 0) {
               this.nextClassQuest_ = new TextFieldDisplayConcrete().setSize(13).setColor(16549442).setTextWidth(160).setMultiLine(true).setWordWrap(true);
               this.nextClassQuest_.setStringBuilder(new LineBuilder().setParams(TextKey.NEXT_CLASS_QUEST,{
                  "nextStarFame":_local14,
                  "typeToDisplay":param1.DisplayId
               }));
               this.nextClassQuest_.filters = [new DropShadowFilter(0,0,0)];
               waiter.push(this.nextClassQuest_.textChanged);
               addChild(this.nextClassQuest_);
            }
         }
      }

      override protected function alignUI() : void {
         this.nameText_.x = 32;
         this.nameText_.y = 6;
         this.descriptionText_.x = 8;
         this.descriptionText_.y = 40;
         this.lineBreak_.x = 6;
         this.lineBreak_.y = height;
         if(this.showUnlockRequirements) {
            this.toUnlockText_.x = 8;
            this.toUnlockText_.y = height - 2;
            this.unlockText_.x = 12;
            this.unlockText_.y = height - 4;
            this.costText_.x = 12;
            this.costText_.y = height - 4;
            this.coinBitmap_.y = this.costText_.y - 2;
            this.coinBitmap_.x = this.costText_.x + this.costText_.getBounds(this.costText_).width + 4;
         } else {
            this.bestLevel_.x = 8;
            this.bestLevel_.y = height - 2;
            if(this.nextClassQuest_) {
               this.nextClassQuest_.x = 8;
               this.nextClassQuest_.y = height - 2;
            }
         }
         this.draw();
         position();
      }

      private function shouldShowUnlockRequirements(param1:PlayerModel, param2:XML) : Boolean {
         var _local3:Boolean = param1.isClassAvailability(String(param2.@id),LOEBUILOD_1839b10431d757564a37f7352035160a.UNRESTRICTED);
         var _local4:Boolean = param1.isLevelRequirementsMet(int(param2.@type));
         return !_local3 && !_local4;
      }

      override public function draw() : void {
         this.lineBreak_.setWidthColor(width - 10,1842204);
         super.draw();
      }
   }
}
