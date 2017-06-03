package kabam.rotmg.pets.view.components {
import flash.display.Sprite;
import flash.events.Event;
import flash.filters.DropShadowFilter;

import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.pets.data.AbilityVO;
import kabam.rotmg.pets.util.PetsAbilityLevelHelper;
import kabam.rotmg.pets.util.PetsConstants;
import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.tooltips.HoverTooltipDelegate;
import kabam.rotmg.tooltips.TooltipAble;
import kabam.rotmg.ui.view.SignalWaiter;

import org.osflash.signals.Signal;

public class PetAbilityMeter extends Sprite implements TooltipAble {

      public const animating:Signal = new Signal(PetAbilityMeter,Boolean);

      private const labelTextfield:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTopAlignedTextfield(11776947,14,true,true);

      private const levelTextfield:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTopAlignedTextfield(11776947,14,true,true);

      private const abilityBar:AnimatedAbilityBar = new AnimatedAbilityBar(PetsConstants.PET_ABILITY_BAR_WIDTH,PetsConstants.PET_ABILITY_BAR_HEIGHT);

      private var unlocked:Boolean = true;

      private var pointsShown:int = 0;

      private var levelShown:int = 0;

      private var pointsLeftToAdd:Number = 0;

      public var positioned:Signal;

      public var max:int;

      public var index:int;

      private var tooltipDelegate:HoverTooltipDelegate;

      public function PetAbilityMeter() {
         this.positioned = new Signal();
         this.tooltipDelegate = new HoverTooltipDelegate();
         super();
         this.abilityBar.animating.add(this.onAnimatingBar);
         this.waitForTextChanged();
         this.addChildren();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         this.tooltipDelegate.setDisplayObject(this);
      }

      private function onRemovedFromStage(param1:Event) : void {
         this.abilityBar.animating.remove(this.onAnimatingBar);
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }

      public function initializeData(param1:AbilityVO) : void {
         var _local2:int = 0;
         var _local3:int = 0;
         this.pointsShown = param1.points;
         this.levelShown = param1.level;
         this.setAbilityLabel(param1.name);
         this.setUnlocked(param1.getUnlocked());
         this.setLevelLabel(!!this.unlocked?int(param1.level):0);
         this.onAnimatingBar(false);
         this.tooltipDelegate.tooltip = new PetAbilityTooltip(param1);
         if(this.unlocked) {
            _local2 = Math.max(0,PetsAbilityLevelHelper.getCurrentPointsForLevel(param1.points,param1.level));
            _local3 = PetsAbilityLevelHelper.getAbilityPointsforLevel(param1.level);
            _local2 = param1.level >= this.max?int(_local3):int(_local2);
            this.setAbilityBar(_local2,_local3);
         }
         param1.updated.add(this.updateData);
      }

      private function updateData(param1:AbilityVO) : void {
         var _local2:Number = NaN;
         this.setUnlocked(param1.getUnlocked());
         if(param1.points > this.pointsShown && Boolean(this.unlocked)) {
            this.pointsShown = param1.points;
            this.pointsLeftToAdd = PetsAbilityLevelHelper.getCurrentPointsForLevel(param1.points,this.levelShown);
            _local2 = PetsAbilityLevelHelper.getAbilityPointsforLevel(this.levelShown);
            if(_local2 != 0 && this.pointsLeftToAdd > _local2) {
               this.pointsLeftToAdd = this.pointsLeftToAdd - _local2;
               this.abilityBar.filledUp.add(this.onChainedFill);
               this.abilityBar.fill();
               this.onAnimatingBar(true);
            } else {
               this.setAbilityBar(this.pointsLeftToAdd,_local2);
            }
         }
      }

      private function onChainedFill() : void {
         var _local2:Number = NaN;
         var _local1:Boolean = false;
         if(!_local1) {
            this.levelShown++;
            this.setLevelLabel(this.levelShown,true);
            _local2 = PetsAbilityLevelHelper.getAbilityPointsforLevel(this.levelShown);
            if(this.pointsLeftToAdd > _local2) {
               this.abilityBar.reset();
               this.pointsLeftToAdd = this.pointsLeftToAdd - _local2;
               this.abilityBar.fill();
            } else {
               this.abilityBar.filledUp.remove(this.onChainedFill);
               if(this.levelShown >= this.max) {
                  this.abilityBar.handleTweenComplete(null);
                  this.pointsLeftToAdd = 0;
               } else {
                  this.abilityBar.reset();
                  this.setAbilityBar(this.pointsLeftToAdd,_local2);
               }
            }
         }
      }

      public function setAbilityLabel(param1:String) : void {
         this.levelTextfield.setStringBuilder(new LineBuilder().setParams(param1));
      }

      public function setLevelLabel(param1:int, param2:Boolean = false) : void {
         var _local3:String = param1 >= this.max?TextKey.PET_ABILITY_LEVEL_MAX:TextKey.ABILITY_BAR_LEVEL_LABEL;
         this.labelTextfield.setColor(!!param2?uint(1572859):param1 >= this.max?uint(PetsConstants.COLOR_GREEN_TEXT_HIGHLIGHT):uint(11776947));
         this.labelTextfield.setStringBuilder(new LineBuilder().setParams(_local3,{"level":param1.toString()}));
         this.labelTextfield.textChanged.addOnce(this.positionLabelText);
      }

      public function setAbilityBar(param1:int, param2:int) : void {
         this.abilityBar.setMaxPointValue(param2);
         this.abilityBar.setCurrentPointValue(param1);
      }

      public function setUnlocked(param1:Boolean) : void {
         var _local2:int = 0;
         var _local3:Array = null;
         if(this.unlocked != param1) {
            this.unlocked = param1;
            _local2 = !!param1?11776947:5658198;
            _local3 = !!param1?[new DropShadowFilter(0,0,0)]:[];
            this.levelTextfield.setColor(_local2);
            this.levelTextfield.filters = _local3;
            this.labelTextfield.visible = param1;
         }
      }

      private function addChildren() : void {
         addChild(this.levelTextfield);
         addChild(this.labelTextfield);
         addChild(this.abilityBar);
      }

      private function waitForTextChanged() : void {
         var _local1:SignalWaiter = new SignalWaiter();
         _local1.push(this.labelTextfield.textChanged);
         _local1.push(this.levelTextfield.textChanged);
         _local1.complete.addOnce(this.positionTextField);
      }

      private function positionLabelText() : void {
         this.abilityBar.y = 21;
         this.labelTextfield.x = PetsConstants.PET_ABILITY_BAR_WIDTH - this.labelTextfield.width;
      }

      private function positionTextField() : void {
         this.positionLabelText();
         this.positioned.dispatch();
      }

      private function onAnimatingBar(param1:Boolean) : void {
         this.labelTextfield.setColor(!!param1?uint(1572859):this.levelShown >= this.max?uint(PetsConstants.COLOR_GREEN_TEXT_HIGHLIGHT):uint(11776947));
         this.levelTextfield.setColor(!!param1?uint(1572859):this.levelShown >= 110?uint(PetsConstants.COLOR_GREEN_TEXT_HIGHLIGHT):uint(11776947));
         if(!param1 && this.levelShown >= 110) {
            this.abilityBar.setBarColor(PetsConstants.COLOR_GREEN_TEXT_HIGHLIGHT);
         }
         this.animating.dispatch(this,param1);
      }

      public function setShowToolTipSignal(param1:ShowTooltipSignal) : void {
         this.tooltipDelegate.setShowToolTipSignal(param1);
      }

      public function getShowToolTip() : ShowTooltipSignal {
         return this.tooltipDelegate.getShowToolTip();
      }

      public function setHideToolTipsSignal(param1:HideTooltipsSignal) : void {
         this.tooltipDelegate.setHideToolTipsSignal(param1);
      }

      public function getHideToolTips() : HideTooltipsSignal {
         return this.tooltipDelegate.getHideToolTips();
      }
   }
}
