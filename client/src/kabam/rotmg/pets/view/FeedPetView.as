package kabam.rotmg.pets.view {
import com.company.assembleegameclient.ui.LineBreakDesign;

import flash.events.Event;

import kabam.rotmg.pets.data.AbilityVO;
import kabam.rotmg.pets.data.PetRarityEnum;
import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.util.FeedFuseCostModel;
import kabam.rotmg.pets.util.PetsConstants;
import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.pets.view.components.DialogCloseButton;
import kabam.rotmg.pets.view.components.FameOrGoldBuyButtons;
import kabam.rotmg.pets.view.components.PetAbilityMeter;
import kabam.rotmg.pets.view.components.PetFeeder;
import kabam.rotmg.pets.view.components.PopupWindowBackground;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.view.SignalWaiter;

import org.osflash.signals.Signal;

public class FeedPetView extends PetInteractionView {

      private const background:PopupWindowBackground = PetsViewAssetFactory.returnWindowBackground(PetsConstants.WINDOW_BACKGROUND_WIDTH,PetsConstants.WINDOW_BACKGROUND_HEIGHT);

      private const titleTextfield:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTopAlignedTextfield(11776947,18,true);

      private const buttonBar:FameOrGoldBuyButtons = PetsViewAssetFactory.returnFameOrGoldButtonBar(TextKey.PET_FEEDER_BUTTON_BAR_PREFIX,PetsConstants.WINDOW_BACKGROUND_HEIGHT - 35);

      private const petFeeder:PetFeeder = PetsViewAssetFactory.returnPetFeeder();

      private const closeButton:DialogCloseButton = PetsViewAssetFactory.returnCloseButton(PetsConstants.WINDOW_BACKGROUND_WIDTH);

      private const abilityMeters:Vector.<PetAbilityMeter> = PetsViewAssetFactory.returnAbilityMeters();

      private const abilityMeterAnimating:Vector.<Boolean> = Vector.<Boolean>([false,false,false]);

      private const lineBreakDesign:LineBreakDesign = new LineBreakDesign(PetsConstants.WINDOW_BACKGROUND_WIDTH - 25,0);

      public const openPetPicker:Signal = new Signal();

      public const closed:Signal = new Signal();

      public var famePurchase:Signal;

      public var goldPurchase:Signal;

      public function FeedPetView() {
         super();
      }

      public function init() : void {
         this.titleTextfield.setStringBuilder(new LineBuilder().setParams(TextKey.PET_FEEDER_TITLE));
         this.petFeeder.openPetPicker.addOnce(this.onOpenPetPicker);
         this.famePurchase = this.buttonBar.fameButtonClicked;
         this.goldPurchase = this.buttonBar.goldButtonClicked;
         this.closeButton.clicked.add(this.onClosed);
         this.petFeeder.acceptableMatch.add(this.onAcceptableMatch);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         this.waitForTextChanged();
         this.addChildren();
         this.positionAssets();
      }

      public function resetFeed() : void {
         this.petFeeder.clearFood();
         this.petFeeder.updateHighlights();
      }

      private function onRemovedFromStage(param1:Event) : void {
         this.petFeeder.acceptableMatch.remove(this.onAcceptableMatch);
         this.closeButton.clicked.remove(this.onClosed);
      }

      private function onAcceptableMatch(param1:Boolean, param2:PetVO) : void {
         var _local3:PetRarityEnum = null;
         this.buttonBar.setDisabled(!param1);
         if(param2) {
            if(!param2.maxedAllAbilities()) {
               this.buttonBar.setPrefix(TextKey.PET_FEEDER_BUTTON_BAR_PREFIX);
               _local3 = PetRarityEnum.selectByValue(param2.getRarity());
               this.buttonBar.setGoldPrice(FeedFuseCostModel.getFeedGoldCost(_local3));
               this.buttonBar.setFamePrice(FeedFuseCostModel.getFeedFameCost(_local3));
            } else {
               this.buttonBar.clearFameAndGold();
               this.buttonBar.setPrefix(TextKey.PET_FULLY_MAXED);
            }
         } else {
            this.buttonBar.setPrefix(TextKey.PET_SELECT_PET);
         }
      }

      private function onClosed() : void {
         this.closed.dispatch();
      }

      private function onOpenPetPicker() : void {
         this.openPetPicker.dispatch();
      }

      public function destroy() : void {
         var _local1:PetAbilityMeter = null;
         for each(_local1 in this.abilityMeters) {
            _local1.animating.remove(this.onAnimating);
         }
         this.buttonBar.positioned.remove(this.positionButtonBar);
      }

      public function setAbilityMeterLabels(param1:Array, param2:int) : void {
         var _local4:AbilityVO = null;
         var _local5:PetAbilityMeter = null;
         var _local6:PetAbilityMeter = null;
         var _local3:int = 0;
         if(param1 == null) {
            for each(_local5 in this.abilityMeters) {
               _local5.visible = false;
            }
         }
         for each(_local4 in param1) {
            if(_local3 < this.abilityMeters.length) {
               _local6 = this.abilityMeters[_local3];
               _local6.index = _local3;
               _local6.max = param2;
               _local6.visible = true;
               _local6.initializeData(_local4);
               _local6.animating.add(this.onAnimating);
               _local3++;
            }
         }
      }

      private function onAnimating(param1:PetAbilityMeter, param2:Boolean) : void {
         this.abilityMeterAnimating[param1.index] = param2;
         var _local3:Boolean = this.hasAnimatingBars();
         this.buttonBar.setDisabled(_local3);
         this.petFeeder.setProcessing(_local3);
         !_local3 && this.petFeeder.clearFood();
      }

      private function hasAnimatingBars() : Boolean {
         var _local2:Boolean = false;
         var _local1:Boolean = false;
         for each(_local2 in this.abilityMeterAnimating) {
            if(_local2) {
               _local1 = true;
               break;
            }
         }
         return _local1;
      }

      private function addChildren() : void {
         var _local1:PetAbilityMeter = null;
         addChild(this.background);
         addChild(this.titleTextfield);
         addChild(this.buttonBar);
         addChild(this.petFeeder);
         addChild(this.closeButton);
         addChild(this.lineBreakDesign);
         for each(_local1 in this.abilityMeters) {
            _local1.visible = false;
            addChild(_local1);
         }
      }

      private function positionAssets() : void {
         positionThis();
         this.positionLinebreak();
         this.positionPetFeeder();
      }

      private function positionPetFeeder() : void {
         this.petFeeder.x = Math.round((PetsConstants.WINDOW_BACKGROUND_WIDTH - this.petFeeder.width) * 0.5);
      }

      private function waitForTextChanged() : void {
         var _local2:PetAbilityMeter = null;
         this.titleTextfield.textChanged.addOnce(this.positionTextField);
         var _local1:SignalWaiter = new SignalWaiter();
         for each(_local2 in this.abilityMeters) {
            _local1.push(_local2.positioned);
         }
         _local1.complete.addOnce(this.positionMeters);
         this.buttonBar.positioned.add(this.positionButtonBar);
      }

      private function positionTextField() : void {
         this.titleTextfield.y = 5;
         this.titleTextfield.x = (PetsConstants.WINDOW_BACKGROUND_WIDTH - this.titleTextfield.width) * 0.5;
      }

      private function positionMeters() : void {
         var _local2:PetAbilityMeter = null;
         var _local1:int = this.lineBreakDesign.y + 14;
         for each(_local2 in this.abilityMeters) {
            _local2.x = (PetsConstants.WINDOW_BACKGROUND_WIDTH - 227) * 0.5;
            _local2.y = _local1;
            _local1 = _local1 + (_local2.height + 10);
         }
      }

      private function positionLinebreak() : void {
         this.lineBreakDesign.x = (PetsConstants.WINDOW_BACKGROUND_WIDTH - this.lineBreakDesign.width + 8) * 0.5;
         this.lineBreakDesign.y = 152;
      }

      private function positionButtonBar() : void {
         this.buttonBar.x = (PetsConstants.WINDOW_BACKGROUND_WIDTH - this.buttonBar.width) / 2;
      }
   }
}
