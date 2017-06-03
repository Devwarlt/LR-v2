package kabam.rotmg.ui.controller {
import com.company.assembleegameclient.map.LOEBUILD_8640380935243b4a9c3cbd5e4ae3bef6.LOEBUILD_4a59873dd40437adf7708a4430a17690;

import kabam.rotmg.core.view.Layers;

import robotlegs.bender.bundles.mvcs.Mediator;

public class GameObjectArrowMediator extends Mediator {

      [Inject]
      public var view:LOEBUILD_4a59873dd40437adf7708a4430a17690;

      [Inject]
      public var layers:Layers;

      public function GameObjectArrowMediator() {
         super();
      }

      override public function initialize() : void {
         this.view.menuLayer = this.layers.top;
      }
   }
}
