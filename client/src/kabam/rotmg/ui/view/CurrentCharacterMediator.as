package kabam.rotmg.ui.view {
import com.company.assembleegameclient.LOEBUILD_1f4c42c309fe6bc45253d598cfdf9b99.LOEBUILD_7ebef6bdf3535c86294f666e62e89578;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;
import com.company.assembleegameclient.screens.NewCharacterScreen;
import com.company.util.MoreDateUtil;

import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.ClassesModel;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.core.service.TrackingData;
import kabam.rotmg.core.signals.SetScreenSignal;
import kabam.rotmg.core.signals.TrackEventSignal;
import kabam.rotmg.core.signals.TrackPageViewSignal;
import kabam.rotmg.game.model.GameInitData;
import kabam.rotmg.game.signals.PlayGameSignal;
import kabam.rotmg.packages.control.BeginnersPackageAvailableSignal;
import kabam.rotmg.packages.control.InitPackagesSignal;
import kabam.rotmg.packages.control.PackageAvailableSignal;
import kabam.rotmg.promotions.model.BeginnersPackageModel;
import kabam.rotmg.ui.signals.ChooseNameSignal;
import kabam.rotmg.ui.signals.NameChangedSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class CurrentCharacterMediator extends Mediator {

      [Inject]
      public var view:CharacterSelectionAndNewsScreen;

      [Inject]
      public var playerModel:PlayerModel;

      [Inject]
      public var classesModel:ClassesModel;

      [Inject]
      public var track:TrackEventSignal;

      [Inject]
      public var setScreen:SetScreenSignal;

      [Inject]
      public var playGame:PlayGameSignal;

      [Inject]
      public var chooseName:ChooseNameSignal;

      [Inject]
      public var nameChanged:NameChangedSignal;

      [Inject]
      public var trackPage:TrackPageViewSignal;

      [Inject]
      public var initPackages:InitPackagesSignal;

      [Inject]
      public var beginnersPackageAvailable:BeginnersPackageAvailableSignal;

      [Inject]
      public var packageAvailable:PackageAvailableSignal;

      [Inject]
      public var beginnerModel:BeginnersPackageModel;

      public function CurrentCharacterMediator() {
         super();
      }

      override public function initialize() : void {
         this.trackSomething();
         this.view.initialize(this.playerModel);
         this.view.close.add(this.onClose);
         this.view.newCharacter.add(this.onNewCharacter);
         this.view.showClasses.add(this.onNewCharacter);
         this.view.chooseName.add(this.onChooseName);
         this.view.playGame.add(this.onPlayGame);
         this.trackPage.dispatch("/currentCharScreen");
         this.nameChanged.add(this.onNameChanged);
         this.beginnersPackageAvailable.add(this.onBeginner);
         this.packageAvailable.add(this.onPackage);
         this.initPackages.dispatch();
      }

      private function onPackage() : void {
         this.view.showPackageButton();
      }

      private function onBeginner() : void {
         this.view.showBeginnersOfferButton();
      }

      override public function destroy() : void {
         this.nameChanged.remove(this.onNameChanged);
         this.beginnersPackageAvailable.remove(this.onBeginner);
         this.view.close.remove(this.onClose);
         this.view.newCharacter.remove(this.onNewCharacter);
         this.view.chooseName.remove(this.onChooseName);
         this.view.showClasses.remove(this.onNewCharacter);
         this.view.playGame.remove(this.onPlayGame);
      }

      private function onNameChanged(param1:String) : void {
         this.view.setName(param1);
      }

      private function trackSomething() : void {
         var _local2:TrackingData = null;
         var _local1:String = MoreDateUtil.getDayStringInPT();
         if(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.lastDailyAnalytics != _local1) {
            _local2 = new TrackingData();
            _local2.category = "joinDate";
            _local2.action = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.joinDate;
            this.track.dispatch(_local2);
            LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.lastDailyAnalytics = _local1;
            LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.save();
         }
      }

      private function onNewCharacter() : void {
         this.setScreen.dispatch(new NewCharacterScreen());
      }

      private function onClose() : void {
         this.setScreen.dispatch(new TitleView());
      }

      private function onChooseName() : void {
         this.chooseName.dispatch();
      }

      private function onPlayGame() : void {
         var _local1:LOEBUILD_7ebef6bdf3535c86294f666e62e89578 = this.playerModel.getCharacterByIndex(0);
         this.playerModel.currentCharId = _local1.charId();
         var _local2:CharacterClass = this.classesModel.getCharacterClass(_local1.objectType());
         _local2.setIsSelected(true);
         _local2.skins.getSkin(_local1.skinType()).setIsSelected(true);
         var _local3:TrackingData = new TrackingData();
         _local3.category = "character";
         _local3.action = "select";
         _local3.label = _local1.displayId();
         _local3.value = _local1.level();
         this.track.dispatch(_local3);
         var _local4:GameInitData = new GameInitData();
         _local4.createCharacter = false;
         _local4.charId = _local1.charId();
         _local4.isNewGame = true;
         this.playGame.dispatch(_local4);
      }
   }
}
