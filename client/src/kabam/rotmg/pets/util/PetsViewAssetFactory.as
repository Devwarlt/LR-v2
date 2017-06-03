package kabam.rotmg.pets.util {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;
import com.company.assembleegameclient.ui.LineBreakDesign;
import com.company.util.BitmapUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.filters.DropShadowFilter;
import flash.text.TextFormatAlign;

import kabam.rotmg.pets.view.components.DialogCloseButton;
import kabam.rotmg.pets.view.components.FameOrGoldBuyButtons;
import kabam.rotmg.pets.view.components.FeedFuseArrow;
import kabam.rotmg.pets.view.components.FusionStrength;
import kabam.rotmg.pets.view.components.PetAbilityMeter;
import kabam.rotmg.pets.view.components.PetFeeder;
import kabam.rotmg.pets.view.components.PetFuser;
import kabam.rotmg.pets.view.components.PetsButtonBar;
import kabam.rotmg.pets.view.components.PopupWindowBackground;
import kabam.rotmg.pets.view.components.slot.FoodFeedFuseSlot;
import kabam.rotmg.pets.view.components.slot.PetFeedFuseSlot;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class PetsViewAssetFactory {

      public function PetsViewAssetFactory() {
         super();
      }

      public static function returnWindowBackground(param1:uint, param2:uint) : PopupWindowBackground {
         var _local3:PopupWindowBackground = new PopupWindowBackground();
         _local3.draw(param1,param2);
         _local3.divide(PopupWindowBackground.HORIZONTAL_DIVISION,PetsConstants.WINDOW_LINE_ONE_POS_Y);
         _local3.divide(PopupWindowBackground.HORIZONTAL_DIVISION,PetsConstants.WINDOW_LINE_TWO_POS_Y);
         return _local3;
      }

      public static function returnFuserWindowBackground() : PopupWindowBackground {
         var _local1:PopupWindowBackground = new PopupWindowBackground();
         _local1.draw(PetsConstants.WINDOW_BACKGROUND_WIDTH,PetsConstants.FUSER_WINDOW_BACKGROUND_HEIGHT);
         _local1.divide(PopupWindowBackground.HORIZONTAL_DIVISION,PetsConstants.WINDOW_LINE_ONE_POS_Y);
         _local1.divide(PopupWindowBackground.HORIZONTAL_DIVISION,PetsConstants.FUSER_WINDOW_LINE_TWO_POS_Y);
         return _local1;
      }

      public static function returnFameOrGoldButtonBar(param1:String, param2:uint) : FameOrGoldBuyButtons {
         var _local3:FameOrGoldBuyButtons = new FameOrGoldBuyButtons();
         _local3.y = param2;
         _local3.setPrefix(param1);
         return _local3;
      }

      public static function returnButtonBar() : PetsButtonBar {
         var _local1:PetsButtonBar = null;
         _local1 = new PetsButtonBar();
         _local1.y = PetsConstants.WINDOW_BACKGROUND_HEIGHT - 35;
         return _local1;
      }

      private static function returnAbilityMeter() : PetAbilityMeter {
         var _local1:PetAbilityMeter = null;
         _local1 = new PetAbilityMeter();
         _local1.y = PetsConstants.METER_START_POSITION_Y;
         return _local1;
      }

      public static function returnAbilityMeters() : Vector.<PetAbilityMeter> {
         return Vector.<PetAbilityMeter>([returnAbilityMeter(),returnAbilityMeter(),returnAbilityMeter()]);
      }

      public static function returnFuseDescriptionTextfield() : TextFieldDisplayConcrete {
         var _local1:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
         _local1.setStringBuilder(new LineBuilder().setParams(TextKey.PET_FUSER_DESCRIPTION));
         _local1.setTextWidth(PetsConstants.WINDOW_BACKGROUND_WIDTH - 20).setWordWrap(true).setHorizontalAlign(TextFormatAlign.CENTER).setSize(PetsConstants.MEDIUM_TEXT_SIZE).setColor(11776947);
         _local1.y = 42;
         return _local1;
      }

      public static function returnPetSlotTitle() : TextFieldDisplayConcrete {
         var _local1:TextFieldDisplayConcrete = null;
         _local1 = new TextFieldDisplayConcrete();
         _local1.setSize(PetsConstants.MEDIUM_TEXT_SIZE).setColor(11776947).setBold(true).setHorizontalAlign(TextFormatAlign.CENTER).setWordWrap(true).setTextWidth(100);
         _local1.filters = [new DropShadowFilter(0,0,0)];
         _local1.y = PetsConstants.PET_SLOT_TITLE_Y;
         return _local1;
      }

      public static function returnMediumCenteredTextfield(param1:uint, param2:uint) : TextFieldDisplayConcrete {
         var _local3:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
         _local3.setSize(PetsConstants.MEDIUM_TEXT_SIZE).setColor(param1).setBold(true).setHorizontalAlign(TextFormatAlign.CENTER).setWordWrap(true).setTextWidth(param2);
         return _local3;
      }

      public static function returnPetFeeder() : PetFeeder {
         var _local1:PetFeeder = new PetFeeder();
         _local1.y = PetsConstants.PET_WINDOW_TOOL_Y_POS;
         return _local1;
      }

      public static function returnPetFuser() : PetFuser {
         var _local1:PetFuser = new PetFuser();
         _local1.y = PetsConstants.PET_WINDOW_TOOL_Y_POS + 50;
         return _local1;
      }

      public static function returnPetFeederArrow() : FeedFuseArrow {
         var _local1:FeedFuseArrow = null;
         _local1 = new FeedFuseArrow();
         _local1.x = PetsConstants.PET_FEEDER_ARROW_X;
         _local1.y = PetsConstants.PET_FEEDER_ARROW_Y;
         return _local1;
      }

      public static function returnPetFeederRightSlot() : FoodFeedFuseSlot {
         var _local1:FoodFeedFuseSlot = new FoodFeedFuseSlot();
         _local1.x = PetsConstants.PET_FEEDER_ARROW_X + 35;
         _local1.hideOuterSlot(true);
         return _local1;
      }

      public static function returnPetFuserRightSlot() : PetFeedFuseSlot {
         var _local1:PetFeedFuseSlot = null;
         _local1 = new PetFeedFuseSlot();
         _local1.x = PetsConstants.PET_FEEDER_ARROW_X + 35;
         _local1.hideOuterSlot(true);
         _local1.showFamily = true;
         return _local1;
      }

      public static function returnPetSlotShape(param1:uint, param2:uint, param3:int, param4:Boolean, param5:Boolean, param6:int = 2) : Shape {
         var _local7:Shape = null;
         _local7 = new Shape();
         param4 && _local7.graphics.beginFill(4605510,1);
         param5 && _local7.graphics.lineStyle(param6,param2);
         _local7.graphics.drawRoundRect(0,param3,param1,param1,16,16);
         _local7.x = (100 - param1) * 0.5;
         return _local7;
      }

      public static function returnCloseButton(param1:int) : DialogCloseButton {
         var _local2:DialogCloseButton = new DialogCloseButton();
         _local2.y = 4;
         _local2.x = param1 - _local2.width - 5;
         return _local2;
      }

      public static function returnTooltipLineBreak() : LineBreakDesign {
         var _local1:LineBreakDesign = null;
         _local1 = new LineBreakDesign(173,0);
         _local1.x = 5;
         _local1.y = 64;
         return _local1;
      }

      public static function returnBitmap(param1:uint, param2:uint = 80) : Bitmap {
         return new Bitmap(LOEBUILD_efda783509bc93eea698457c87bbee3f.getRedrawnTextureFromType(param1,param2,true));
      }

      public static function returnInteractionBitmap() : Bitmap {
         return getBitmapForItem(6466);
      }

      public static function returnCaretakerBitmap(param1:uint) : Bitmap {
         return new Bitmap(LOEBUILD_efda783509bc93eea698457c87bbee3f.getRedrawnTextureFromType(param1,80,true));
      }

      private static function getBitmapForItem(param1:uint) : Bitmap {
         var _local2:Bitmap = new Bitmap();
         var _local3:XML = LOEBUILD_efda783509bc93eea698457c87bbee3f.xmlLibrary_[param1];
         var _local4:int = 5;
         if(_local3.hasOwnProperty("ScaleValue")) {
            _local4 = _local3.ScaleValue;
         }
         var _local5:BitmapData = LOEBUILD_efda783509bc93eea698457c87bbee3f.getRedrawnTextureFromType(param1,80,true,true,_local4);
         _local5 = BitmapUtil.cropToBitmapData(_local5,4,4,_local5.width - 8,_local5.height - 8);
         _local2 = new Bitmap(_local5);
         return _local2;
      }

      public static function returnFusionStrength() : FusionStrength {
         var _local1:FusionStrength = new FusionStrength();
         _local1.y = PetsConstants.FUSION_STRENGTH_Y_POS;
         _local1.x = (PetsConstants.WINDOW_BACKGROUND_WIDTH - _local1.width) * 0.5;
         return _local1;
      }

      public static function returnTopAlignedTextfield(param1:int, param2:int, param3:Boolean, param4:Boolean = false) : TextFieldDisplayConcrete {
         var _local5:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
         _local5.setSize(param2).setColor(param1).setBold(param3);
         _local5.filters = !!param4?[new DropShadowFilter(0,0,0)]:[];
         return _local5;
      }

      public static function returnTextfield(param1:int, param2:int, param3:Boolean, param4:Boolean = false) : TextFieldDisplayConcrete {
         var _local5:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
         _local5.setSize(param2).setColor(param1).setBold(param3);
         _local5.setVerticalAlign(TextFieldDisplayConcrete.BOTTOM);
         _local5.filters = !!param4?[new DropShadowFilter(0,0,0)]:[];
         return _local5;
      }

      public static function returnYardUpgradeWindowBackground(param1:uint, param2:uint) : PopupWindowBackground {
         var _local3:PopupWindowBackground = new PopupWindowBackground();
         _local3.draw(param1,param2);
         _local3.divide(PopupWindowBackground.HORIZONTAL_DIVISION,30);
         _local3.divide(PopupWindowBackground.HORIZONTAL_DIVISION,212);
         _local3.divide(PopupWindowBackground.HORIZONTAL_DIVISION,349);
         return _local3;
      }

      public static function returnEggHatchWindowBackground(param1:uint, param2:uint) : PopupWindowBackground {
         var _local3:PopupWindowBackground = new PopupWindowBackground();
         _local3.draw(param1,param2);
         _local3.divide(PopupWindowBackground.HORIZONTAL_DIVISION,30);
         _local3.divide(PopupWindowBackground.HORIZONTAL_DIVISION,206);
         return _local3;
      }
   }
}
