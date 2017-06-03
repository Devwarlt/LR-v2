package com.company.assembleegameclient.ui.panels.mediators {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_5e926ae2981199c65b99066bd9e14d29;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.Pet;
import com.company.assembleegameclient.ui.panels.InteractPanel;

import kabam.rotmg.core.model.MapModel;
import kabam.rotmg.pets.data.PetsModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class InteractPanelMediator extends Mediator {

      [Inject]
      public var view:InteractPanel;

      [Inject]
      public var mapModel:MapModel;

      [Inject]
      public var petsModel:PetsModel;

      private var currentInteractive:LOEBUILD_5e926ae2981199c65b99066bd9e14d29;

      public function InteractPanelMediator() {
         super();
      }

      override public function initialize() : void {
         this.view.requestInteractive = this.provideInteractive;
      }

      override public function destroy() : void {
         super.destroy();
      }

      public function provideInteractive() : LOEBUILD_5e926ae2981199c65b99066bd9e14d29 {
         if(!this.isMapNameYardName()) {
            return this.mapModel.currentInteractiveTarget;
         }
         if(this.doesNewPanelOverrideOld()) {
            this.currentInteractive = this.mapModel.currentInteractiveTarget;
         }
         return this.currentInteractive;
      }

      private function doesNewPanelOverrideOld() : Boolean {
         return this.mapModel.currentInteractiveTarget is Pet?Boolean(this.doShowPet()):true;
      }

      private function doShowPet() : Boolean {
         if(!this.currentInteractive && Boolean(this.isMapNameYardName())) {
            return true;
         }
         if(this.currentInteractive is Pet && Boolean(this.isMapNameYardName()) && Pet(this.mapModel.currentInteractiveTarget).vo.getID() != Pet(this.currentInteractive).vo.getID()) {
            return true;
         }
         return false;
      }

      private function isMapNameYardName() : Boolean {
         return this.view.gs_.map.isPetYard;
      }
   }
}
