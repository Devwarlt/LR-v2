package kabam.rotmg.ui.view {
import com.company.assembleegameclient.LOEBUILD_96062b2d312b581d94ca7a4e277ffe2a.LOEBUILD_81ade24e8daf8d0d9cbf110052ac9011;

import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.servers.api.ServerModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class MapEditorMediator extends Mediator {

      [Inject]
      public var view:LOEBUILD_81ade24e8daf8d0d9cbf110052ac9011;

      [Inject]
      public var model:PlayerModel;

      [Inject]
      public var servers:ServerModel;

      public function MapEditorMediator() {
         super();
      }

      override public function initialize() : void {
         this.view.initialize(this.model,this.servers.getServer());
      }
   }
}
